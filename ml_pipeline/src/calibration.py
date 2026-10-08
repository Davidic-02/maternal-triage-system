"""
calibration.py
--------------
Calibration of the deployed model (the ONNX file shipped in the Flutter app)
on the held-out test set: reliability diagram, expected calibration error,
Brier score, and logistic calibration intercept/slope.

Run from ml_pipeline/:
    python -m src.calibration
"""
from __future__ import annotations

import json

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import onnxruntime as ort
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import brier_score_loss

from src.export_explainer_assets import MODEL_PATH, SCALER_PATH, normalise
from src.feature_engineering import run_feature_engineering

N_BINS = 10
REPORT_OUT = "reports/binary/calibration.json"
FIGURE_OUT = "reports/binary/calibration_reliability.png"


def expected_calibration_error(y: np.ndarray, p: np.ndarray, n_bins: int = N_BINS) -> tuple[float, list]:
    edges = np.linspace(0, 1, n_bins + 1)
    ece, bins = 0.0, []
    for lo, hi in zip(edges[:-1], edges[1:]):
        m = (p >= lo) & ((p < hi) if hi < 1 else (p <= hi))
        if not m.any():
            continue
        conf, acc = p[m].mean(), y[m].mean()
        ece += m.mean() * abs(acc - conf)
        bins.append({"lo": float(lo), "hi": float(hi), "n": int(m.sum()),
                     "mean_predicted": float(conf), "observed_rate": float(acc)})
    return float(ece), bins


def main() -> None:
    _, X_test, _, y_test = run_feature_engineering()
    sc = json.load(open(SCALER_PATH))
    X = normalise(np.asarray(X_test, float), sc)
    y_raw = np.asarray(y_test)
    y = (y_raw == y_raw.max()).astype(int)

    sess = ort.InferenceSession(MODEL_PATH)
    p = sess.run(["probabilities"], {"float_input": X})[0][:, 1]

    ece, bins = expected_calibration_error(y, p)
    logit = np.log(np.clip(p, 1e-6, 1 - 1e-6) / np.clip(1 - p, 1e-6, 1))
    lr = LogisticRegression(C=1e6).fit(logit.reshape(-1, 1), y)
    report = {
        "n_test": int(len(y)), "prevalence_high": float(y.mean()),
        "mean_predicted_high": float(p.mean()),
        "ece_10_bins": ece, "brier": float(brier_score_loss(y, p)),
        "calibration_intercept": float(lr.intercept_[0]), "calibration_slope": float(lr.coef_[0][0]),
        "bins": bins,
    }
    json.dump(report, open(REPORT_OUT, "w"), indent=2)

    fig, (ax, hx) = plt.subplots(2, 1, figsize=(5, 6.2), sharex=True,
                                 gridspec_kw={"height_ratios": [3, 1]})
    ax.plot([0, 1], [0, 1], "--", color="grey", label="Perfect calibration")
    xs = [b["mean_predicted"] for b in bins]; ys = [b["observed_rate"] for b in bins]
    ax.plot(xs, ys, "-", color="tab:blue", alpha=0.4)
    ax.scatter(xs, ys, s=[20 + 3 * b["n"] ** 0.9 for b in bins], color="tab:blue",
               label=f"Stacking ensemble (ECE = {ece:.3f})", zorder=3)
    for b in bins:
        ax.annotate(f"n={b['n']}", (b["mean_predicted"], b["observed_rate"]),
                    textcoords="offset points", xytext=(6, -10), fontsize=7)
    ax.set_ylabel("Observed proportion high risk")
    ax.set_xlim(0, 1); ax.set_ylim(-0.03, 1.05); ax.legend(loc="upper left", fontsize=8)
    hx.hist(p, bins=np.linspace(0, 1, N_BINS + 1), color="tab:blue", alpha=0.6)
    hx.set_yscale("log"); hx.set_ylabel("Patients (log)")
    hx.set_xlabel("Predicted probability of high risk")
    fig.tight_layout(); fig.savefig(FIGURE_OUT, dpi=300)
    print(json.dumps({k: v for k, v in report.items() if k != "bins"}, indent=2))


if __name__ == "__main__":
    main()
