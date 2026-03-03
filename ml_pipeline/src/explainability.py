"""
explainability.py
-----------------
SHAP global and local explanations for the stacking ensemble.
"""

from __future__ import annotations

import json
import os
from typing import Any

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import shap


# ---------------------------------------------------------------------------
# SHAP value computation
# ---------------------------------------------------------------------------

def compute_shap_values(
    model,
    X_train: np.ndarray | pd.DataFrame,
    X_test: np.ndarray | pd.DataFrame,
    background_samples: int = 100,
) -> list[np.ndarray]:
    """Compute SHAP values for each class using the most appropriate explainer.

    * TreeExplainer is attempted for RF and XGBoost sub-models when the
      final model exposes them directly.
    * KernelExplainer is used as a fallback (e.g. for SVM-based stacking
      pipelines or any estimator that does not support TreeExplainer).

    Parameters
    ----------
    model : fitted classifier with ``predict_proba``
    X_train : array-like
        Background data for KernelExplainer.
    X_test : array-like
        Samples to explain.
    background_samples : int
        Number of background samples used by KernelExplainer.

    Returns
    -------
    list[np.ndarray]
        SHAP values per class, each of shape (n_samples, n_features).
    """
    X_train_arr = np.asarray(X_train)
    X_test_arr = np.asarray(X_test)

    # Try TreeExplainer first (fast and exact for tree-based models)
    try:
        explainer = shap.TreeExplainer(model)
        shap_values = explainer.shap_values(X_test_arr)
        return shap_values
    except Exception:
        pass

    # Fall back to KernelExplainer
    background = shap.kmeans(X_train_arr, min(background_samples, len(X_train_arr)))
    explainer = shap.KernelExplainer(model.predict_proba, background)
    shap_values = explainer.shap_values(X_test_arr)
    return shap_values


# ---------------------------------------------------------------------------
# Visualisation
# ---------------------------------------------------------------------------

def plot_shap_summary(
    shap_values: list[np.ndarray] | np.ndarray,
    X_test: np.ndarray | pd.DataFrame,
    feature_names: list[str] | None = None,
    output_dir: str = "reports",
    filename: str = "shap_summary.png",
) -> None:
    """Save a global SHAP summary bar plot.

    Parameters
    ----------
    shap_values : list[np.ndarray] | np.ndarray
    X_test : array-like
    feature_names : list[str] | None
    output_dir : str
    filename : str
    """
    os.makedirs(output_dir, exist_ok=True)
    fig, ax = plt.subplots(figsize=(10, 6))

    shap.summary_plot(
        shap_values,
        X_test,
        feature_names=feature_names,
        plot_type="bar",
        show=False,
    )
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, filename))
    plt.close()
    print(f"SHAP summary plot saved to {os.path.join(output_dir, filename)}")


# ---------------------------------------------------------------------------
# Local explanations
# ---------------------------------------------------------------------------

def get_local_shap_explanation(
    shap_values: list[np.ndarray] | np.ndarray,
    index: int,
    feature_names: list[str] | None = None,
    top_n: int = 5,
) -> list[dict[str, Any]]:
    """Return the top *top_n* features with SHAP direction for one prediction.

    When *shap_values* is a list (multi-class), the class with the highest
    mean absolute SHAP for the given index is used.

    Parameters
    ----------
    shap_values : list[np.ndarray] | np.ndarray
    index : int
        Row index in the test set to explain.
    feature_names : list[str] | None
    top_n : int

    Returns
    -------
    list[dict]
        Sorted list (descending |SHAP|) of
        ``{'feature': str, 'shap_value': float, 'direction': str}``.
    """
    if isinstance(shap_values, list):
        # Pick the class with the largest absolute SHAP for this sample
        abs_per_class = [np.abs(sv[index]).sum() for sv in shap_values]
        class_idx = int(np.argmax(abs_per_class))
        values = shap_values[class_idx][index]
    else:
        values = shap_values[index]

    n_features = len(values)
    names = (
        feature_names
        if feature_names is not None
        else [f"feature_{i}" for i in range(n_features)]
    )

    pairs = sorted(zip(names, values), key=lambda x: abs(x[1]), reverse=True)
    return [
        {
            "feature": name,
            "shap_value": float(val),
            "direction": "positive" if val >= 0 else "negative",
        }
        for name, val in pairs[:top_n]
    ]


# ---------------------------------------------------------------------------
# Persistence
# ---------------------------------------------------------------------------

def save_shap_values(
    shap_values: list[np.ndarray] | np.ndarray,
    path: str,
    feature_names: list[str] | None = None,
) -> None:
    """Serialise SHAP values to a JSON file for embedding in the Flutter app.

    The JSON structure is::

        {
            "feature_names": [...],
            "shap_values": [
                // per-class list
                [[...], [...], ...]   // shape: (n_samples, n_features)
            ]
        }

    Parameters
    ----------
    shap_values : list[np.ndarray] | np.ndarray
    path : str
    feature_names : list[str] | None
    """
    os.makedirs(os.path.dirname(path) or ".", exist_ok=True)

    if not isinstance(shap_values, list):
        shap_values = [shap_values]

    n_features = shap_values[0].shape[1]
    names = feature_names or [f"feature_{i}" for i in range(n_features)]

    payload = {
        "feature_names": names,
        "shap_values": [sv.tolist() for sv in shap_values],
    }
    with open(path, "w") as fh:
        json.dump(payload, fh)
    print(f"SHAP values saved to {path}")
