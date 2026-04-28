"""
Moderate hyperparameter tuning - 15-20 minutes
Balance between accuracy and computation time
"""

import json
import os
import time
import joblib
import numpy as np
from sklearn.ensemble import RandomForestClassifier, StackingClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import GridSearchCV, StratifiedKFold
from sklearn.svm import SVC
from xgboost import XGBClassifier


# MODERATE grid - ~146 combinations
_PARAM_GRID_MODERATE = {
    "rf__n_estimators":      [150, 200],
    "rf__max_depth":         [15, 20, 25],
    "rf__min_samples_split": [2, 3],
    "rf__max_features":      ["sqrt"],
    
    "xgb__n_estimators":     [150, 200],
    "xgb__max_depth":        [6, 7],
    "xgb__learning_rate":    [0.03, 0.05, 0.08],
    "xgb__subsample":        [0.8, 0.9],
    "xgb__reg_lambda":       [1.0],
    
    "svm__C":                [10.0, 50.0],
    "svm__gamma":            ["scale"],
}


def build_stacking_ensemble_enhanced() -> StackingClassifier:
    """Enhanced stacking ensemble."""
    
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


def tune_hyperparameters_moderate(
    model: StackingClassifier,
    X_train: np.ndarray,
    y_train: np.ndarray,
    cv: int = 5,
    n_jobs: int = -1,
) -> StackingClassifier:
    """MODERATE tuning - 15-20 minutes"""
    
    n_combos = np.prod([len(v) for v in _PARAM_GRID_MODERATE.values()])
    
    print("\n" + "="*70)
    print("MODERATE HYPERPARAMETER TUNING")
    print("="*70)
    print(f"Parameter combinations: {n_combos}")
    print(f"Estimated time: 15-20 min")
    print(f"Total model fits: {int(n_combos * cv)}")
    print("="*70 + "\n")
    
    grid = GridSearchCV(
        model,
        param_grid=_PARAM_GRID_MODERATE,
        cv=StratifiedKFold(n_splits=5, shuffle=True, random_state=42),
        scoring="f1_macro",
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


if __name__ == "__main__":
    print("Moderate tuning module ready!")