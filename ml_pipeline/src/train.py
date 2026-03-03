"""
train.py
--------
Model training pipeline: normalisation, stacking ensemble, hyperparameter
tuning, and model persistence.
"""

from __future__ import annotations

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
    X_train: pd.DataFrame | np.ndarray,
    X_test: pd.DataFrame | np.ndarray,
    params_path: str = "models/scaler_params.json",
) -> tuple[np.ndarray, np.ndarray]:
    """Min-Max normalise features.

    Fits on *X_train* and applies the same transformation to *X_test*.
    Scaler parameters are serialised to *params_path* as JSON.

    Parameters
    ----------
    X_train : array-like
    X_test : array-like
    params_path : str

    Returns
    -------
    tuple[np.ndarray, np.ndarray]
        (X_train_norm, X_test_norm)
    """
    X_train = np.asarray(X_train, dtype=float)
    X_test = np.asarray(X_test, dtype=float)

    min_vals = X_train.min(axis=0)
    max_vals = X_train.max(axis=0)
    scale = np.where(max_vals - min_vals == 0, 1.0, max_vals - min_vals)

    X_train_norm = (X_train - min_vals) / scale
    X_test_norm = (X_test - min_vals) / scale

    os.makedirs(os.path.dirname(params_path) or ".", exist_ok=True)
    with open(params_path, "w") as fh:
        json.dump({"min": min_vals.tolist(), "max": max_vals.tolist()}, fh)

    return X_train_norm, X_test_norm


# ---------------------------------------------------------------------------
# Model construction
# ---------------------------------------------------------------------------

def build_stacking_ensemble() -> StackingClassifier:
    """Build a stacking ensemble classifier.

    Base learners
    -------------
    * RandomForestClassifier
    * XGBClassifier
    * SVC(probability=True, kernel='rbf')

    Meta-learner
    ------------
    * LogisticRegression(penalty='l2')

    Returns
    -------
    StackingClassifier
    """
    base_learners = [
        ("rf", RandomForestClassifier(n_estimators=100, random_state=42)),
        ("xgb", XGBClassifier(
            use_label_encoder=False,
            eval_metric="mlogloss",
            random_state=42,
        )),
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

_PARAM_GRID: dict[str, list[Any]] = {
    "rf__n_estimators": [100, 200],
    "rf__max_depth": [None, 10, 20],
    "xgb__n_estimators": [100, 200],
    "xgb__max_depth": [3, 6],
    "svm__C": [0.1, 1.0, 10.0],
}


def tune_hyperparameters(
    model: StackingClassifier,
    X_train: np.ndarray,
    y_train: np.ndarray,
    cv: int = 5,
    scoring: str = "f1_macro",
) -> StackingClassifier:
    """GridSearchCV hyperparameter tuning with *cv*-fold cross-validation.

    Parameters
    ----------
    model : StackingClassifier
    X_train : np.ndarray
    y_train : np.ndarray
    cv : int
    scoring : str

    Returns
    -------
    StackingClassifier
        Best estimator found by grid search.
    """
    grid = GridSearchCV(
        model,
        param_grid=_PARAM_GRID,
        cv=cv,
        scoring=scoring,
        n_jobs=-1,
        verbose=1,
    )
    grid.fit(X_train, y_train)
    print(f"Best params: {grid.best_params_}")
    return grid.best_estimator_


# ---------------------------------------------------------------------------
# Full training entry-point
# ---------------------------------------------------------------------------

def train_model(
    X_train: np.ndarray,
    y_train: np.ndarray,
    tune: bool = False,
) -> StackingClassifier:
    """Build (and optionally tune) the stacking ensemble, then fit it.

    Parameters
    ----------
    X_train : np.ndarray
    y_train : np.ndarray
    tune : bool
        When ``True``, runs :func:`tune_hyperparameters` before fitting.

    Returns
    -------
    StackingClassifier
        Fitted model.
    """
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
    """Serialise *model* to *path* using joblib.

    Parameters
    ----------
    model : Any
        Fitted scikit-learn–compatible model.
    path : str
        Destination file path (e.g. ``'models/stacking_model.pkl'``).
    """
    os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
    joblib.dump(model, path)
    print(f"Model saved to {path}")
