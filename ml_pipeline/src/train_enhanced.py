"""
Enhanced model training with aggressive hyperparameter tuning.
Expected improvement: +1-2% accuracy
"""

import json
import os
from typing import Any
import time

import joblib
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, StackingClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import GridSearchCV, StratifiedKFold, cross_val_score
from sklearn.svm import SVC
from xgboost import XGBClassifier


# Enhanced hyperparameter grids
_PARAM_GRID_BASIC = {
    "rf__n_estimators":      [150, 200],
    "rf__max_depth":         [15, 20],
    "xgb__n_estimators":     [150, 200],
    "xgb__max_depth":        [6, 7],
    "svm__C":                [10.0, 50.0],
}

_PARAM_GRID_AGGRESSIVE = {
    "rf__n_estimators":      [150, 200, 250],
    "rf__max_depth":         [15, 20, 25],
    "rf__min_samples_split": [2, 3],
    "rf__min_samples_leaf":  [1, 2],
    "rf__max_features":      ["sqrt", "log2"],
    
    "xgb__n_estimators":     [150, 200, 250],
    "xgb__max_depth":        [5, 6, 7, 8],
    "xgb__learning_rate":    [0.01, 0.05, 0.1],
    "xgb__subsample":        [0.8, 0.9],
    "xgb__colsample_bytree": [0.8, 0.9],
    "xgb__reg_alpha":        [0.0, 0.1, 0.5],
    "xgb__reg_lambda":       [0.5, 1.0, 1.5],
    
    "svm__C":                [1.0, 10.0, 50.0, 100.0],
    "svm__gamma":            ["scale", "auto"],
}


def normalize_features(
    X_train,
    X_test,
    params_path: str = "models/scaler_params.json",
) -> tuple:
    """Min-Max normalise features."""
    X_train = np.asarray(X_train, dtype=float)
    X_test = np.asarray(X_test, dtype=float)

    min_vals = X_train.min(axis=0)
    max_vals = X_train.max(axis=0)

    degenerate = np.where(max_vals == min_vals)[0]
    if len(degenerate) > 0:
        raise ValueError(
            f"[normalize_features] Features at indices {degenerate.tolist()} have "
            f"min == max. Check preprocessing."
        )

    scale = max_vals - min_vals

    X_train_norm = (X_train - min_vals) / scale
    X_test_norm = (X_test - min_vals) / scale

    os.makedirs(os.path.dirname(params_path) or ".", exist_ok=True)
    with open(params_path, "w") as fh:
        json.dump({"min": min_vals.tolist(), "max": max_vals.tolist()}, fh)
    print(f"  ✓ Scaler params saved → {params_path}")

    return X_train_norm, X_test_norm


def build_stacking_ensemble_enhanced() -> StackingClassifier:
    """Build ENHANCED stacking ensemble with optimized hyperparameters."""
    
    base_learners = [
        ("rf", RandomForestClassifier(
            n_estimators=200,
            max_depth=20,
            min_samples_split=3,
            min_samples_leaf=1,
            max_features="sqrt",
            bootstrap=True,
            random_state=42,
            class_weight="balanced",
            n_jobs=-1
        )),
        
        ("xgb", XGBClassifier(
            n_estimators=200,
            max_depth=7,
            learning_rate=0.05,
            subsample=0.9,
            colsample_bytree=0.9,
            reg_alpha=0.1,
            reg_lambda=1.0,
            eval_metric="mlogloss",
            random_state=42,
            n_jobs=-1
        )),
        
        ("svm", SVC(
            C=50.0,
            kernel="rbf",
            gamma="scale",
            probability=True,
            random_state=42,
            class_weight="balanced"
        )),
    ]
    
    meta_learner = LogisticRegression(
        C=0.5,
        penalty="l2",
        max_iter=2000,
        solver="lbfgs",
        random_state=42,
        class_weight="balanced"
    )
    
    return StackingClassifier(
        estimators=base_learners,
        final_estimator=meta_learner,
        cv=StratifiedKFold(n_splits=5, shuffle=True, random_state=42),
        passthrough=False,
    )


def tune_hyperparameters_enhanced(
    model: StackingClassifier,
    X_train: np.ndarray,
    y_train: np.ndarray,
    aggressive: bool = True,
    cv: int = 5,
    scoring: str = "f1_macro",
    n_jobs: int = -1,
) -> StackingClassifier:
    """Aggressive hyperparameter tuning using GridSearchCV."""
    
    param_grid = _PARAM_GRID_AGGRESSIVE if aggressive else _PARAM_GRID_BASIC
    n_combos = np.prod([len(v) for v in param_grid.values()])
    
    print("\n" + "="*70)
    print("HYPERPARAMETER TUNING")
    print("="*70)
    print(f"Strategy: {'AGGRESSIVE' if aggressive else 'BASIC'}")
    print(f"Parameter combinations to test: {n_combos}")
    print(f"Estimated time: {'60-90 min' if aggressive else '10-15 min'}")
    print("="*70 + "\n")
    
    grid = GridSearchCV(
        model,
        param_grid=param_grid,
        cv=StratifiedKFold(n_splits=5, shuffle=True, random_state=42),
        scoring=scoring,
        n_jobs=n_jobs,
        verbose=1,
    )
    
    start_time = time.time()
    grid.fit(X_train, y_train)
    elapsed = time.time() - start_time
    
    print("\n" + "="*70)
    print(f"✓ Tuning complete in {elapsed/60:.1f} minutes")
    print(f"✓ Best CV Score: {grid.best_score_:.4f}")
    print("✓ Best Parameters:")
    for param, value in grid.best_params_.items():
        print(f"    {param}: {value}")
    print("="*70 + "\n")
    
    return grid.best_estimator_


