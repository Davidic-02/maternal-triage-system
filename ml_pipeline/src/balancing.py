"""
balancing.py
------------
SMOTE oversampling for imbalanced training sets.
"""

import numpy as np
import pandas as pd
from imblearn.over_sampling import SMOTE

def apply_smote(
    X_train,
    y_train,
    k_neighbors: int = 5,
    random_state: int = 42,
) -> tuple:
    """Apply SMOTE to the training set only.

    Parameters
    ----------
    X_train : array-like of shape (n_samples, n_features)
    y_train : array-like of shape (n_samples,)
    k_neighbors : int
        Number of nearest neighbours used by SMOTE.
    random_state : int

    Returns
    -------
    tuple (X_resampled, y_resampled) as numpy arrays.
    """
    smote = SMOTE(k_neighbors=k_neighbors, random_state=random_state)
    X_res, y_res = smote.fit_resample(X_train, y_train)
    return X_res, y_res


# ---------------------------------------------------------------------------
# Smoke-test:  python3 -m src.balancing
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    from src.feature_engineering import run_feature_engineering

    print("── Running feature engineering ���──────────────────────")
    X_train, X_test, y_train, y_test = run_feature_engineering()

    print("\n── Applying SMOTE ────────────────────────────────────")
    print(f"  Before SMOTE — class distribution: {dict(pd.Series(y_train).value_counts().sort_index())}")

    X_res, y_res = apply_smote(X_train, y_train)

    print(f"  After  SMOTE — class distribution: {dict(pd.Series(y_res).value_counts().sort_index())}")
    print(f"  Resampled X shape: {X_res.shape}")
    print(f"  Resampled y shape: {y_res.shape}")
    print("\n── Done ✅ ─────────────────────────────────────────")
