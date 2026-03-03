"""
evaluate.py
-----------
Model evaluation utilities: metrics, confusion matrix, ROC curves, and
Youden-index threshold optimisation.
"""

from __future__ import annotations

import os

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from sklearn.metrics import (
    accuracy_score,
    auc,
    confusion_matrix,
    f1_score,
    precision_score,
    recall_score,
    roc_auc_score,
    roc_curve,
)
from sklearn.preprocessing import label_binarize


# ---------------------------------------------------------------------------
# Core evaluation
# ---------------------------------------------------------------------------

def evaluate_model(
    model,
    X_test: np.ndarray,
    y_test: np.ndarray,
) -> dict:
    """Compute and print classification metrics.

    Parameters
    ----------
    model : fitted classifier
    X_test : np.ndarray
    y_test : np.ndarray

    Returns
    -------
    dict
        Dictionary containing accuracy, precision, recall, f1, auc_roc,
        and the confusion matrix array.
    """
    y_pred = model.predict(X_test)
    y_proba = model.predict_proba(X_test)
    classes = np.unique(y_test)

    acc = accuracy_score(y_test, y_pred)
    prec = precision_score(y_test, y_pred, average="macro", zero_division=0)
    rec = recall_score(y_test, y_pred, average="macro", zero_division=0)
    f1 = f1_score(y_test, y_pred, average="macro", zero_division=0)
    cm = confusion_matrix(y_test, y_pred)

    # AUC-ROC (macro OvR)
    if len(classes) > 2:
        y_bin = label_binarize(y_test, classes=classes)
        auc_roc = roc_auc_score(y_bin, y_proba, multi_class="ovr", average="macro")
    else:
        auc_roc = roc_auc_score(y_test, y_proba[:, 1])

    results = {
        "accuracy": acc,
        "precision": prec,
        "recall": rec,
        "f1": f1,
        "auc_roc": auc_roc,
        "confusion_matrix": cm,
    }

    print(
        f"Accuracy : {acc:.4f}\n"
        f"Precision: {prec:.4f}\n"
        f"Recall   : {rec:.4f}\n"
        f"F1 (macro): {f1:.4f}\n"
        f"AUC-ROC  : {auc_roc:.4f}\n"
        f"Confusion Matrix:\n{cm}"
    )
    return results


# ---------------------------------------------------------------------------
# Plots
# ---------------------------------------------------------------------------

def plot_confusion_matrix(
    cm: np.ndarray,
    class_names: list[str] | None = None,
    output_dir: str = "reports",
    filename: str = "confusion_matrix.png",
) -> None:
    """Save a confusion matrix heatmap.

    Parameters
    ----------
    cm : np.ndarray
    class_names : list[str] | None
    output_dir : str
    filename : str
    """
    if class_names is None:
        class_names = [str(i) for i in range(cm.shape[0])]

    os.makedirs(output_dir, exist_ok=True)
    fig, ax = plt.subplots(figsize=(6, 5))
    sns.heatmap(
        cm,
        annot=True,
        fmt="d",
        cmap="Blues",
        xticklabels=class_names,
        yticklabels=class_names,
        ax=ax,
    )
    ax.set_xlabel("Predicted")
    ax.set_ylabel("Actual")
    ax.set_title("Confusion Matrix")
    fig.tight_layout()
    fig.savefig(os.path.join(output_dir, filename))
    plt.close(fig)
    print(f"Confusion matrix saved to {os.path.join(output_dir, filename)}")


def plot_roc_curves(
    model,
    X_test: np.ndarray,
    y_test: np.ndarray,
    class_names: list[str] | None = None,
    output_dir: str = "reports",
    filename: str = "roc_curves.png",
) -> None:
    """Plot one-vs-rest ROC curves for all classes and save to file.

    Parameters
    ----------
    model : fitted classifier with ``predict_proba``
    X_test : np.ndarray
    y_test : np.ndarray
    class_names : list[str] | None
    output_dir : str
    filename : str
    """
    classes = np.unique(y_test)
    if class_names is None:
        class_names = [str(c) for c in classes]

    y_bin = label_binarize(y_test, classes=classes)
    y_proba = model.predict_proba(X_test)

    os.makedirs(output_dir, exist_ok=True)
    fig, ax = plt.subplots(figsize=(8, 6))

    for i, name in enumerate(class_names):
        fpr, tpr, _ = roc_curve(y_bin[:, i], y_proba[:, i])
        roc_auc = auc(fpr, tpr)
        ax.plot(fpr, tpr, label=f"{name} (AUC = {roc_auc:.2f})")

    ax.plot([0, 1], [0, 1], "k--")
    ax.set_xlabel("False Positive Rate")
    ax.set_ylabel("True Positive Rate")
    ax.set_title("One-vs-Rest ROC Curves")
    ax.legend(loc="lower right")
    fig.tight_layout()
    fig.savefig(os.path.join(output_dir, filename))
    plt.close(fig)
    print(f"ROC curves saved to {os.path.join(output_dir, filename)}")


# ---------------------------------------------------------------------------
# Threshold optimisation
# ---------------------------------------------------------------------------

def youden_threshold_optimization(
    model,
    X_test: np.ndarray,
    y_test: np.ndarray,
) -> dict[int, float]:
    """Find the optimal decision threshold per class using Youden's Index.

    Youden's J = Sensitivity + Specificity − 1 = TPR − FPR.

    Parameters
    ----------
    model : fitted classifier with ``predict_proba``
    X_test : np.ndarray
    y_test : np.ndarray

    Returns
    -------
    dict[int, float]
        Mapping of class index → optimal probability threshold.
    """
    classes = np.unique(y_test)
    y_bin = label_binarize(y_test, classes=classes)
    y_proba = model.predict_proba(X_test)

    thresholds: dict[int, float] = {}
    for i, cls in enumerate(classes):
        fpr, tpr, thresh = roc_curve(y_bin[:, i], y_proba[:, i])
        j_scores = tpr - fpr
        best_idx = int(np.argmax(j_scores))
        thresholds[int(cls)] = float(thresh[best_idx])
        print(f"Class {cls}: optimal threshold = {thresh[best_idx]:.4f}")

    return thresholds
