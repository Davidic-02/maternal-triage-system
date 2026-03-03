"""
evaluate.py
-----------
Model evaluation utilities: metrics, confusion matrix, ROC curves, and
Youden-index threshold optimisation.
"""

import os

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from sklearn.metrics import (
    accuracy_score,
    auc,
    classification_report,
    confusion_matrix,
    f1_score,
    precision_score,
    recall_score,
    roc_auc_score,
    roc_curve,
)
from sklearn.preprocessing import label_binarize


# Class label names for display
CLASS_NAMES = ["low", "mid", "high"]


# ---------------------------------------------------------------------------
# Core evaluation
# ---------------------------------------------------------------------------

def evaluate_model(
    model,
    X_test: np.ndarray,
    y_test: np.ndarray,
) -> dict:
    """Compute and print classification metrics."""
    y_pred  = model.predict(X_test)
    y_proba = model.predict_proba(X_test)
    classes = np.unique(y_test)

    acc  = accuracy_score(y_test, y_pred)
    prec = precision_score(y_test, y_pred, average="macro", zero_division=0)
    rec  = recall_score(y_test, y_pred, average="macro", zero_division=0)
    f1   = f1_score(y_test, y_pred, average="macro", zero_division=0)
    cm   = confusion_matrix(y_test, y_pred)

    if len(classes) > 2:
        y_bin   = label_binarize(y_test, classes=sorted(classes))
        auc_roc = roc_auc_score(y_bin, y_proba, multi_class="ovr", average="macro")
    else:
        auc_roc = roc_auc_score(y_test, y_proba[:, 1])

    results = {
        "accuracy":         acc,
        "precision":        prec,
        "recall":           rec,
        "f1":               f1,
        "auc_roc":          auc_roc,
        "confusion_matrix": cm,
    }

    print("\n-- Evaluation Metrics ---")
    print(f"  Accuracy  : {acc:.4f}")
    print(f"  Precision : {prec:.4f}  (macro)")
    print(f"  Recall    : {rec:.4f}  (macro)")
    print(f"  F1 Score  : {f1:.4f}  (macro)")
    print(f"  AUC-ROC   : {auc_roc:.4f}  (macro OvR)")

    print("\n-- Per-class Classification Report ---")
    target_names = [CLASS_NAMES[int(c)] for c in sorted(classes)]
    print(classification_report(y_test, y_pred, target_names=target_names, zero_division=0))

    print("-- Confusion Matrix (rows=actual, cols=predicted) ---")
    print(f"  Classes: {target_names}")
    print(cm)

    return results


# ---------------------------------------------------------------------------
# Plots
# ---------------------------------------------------------------------------

def plot_confusion_matrix(
    cm: np.ndarray,
    class_names: list = None,
    output_dir: str = "reports",
    filename: str = "confusion_matrix.png",
) -> None:
    """Save a confusion matrix heatmap."""
    if class_names is None:
        class_names = [str(i) for i in range(cm.shape[0])]

    os.makedirs(output_dir, exist_ok=True)
    out_path = os.path.join(output_dir, filename)
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
    fig.savefig(out_path)
    plt.close(fig)
    print(f"  Confusion matrix saved -> {out_path}")


def plot_roc_curves(
    model,
    X_test: np.ndarray,
    y_test: np.ndarray,
    class_names: list = None,
    output_dir: str = "reports",
    filename: str = "roc_curves.png",
) -> None:
    """Plot one-vs-rest ROC curves for all classes and save to file."""
    classes = sorted(np.unique(y_test))
    if class_names is None:
        class_names = [CLASS_NAMES[int(c)] for c in classes]

    y_bin   = label_binarize(y_test, classes=classes)
    y_proba = model.predict_proba(X_test)

    os.makedirs(output_dir, exist_ok=True)
    out_path = os.path.join(output_dir, filename)
    fig, ax = plt.subplots(figsize=(8, 6))

    for i, name in enumerate(class_names):
        fpr, tpr, _ = roc_curve(y_bin[:, i], y_proba[:, i])
        roc_auc_val = auc(fpr, tpr)
        ax.plot(fpr, tpr, label=f"{name} (AUC = {roc_auc_val:.2f})")

    ax.plot([0, 1], [0, 1], "k--", label="Random")
    ax.set_xlabel("False Positive Rate")
    ax.set_ylabel("True Positive Rate")
    ax.set_title("One-vs-Rest ROC Curves")
    ax.legend(loc="lower right")
    fig.tight_layout()
    fig.savefig(out_path)
    plt.close(fig)
    print(f"  ROC curves saved -> {out_path}")


# ---------------------------------------------------------------------------
# Threshold optimisation
# ---------------------------------------------------------------------------

def youden_threshold_optimization(
    model,
    X_test: np.ndarray,
    y_test: np.ndarray,
) -> dict:
    """Find optimal decision threshold per class using Youden's Index."""
    classes = sorted(np.unique(y_test))
    y_bin   = label_binarize(y_test, classes=classes)
    y_proba = model.predict_proba(X_test)

    thresholds = {}
    print("\n-- Youden Optimal Thresholds ---")
    for i, cls in enumerate(classes):
        fpr, tpr, thresh = roc_curve(y_bin[:, i], y_proba[:, i])
        j_scores = tpr - fpr
        best_idx = int(np.argmax(j_scores))
        thresholds[int(cls)] = float(thresh[best_idx])
        label = CLASS_NAMES[int(cls)]
        print(f"  Class {cls} ({label:>4}): optimal threshold = {thresh[best_idx]:.4f}")

    return thresholds


# ---------------------------------------------------------------------------
# Smoke-test:  python3 -m src.evaluate
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    import joblib
    from src.feature_engineering import run_feature_engineering
    from src.balancing import apply_smote
    from src.train import normalize_features

    print("-- Loading pipeline data ---")
    X_train, X_test, y_train, y_test = run_feature_engineering()

    X_res, y_res = apply_smote(X_train, y_train)
    X_train_norm, X_test_norm = normalize_features(X_res, X_test)

    print("-- Loading trained model ---")
    model = joblib.load("models/stacking_model.pkl")
    print("  Model loaded from models/stacking_model.pkl")

    results = evaluate_model(model, X_test_norm, np.asarray(y_test))

    print("\n-- Saving plots ---")
    classes = sorted(np.unique(y_test))
    c_names = [CLASS_NAMES[int(c)] for c in classes]
    plot_confusion_matrix(results["confusion_matrix"], class_names=c_names)
    plot_roc_curves(model, X_test_norm, np.asarray(y_test), class_names=c_names)

    youden_threshold_optimization(model, X_test_norm, np.asarray(y_test))

    print("\n-- Done! ---")