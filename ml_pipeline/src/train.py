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
from sklearn.ensemble import RandomForestClassifier, StackingClassifier
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
    scale    = np.where(max_vals - min_vals == 0, 1.0, max_vals - min_vals)

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

    Base learners : RandomForest, XGBoost, SVM(rbf)
    Meta-learner  : LogisticRegression(L2)
    """
    base_learners = [
        ("rf",  RandomForestClassifier(n_estimators=100, random_state=42)),
        ("xgb", XGBClassifier(eval_metric="mlogloss", random_state=42)),
        ("svm", SVC(probability=True, kernel="rbf", random_state=42)),
    ]
    meta_learner = LogisticRegression(penalty="l2", max_iter=1000, random_state=42)
    return StackingClassifier(
        estimators=base_learners,
        final_estimator=meta_learner,
        cv=5,
        passthrough=False,
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
    """Serialise model to path using joblib."""
    os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
    joblib.dump(model, path)
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
    X_res, y_res = apply_smote(X_train, y_train)
    print(f"  Balanced train set: {X_res.shape}  classes: {dict(pd.Series(y_res).value_counts().sort_index())}")

    print("\n-- Normalizing features ---")
    # Canonical feature order saved into scaler_params.json (must match
    # Flutter app's _buildInputTensor in inference_service.dart):
    #   0  Age                 5  BMI
    #   1  SystolicBP          6  HeartRate
    #   2  DiastolicBP         7  Weight
    #   3  BloodSugar          8  Height
    #   4  BodyTemp            9  PreviousComplications
    #  10  PreexistingDiabetes 11 GestationalDiabetes
    #  12  MentalHealthStatus  13 PulsePressure
    X_train_norm, X_test_norm = normalize_features(X_res, X_test)

    print("\n-- Training stacking ensemble (this may take ~2 min) ---")
    model = train_model(X_train_norm, y_res)
    print("  Training complete!")

    print("\n-- Saving model ---")
    save_model(model, "models/stacking_model.pkl")

    print("\n-- Quick accuracy check ---")
    train_acc = (model.predict(X_train_norm) == y_res).mean()
    print(f"  Train accuracy : {train_acc:.4f}")

    test_acc = (model.predict(X_test_norm) == np.asarray(y_test)).mean()
    print(f"  Test  accuracy : {test_acc:.4f}")

    print("\n-- Done! ---")
