"""
robustness.py
-------------
Robustness of the deployed model (ONNX file shipped in the Flutter app) on the
held-out test set to (1) realistic measurement noise in the raw inputs and
(2) a missing input imputed with the training median, the pipeline's own rule.
Derived features are recomputed exactly as in the app's buildInputTensor().

Run from ml_pipeline/:
    python -m src.robustness
"""
from __future__ import annotations

import json

import numpy as np
import onnxruntime as ort
import pandas as pd
from sklearn.metrics import accuracy_score, roc_auc_score

from src.export_explainer_assets import FEATURES, MODEL_PATH, SCALER_PATH, normalise
from src.feature_engineering import run_feature_engineering

THRESHOLD_PATH = "../flutter_app/assets/scaler/decision_threshold.json"
REPORT_OUT = "reports/binary/robustness.json"
REPEATS = 30

# Typical point-of-care measurement error (1 SD) per raw input.
NOISE_SD = {
    "SystolicBP": 5.0, "DiastolicBP": 5.0, "HeartRate": 5.0,  # mmHg, bpm
    "BloodSugar": 0.5, "BodyTemp": 0.4,                       # mmol/L, degF
    "BMI": 0.5, "Weight": 1.0, "Height": 0.01,                # kg/m2, kg, m
}
NOISE_LEVELS = [0.5, 1.0, 2.0]

# Inputs a primary health centre may be unable to measure or record.
MISSABLE = {
    "BloodSugar": ["BloodSugar"],
    "BodyTemp": ["BodyTemp"],
    "HeartRate": ["HeartRate"],
    "Weight/Height/BMI": ["Weight", "Height", "BMI"],
    "Medical history": ["PreviousComplications", "PreexistingDiabetes", "GestationalDiabetes"],
}


def derive(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df["PulsePressure"] = df["SystolicBP"] - df["DiastolicBP"]
    df["ShockIndex"] = np.where(df["SystolicBP"] != 0, df["HeartRate"] / df["SystolicBP"], 0.0)
    df["MAP"] = df["DiastolicBP"] + df["PulsePressure"] / 3
    df["HypertensionFlag"] = ((df["SystolicBP"] >= 130) | (df["DiastolicBP"] >= 85)).astype(float)
    df["TachycardiaFlag"] = (df["HeartRate"] >= 100).astype(float)
    df["DiabetesRisk"] = df["BloodSugar"] * (1 + df["PreexistingDiabetes"] + df["GestationalDiabetes"])
    df["AgeRiskFlag"] = ((df["Age"] < 18) | (df["Age"] > 35)).astype(float)
    return df[FEATURES]


def main() -> None:
    X_train, X_test, _, y_test = run_feature_engineering()
    X_train, X_test = pd.DataFrame(X_train)[FEATURES], pd.DataFrame(X_test)[FEATURES]
    y = (np.asarray(y_test) == np.asarray(y_test).max()).astype(int)
    sc = json.load(open(SCALER_PATH))
    thr = json.load(open(THRESHOLD_PATH))["threshold"]
    sess = ort.InferenceSession(MODEL_PATH)

    def score(df: pd.DataFrame):
        p = sess.run(["probabilities"], {"float_input": normalise(df.to_numpy(float), sc)})[0][:, 1]
        return p, (p >= thr).astype(int)

    base_p, base_pred = score(X_test)
    baseline = {"auroc": roc_auc_score(y, base_p), "accuracy": accuracy_score(y, base_pred)}
    derived_ok = np.allclose(derive(X_test).to_numpy(float), X_test.to_numpy(float), atol=1e-6)

    rng = np.random.default_rng(42)
    noise = []
    for level in NOISE_LEVELS:
        aucs, accs, flips, missed = [], [], [], []
        for _ in range(REPEATS):
            df = X_test.copy()
            for col, sd in NOISE_SD.items():
                df[col] = df[col] + rng.normal(0, sd * level, len(df))
            p, pred = score(derive(df))
            aucs.append(roc_auc_score(y, p)); accs.append(accuracy_score(y, pred))
            flips.append((pred != base_pred).mean())
            missed.append(((base_pred == 1) & (pred == 0) & (y == 1)).sum())
        noise.append({
            "noise_multiplier": level,
            "auroc_mean": float(np.mean(aucs)), "auroc_min": float(np.min(aucs)),
            "accuracy_mean": float(np.mean(accs)), "accuracy_min": float(np.min(accs)),
            "prediction_flip_rate_mean": float(np.mean(flips)),
            "true_high_risk_newly_missed_mean": float(np.mean(missed)),
        })

    medians = X_train.median()
    missing = []
    for name, cols in MISSABLE.items():
        df = X_test.copy()
        for c in cols:
            df[c] = medians[c]
        p, pred = score(derive(df))
        missing.append({
            "missing_input": name,
            "auroc": float(roc_auc_score(y, p)), "accuracy": float(accuracy_score(y, pred)),
            "prediction_flip_rate": float((pred != base_pred).mean()),
            "sensitivity": float(pred[y == 1].mean()), "specificity": float(1 - pred[y == 0].mean()),
        })

    report = {
        "n_test": int(len(y)), "decision_threshold": thr,
        "baseline": {**{k: float(v) for k, v in baseline.items()},
                     "sensitivity": float(base_pred[y == 1].mean()),
                     "specificity": float(1 - base_pred[y == 0].mean())},
        "derived_features_reproduced": bool(derived_ok),
        "noise_sd_at_multiplier_1": NOISE_SD, "repeats": REPEATS,
        "measurement_noise": noise, "missing_input_median_imputed": missing,
    }
    json.dump(report, open(REPORT_OUT, "w"), indent=2)
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
