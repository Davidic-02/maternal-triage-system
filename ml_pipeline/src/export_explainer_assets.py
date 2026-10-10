"""
export_explainer_assets.py
--------------------------
Exports the background set the Flutter app uses to compute per-patient
Shapley explanations on-device, and validates the on-device estimator
(permutation sampling, mirrored here in Python) against shap.KernelExplainer
using the same model, background and output (P(high risk)).

Run from ml_pipeline/:
    python -m src.export_explainer_assets
"""
from __future__ import annotations

import json
import time

import numpy as np
import onnxruntime as ort
import shap

from src.feature_engineering import run_feature_engineering

FEATURES = [
    "Age", "SystolicBP", "DiastolicBP", "BloodSugar", "BodyTemp", "BMI",
    "HeartRate", "Weight", "Height", "PreviousComplications",
    "PreexistingDiabetes", "GestationalDiabetes", "PulsePressure",
    "ShockIndex", "MAP", "HypertensionFlag", "TachycardiaFlag",
    "DiabetesRisk", "AgeRiskFlag",
]
MODEL_PATH = "../flutter_app/assets/models/maternal_triage_model.onnx"
SCALER_PATH = "../flutter_app/assets/scaler/scaler_params.json"
BACKGROUND_OUT = "../flutter_app/assets/shap/background.json"
MEDIANS_OUT = "../flutter_app/assets/scaler/feature_medians.json"
REPORT_OUT = "reports/binary/explanation_validation.json"

N_BACKGROUND = 16      # k-means centroids shipped to the device
N_PERMUTATIONS = 64    # must match kShapPermutations in shap_service.dart
SEED = 42              # must match kShapSeed in shap_service.dart
N_VALIDATE = 100


def normalise(X: np.ndarray, sc: dict) -> np.ndarray:
    lo, hi = np.asarray(sc["min"]), np.asarray(sc["max"])
    scale = np.where(hi - lo == 0, 1.0, hi - lo)
    return np.clip((X - lo) / scale, 0.0, 1.0).astype(np.float32)


class OnnxHighRisk:
    def __init__(self, path: str):
        self.sess = ort.InferenceSession(path)

    def __call__(self, X: np.ndarray) -> np.ndarray:
        out = self.sess.run(["probabilities"], {"float_input": np.asarray(X, np.float32)})[0]
        return out[:, 1]


def permutation_shapley(f, x, background, weights, n_perm=N_PERMUTATIONS, seed=SEED):
    """Monte-Carlo Shapley values with antithetic permutations.

    Mirrors ShapService.explain() in the Flutter app line for line: for each
    permutation a background row is drawn by weight, features are switched from
    background to patient values in permutation order, and each feature is
    credited with the change in P(high). All rows go through one batched call.
    """
    rng = np.random.default_rng(seed)
    d = len(x)
    rows, orders, perm_bg = [], [], []
    cum = np.cumsum(weights) / np.sum(weights)
    for k in range(n_perm // 2):
        p = rng.permutation(d)
        for order in (p, p[::-1]):
            b = background[min(int(np.searchsorted(cum, rng.random())), len(background) - 1)]
            z = b.copy()
            rows.append(z.copy())
            for j in order:
                z[j] = x[j]
                rows.append(z.copy())
            orders.append(order)
            perm_bg.append(b)
    preds = f(np.stack(rows))
    phi = np.zeros(d)
    base = 0.0
    step = d + 1
    for i, order in enumerate(orders):
        block = preds[i * step:(i + 1) * step]
        base += block[0]
        phi[order] += np.diff(block)
    n = len(orders)
    return phi / n, base / n


def main() -> None:
    X_train, X_test, y_train, y_test = run_feature_engineering()
    med = {c: float(v) for c, v in X_train[["Weight", "Height", "BMI"]].median().items()}
    json.dump({**med, "note": "training-set medians used to impute missing optional inputs (Height in metres)"},
              open(MEDIANS_OUT, "w"), indent=2)
    print(f"Medians -> {MEDIANS_OUT}: {med}")
    sc = json.load(open(SCALER_PATH))
    Xtr = normalise(np.asarray(X_train, float), sc)
    Xte = normalise(np.asarray(X_test, float), sc)
    assert Xtr.shape[1] == len(FEATURES), Xtr.shape

    km = shap.kmeans(Xtr, N_BACKGROUND)
    bg, w = km.data.astype(np.float32), np.asarray(km.weights, float)
    json.dump(
        {"feature_names": FEATURES, "data": bg.tolist(), "weights": w.tolist(),
         "permutations": N_PERMUTATIONS, "seed": SEED, "output": "P(high risk)"},
        open(BACKGROUND_OUT, "w"),
    )
    print(f"Background ({N_BACKGROUND} centroids) -> {BACKGROUND_OUT}")

    f = OnnxHighRisk(MODEL_PATH)
    idx = np.random.default_rng(0).choice(len(Xte), size=min(N_VALIDATE, len(Xte)), replace=False)
    kernel = shap.KernelExplainer(f, km)

    r, top3, top5, add_err, ms = [], [], [], [], []
    for i in idx:
        x = Xte[i]
        t0 = time.perf_counter()
        phi, base = permutation_shapley(f, x, bg, w)
        ms.append((time.perf_counter() - t0) * 1000)
        ref = np.asarray(kernel.shap_values(x[None, :], nsamples=2048, silent=True)).reshape(-1)
        r.append(np.corrcoef(phi, ref)[0, 1])
        top3.append(len(set(np.argsort(-abs(phi))[:3]) & set(np.argsort(-abs(ref))[:3])) / 3)
        top5.append(len(set(np.argsort(-abs(phi))[:5]) & set(np.argsort(-abs(ref))[:5])) / 5)
        add_err.append(abs(phi.sum() + base - f(x[None, :])[0]))

    report = {
        "n_patients": len(idx),
        "estimator": f"permutation Shapley, {N_PERMUTATIONS} antithetic permutations, {N_BACKGROUND} k-means background points",
        "reference": "shap.KernelExplainer, same model/background/output, nsamples=2048",
        "pearson_r_mean": float(np.nanmean(r)), "pearson_r_min": float(np.nanmin(r)),
        "top3_overlap_mean": float(np.mean(top3)), "top5_overlap_mean": float(np.mean(top5)),
        "additivity_abs_error_max": float(np.max(add_err)),
        "python_ms_per_explanation_median": float(np.median(ms)),
    }
    json.dump(report, open(REPORT_OUT, "w"), indent=2)
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