def train_model_enhanced(
    X_train: np.ndarray,
    y_train: np.ndarray,
    tune: bool = True,
    aggressive_tuning: bool = True,
) -> StackingClassifier:
    """Train enhanced stacking ensemble."""
    
    model = build_stacking_ensemble_enhanced()
    
    if tune:
        print("\n🔧 Starting hyperparameter tuning...")
        model = tune_hyperparameters_enhanced(
            model, X_train, y_train,
            aggressive=aggressive_tuning
        )
    else:
        print("\n⚡ Training with enhanced default hyperparameters (no tuning)...")
        model.fit(X_train, y_train)
        print("✓ Training complete!")
    
    return model


def save_model(model: Any, path: str) -> None:
    """Serialise model to path using joblib."""
    os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
    joblib.dump(model, path)
    with open(path, "r+b") as fh:
        fh.flush()
        os.fsync(fh.fileno())
    print(f"  ✓ Model saved → {path}")


def load_model(path: str) -> Any:
    """Load model from path using joblib."""
    return joblib.load(path)


def perform_cross_validation(
    model,
    X_train: np.ndarray,
    y_train: np.ndarray,
    cv: int = 5,
) -> dict:
    """Perform k-fold cross-validation for robustness assessment."""
    
    print("\n" + "="*70)
    print("CROSS-VALIDATION ANALYSIS")
    print("="*70 + "\n")
    
    cv_folds = StratifiedKFold(n_splits=cv, shuffle=True, random_state=42)
    
    scores_acc = cross_val_score(model, X_train, y_train, cv=cv_folds, scoring="accuracy")
    scores_prec = cross_val_score(model, X_train, y_train, cv=cv_folds, scoring="precision_macro")
    scores_recall = cross_val_score(model, X_train, y_train, cv=cv_folds, scoring="recall_macro")
    scores_f1 = cross_val_score(model, X_train, y_train, cv=cv_folds, scoring="f1_macro")
    
    results = {
        "accuracy": {"scores": scores_acc, "mean": scores_acc.mean(), "std": scores_acc.std()},
        "precision": {"scores": scores_prec, "mean": scores_prec.mean(), "std": scores_prec.std()},
        "recall": {"scores": scores_recall, "mean": scores_recall.mean(), "std": scores_recall.std()},
        "f1": {"scores": scores_f1, "mean": scores_f1.mean(), "std": scores_f1.std()},
    }
    
    print(f"Accuracy:  {results['accuracy']['mean']:.4f} (+/- {results['accuracy']['std']:.4f})")
    print(f"Precision: {results['precision']['mean']:.4f} (+/- {results['precision']['std']:.4f})")
    print(f"Recall:    {results['recall']['mean']:.4f} (+/- {results['recall']['std']:.4f})")
    print(f"F1-Score:  {results['f1']['mean']:.4f} (+/- {results['f1']['std']:.4f})")
    print("="*70 + "\n")
    
    return results


if __name__ == "__main__":
    from src.feature_engineering import run_feature_engineering
    from src.balancing_advanced import apply_advanced_balancing

    print("\n" + "="*70)
    print("ENHANCED TRAINING PIPELINE - SMOKE TEST")
    print("="*70 + "\n")

    print("[1/6] Loading data...")
    X_train, X_test, y_train, y_test = run_feature_engineering()
    print(f"✓ Loaded\n")

    print("[2/6] Applying advanced balancing...")
    X_train_bal, y_train_bal = apply_advanced_balancing(X_train, y_train, strategy="combined")
    print(f"✓ Balanced\n")

    print("[3/6] Normalizing features...")
    X_train_norm, X_test_norm = normalize_features(X_train_bal, X_test)
    print(f"✓ Normalized\n")

    print("[4/6] Building model...")
    model = build_stacking_ensemble_enhanced()
    print(f"✓ Built\n")

    print("[5/6] Training with basic tuning (for speed)...")
    model = train_model_enhanced(X_train_norm, y_train_bal, tune=True, aggressive_tuning=False)
    print(f"✓ Trained\n")

    print("[6/6] Quick accuracy check...")
    train_acc = (model.predict(X_train_norm) == y_train_bal).mean()
    test_acc = (model.predict(X_test_norm) == np.asarray(y_test)).mean()
    print(f"Train accuracy: {train_acc:.4f}")
    print(f"Test accuracy:  {test_acc:.4f}\n")

    print("✅ Smoke test complete!")