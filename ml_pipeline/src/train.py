"""
train.py
--------
Model training pipeline: normalisation, stacking ensemble, hyperparameter
tuning, and model persistence.
"""

import json
import os
from typing import Any

import joblib
import numpy as np
import pandas as pd
from lightgbm import LGBMClassifier
from sklearn.ensemble import (
    RandomForestClassifier,
    StackingClassifier,
    VotingClassifier,
)
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import GridSearchCV
from sklearn.svm import SVC
from xgboost import XGBClassifier


# ---------------------------------------------------------------------------
# Normalisation
# ---------------------------------------------------------------------------

def normalize_features(
    X_train,
    X_test,
    params_path: str = "models/scaler_params.json",
) -> tuple:
    """Min-Max normalise features.

    Fits on X_train and applies the same transformation to X_test.
    Scaler parameters are serialised to params_path as JSON.

    Returns
    -------
    (X_train_norm, X_test_norm) as numpy arrays
    """
    X_train = np.asarray(X_train, dtype=float)
    X_test  = np.asarray(X_test,  dtype=float)

    min_vals = X_train.min(axis=0)
    max_vals = X_train.max(axis=0)

    # Validate that no feature has min == max, which indicates corrupted/constant
    # training data (e.g. all rows have the same value for a feature).
    degenerate = np.where(max_vals == min_vals)[0]
    if len(degenerate) > 0:
        raise ValueError(
            f"[normalize_features] Features at indices {degenerate.tolist()} have "
            f"min == max. Check preprocessing — constant columns indicate bad encoding "
            f"(e.g. MentalHealthStatus filled with a sentinel value like -1 instead of "
            f"the correct ordinal range 0-3)."
        )

    scale = max_vals - min_vals

    X_train_norm = (X_train - min_vals) / scale
    X_test_norm  = (X_test  - min_vals) / scale

    os.makedirs(os.path.dirname(params_path) or ".", exist_ok=True)
    with open(params_path, "w") as fh:
        json.dump({"min": min_vals.tolist(), "max": max_vals.tolist()}, fh)
    print(f"  [normalize_features] Scaler params saved -> {params_path}")

    return X_train_norm, X_test_norm


# ---------------------------------------------------------------------------
# Model construction
# ---------------------------------------------------------------------------

def build_stacking_ensemble() -> StackingClassifier:
    """Build a stacking ensemble classifier.

    Base learners : RandomForest, XGBoost, SVM(rbf), LightGBM
    Meta-learner  : soft-voting ensemble of XGBoost + LogisticRegression

    The meta-level combines two complementary learners:
      * XGBoost            - non-linear, captures interactions between the
                             base-learner outputs.
      * LogisticRegression - linear, generalises smoothly and guards against
                             the meta-level overfitting the base predictions.
    Soft voting averages their probabilities before the decision threshold is
    applied, giving a more robust final decision than either alone.

    class_weight='balanced' is applied to RF, SVM, and the meta-learners so
    that under-represented risk classes (e.g. MID) are not overwhelmed by the
    majority class during training.
    """
    base_learners = [
        ("rf",  RandomForestClassifier(n_estimators=200, random_state=42, class_weight="balanced")),
        ("xgb", XGBClassifier(eval_metric="mlogloss", random_state=42, class_weight="balanced")),
        ("svm", SVC(probability=True, kernel="rbf", random_state=42, class_weight="balanced")),
        ("lgbm", LGBMClassifier(n_estimators=200, random_state=42, class_weight="balanced", verbose=-1)),
    ]
    # Two complementary meta-learners combined by soft voting. XGBoost handles
    # the non-linear boundary; LogisticRegression contributes a stable linear
    # view and reduces the chance of overfitting at the meta-level.
    meta_xgb = XGBClassifier(
        n_estimators=100,
        max_depth=3,
        learning_rate=0.05,
        eval_metric="mlogloss",
        random_state=42,
        class_weight="balanced",
    )
    meta_lr = LogisticRegression(
        max_iter=1000,
        class_weight="balanced",
        random_state=42,
    )
    meta_learner = VotingClassifier(
        estimators=[("xgb_meta", meta_xgb), ("lr_meta", meta_lr)],
        voting="soft",
        flatten_transform=False,  # required for skl2onnx ONNX export
    )
    return StackingClassifier(
        estimators=base_learners,
        final_estimator=meta_learner,
        cv=5,
        passthrough=True,
    )


# ---------------------------------------------------------------------------
# Hyperparameter tuning
# ---------------------------------------------------------------------------

_PARAM_GRID = {
    "rf__n_estimators":  [100, 200],
    "rf__max_depth":     [None, 10, 20],
    "xgb__n_estimators": [100, 200],
    "xgb__max_depth":    [3, 6],
    "svm__C":            [0.1, 1.0, 10.0],
}


