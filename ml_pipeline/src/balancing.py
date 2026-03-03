"""
balancing.py
------------
SMOTE oversampling for imbalanced training sets.
"""

from __future__ import annotations

import numpy as np
import pandas as pd
from imblearn.over_sampling import SMOTE


def apply_smote(
    X_train: pd.DataFrame | np.ndarray,
    y_train: pd.Series | np.ndarray,
    k_neighbors: int = 5,
    random_state: int = 42,
) -> tuple[np.ndarray, np.ndarray]:
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
    tuple[np.ndarray, np.ndarray]
        Resampled (X_resampled, y_resampled).
    """
    smote = SMOTE(k_neighbors=k_neighbors, random_state=random_state)
    X_res, y_res = smote.fit_resample(X_train, y_train)
    return X_res, y_res