def tune_hyperparameters(
    model: StackingClassifier,
    X_train: np.ndarray,
    y_train: np.ndarray,
    cv: int = 5,
    scoring: str = "f1_macro",
) -> StackingClassifier:
    """GridSearchCV hyperparameter tuning."""
    grid = GridSearchCV(
        model,
        param_grid=_PARAM_GRID,
        cv=cv,
        scoring=scoring,
        n_jobs=-1,
        verbose=1,
    )
    grid.fit(X_train, y_train)
    print(f"  Best params: {grid.best_params_}")
    return grid.best_estimator_


# ---------------------------------------------------------------------------
# Full training entry-point
# ---------------------------------------------------------------------------

def train_model(
    X_train: np.ndarray,
    y_train: np.ndarray,
    tune: bool = False,
) -> StackingClassifier:
    """Build (and optionally tune) the stacking ensemble, then fit it."""
    model = build_stacking_ensemble()
    if tune:
        model = tune_hyperparameters(model, X_train, y_train)
    else:
        model.fit(X_train, y_train)
    return model


# ---------------------------------------------------------------------------
# Model persistence
# ---------------------------------------------------------------------------

def save_model(model: Any, path: str) -> None:
    """Serialise model to path using joblib.

    After writing, the file is explicitly fsync-ed so the OS flushes all
    buffered data to storage before this function returns.  This prevents
    a subsequent process (e.g. convert_model.py) from reading a partially-
    written pickle and raising _pickle.UnpicklingError.
    """
    os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
    joblib.dump(model, path)
    # Flush OS-level write buffers to disk so the file is complete before
    # any other process attempts to read it.  Opening with "r+b" gives a
    # writable descriptor without truncating the file.
    with open(path, "r+b") as fh:
        fh.flush()
        os.fsync(fh.fileno())
    print(f"  Model saved -> {path}")


# ---------------------------------------------------------------------------
# Smoke-test:  python3 -m src.train
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    from src.feature_engineering import run_feature_engineering
    from src.balancing import apply_smote

    print("-- Running feature engineering ---")
    X_train, X_test, y_train, y_test = run_feature_engineering()

    print("\n-- Applying SMOTE ---")
    # SMOTE is applied to the TRAINING set only. The validation and test sets
    # keep their natural class distribution so the threshold and final metrics
    # reflect real-world prevalence.
    X_res, y_res = apply_smote(X_train, y_train)
    print(f"  Balanced train set: {X_res.shape}  classes: {dict(pd.Series(y_res).value_counts().sort_index())}")

    print("\n-- Normalizing features ---")
    # Canonical feature order saved into scaler_params.json (must match
    # Flutter app's _buildInputTensor in inference_service.dart):
    # Canonical 19-feature order (must match the Flutter app's
    # _buildInputTensor in inference_service.dart):
    #   0  Age                 5  BMI                  10 PreexistingDiabetes
    #   1  SystolicBP          6  HeartRate            11 GestationalDiabetes
    #   2  DiastolicBP         7  Weight               12 PulsePressure
    #   3  BloodSugar          8  Height               13 ShockIndex
    #   4  BodyTemp            9  PreviousComplications 14 MAP
    #  15 HypertensionFlag    16 TachycardiaFlag       17 DiabetesRisk
    #  18 AgeRiskFlag
    X_train_norm, X_test_norm = normalize_features(X_res, X_test)

    print("\n-- Training stacking ensemble (this may take ~2 min) ---")
    model = train_model(X_train_norm, y_res)
    print("  Training complete!")

    print("\n-- Saving model ---")
    from src.config import CLASSIFICATION_MODE, IS_BINARY
    # Canonical path (consumed by convert_model.py / the app) + a mode-tagged
    # copy so the binary and three-class models are both preserved on disk.
    save_model(model, "models/stacking_model.pkl")
    save_model(model, f"models/stacking_model_{CLASSIFICATION_MODE}.pkl")

    # In binary mode, compute the Youden-optimal decision threshold on the
    # TRAINING data only (no leakage) and persist it. Inference and evaluation
    # use this threshold instead of plain 0.5/argmax, which lifts accuracy.
    if IS_BINARY:
        from sklearn.metrics import roc_curve
        pos = int(max(model.classes_))   # high-risk label (e.g. 2)
        proba_tr = model.predict_proba(X_train_norm)[:, 1]
        fpr, tpr, thr = roc_curve((y_res == pos).astype(int), proba_tr)
        best_thr = float(thr[int(np.argmax(tpr - fpr))])
        with open("models/decision_threshold.json", "w") as fh:
            json.dump(
                {"threshold": best_thr, "positive_class": pos,
                 "negative_class": int(min(model.classes_))},
                fh,
            )
        print(f"  Youden decision threshold saved -> models/decision_threshold.json "
              f"(threshold={best_thr:.4f}, positive_class={pos})")

    print("\n-- Quick accuracy check ---")
    train_acc = (model.predict(X_train_norm) == y_res).mean()
    print(f"  Train accuracy : {train_acc:.4f}")

    test_acc = (model.predict(X_test_norm) == np.asarray(y_test)).mean()
    print(f"  Test  accuracy : {test_acc:.4f}")

    print("\n-- Done! ---")
