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
    threshold: float = None,
) -> tuple:
    """Compute and print classification metrics.

    Parameters
    ----------
    threshold : float, optional
        For binary models, classify as the positive class when
        ``P(positive) >= threshold`` instead of using argmax/0.5. Applied
        only when the problem has exactly two classes.

    Returns
    -------
    tuple
        ``(results, class_report)`` where *results* is the metrics dict and
        *class_report* is the ``classification_report`` dict
        (``output_dict=True``).
    """
    y_proba = model.predict_proba(X_test)
    classes = np.unique(y_test)

    if threshold is not None and len(classes) == 2:
        pos = int(max(classes)); neg = int(min(classes))
        y_pred = np.where(y_proba[:, 1] >= threshold, pos, neg)
        print(f"  [evaluate_model] Applying decision threshold {threshold:.4f} "
              f"(positive class = {pos}).")
    else:
        y_pred = model.predict(X_test)

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

    target_names = [CLASS_NAMES[int(c)] for c in sorted(classes)]
    class_report = classification_report(
        y_test, y_pred, target_names=target_names, zero_division=0, output_dict=True
    )

    print("\n-- Evaluation Metrics ---")
    print(f"  Accuracy  : {acc:.4f}")
    print(f"  Precision : {prec:.4f}  (macro)")
    print(f"  Recall    : {rec:.4f}  (macro)")
    print(f"  F1 Score  : {f1:.4f}  (macro)")
    print(f"  AUC-ROC   : {auc_roc:.4f}  (macro OvR)")

    print("\n-- Per-class Classification Report ---")
    print(classification_report(y_test, y_pred, target_names=target_names, zero_division=0))

    print("-- Confusion Matrix (rows=actual, cols=predicted) ---")
    print(f"  Classes: {target_names}")
    print(cm)

    return results, class_report


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

    y_proba = model.predict_proba(X_test)

    os.makedirs(output_dir, exist_ok=True)
    out_path = os.path.join(output_dir, filename)
    fig, ax = plt.subplots(figsize=(8, 6))

    if len(classes) == 2:
        # Binary: single ROC curve for the positive (second) class.
        pos_label = classes[1]
        fpr, tpr, _ = roc_curve(y_test, y_proba[:, 1], pos_label=pos_label)
        roc_auc_val = auc(fpr, tpr)
        ax.plot(fpr, tpr, label=f"{class_names[1]} vs {class_names[0]} (AUC = {roc_auc_val:.2f})")
    else:
        # Multiclass: one-vs-rest ROC curve per class.
        y_bin = label_binarize(y_test, classes=classes)
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
    y_proba = model.predict_proba(X_test)

    # For binary, label_binarize collapses to a single column; build a
    # per-class one-vs-rest indicator matrix explicitly so the loop works
    # for both binary and multiclass.
    if len(classes) == 2:
        y_bin = np.column_stack([(np.asarray(y_test) == c).astype(int) for c in classes])
    else:
        y_bin = label_binarize(y_test, classes=classes)

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
    import os as _os
    import joblib
    from src.config import REPORTS_DIR, CLASSIFICATION_MODE
    from src.feature_engineering import run_feature_engineering
    from src.balancing import apply_smote
    from src.train import normalize_features
    from src.reporting import (
        save_evaluation_metrics_json,
        generate_markdown_report,
        generate_model_quality_report,
    )

    _os.makedirs(REPORTS_DIR, exist_ok=True)
    print(f"-- Loading pipeline data (mode: {CLASSIFICATION_MODE}) ---")
    X_train, X_test, y_train, y_test = run_feature_engineering()

    X_res, y_res = apply_smote(X_train, y_train)
    X_train_norm, X_test_norm = normalize_features(X_res, X_test)

    print("-- Loading trained model ---")
    model = joblib.load("models/stacking_model.pkl")
    print("  Model loaded from models/stacking_model.pkl")

    # In binary mode, apply the persisted Youden decision threshold so the
    # reported metrics match what the deployed app produces.
    import json as _json
    _thr = None
    _thr_path = "models/decision_threshold.json"
    if _os.path.exists(_thr_path):
        with open(_thr_path) as _fh:
            _thr = float(_json.load(_fh)["threshold"])

    results, class_report = evaluate_model(model, X_test_norm, np.asarray(y_test), threshold=_thr)

    print("\n-- Saving plots ---")
    classes = sorted(np.unique(y_test))
    c_names = [CLASS_NAMES[int(c)] for c in classes]
    plot_confusion_matrix(results["confusion_matrix"], class_names=c_names, output_dir=REPORTS_DIR)
    plot_roc_curves(model, X_test_norm, np.asarray(y_test), class_names=c_names, output_dir=REPORTS_DIR)

    thresholds = youden_threshold_optimization(model, X_test_norm, np.asarray(y_test))

    print("\n-- Saving metrics and reports ---")
    # Write metrics JSON both to models/ (consumed by the app/convert step)
    # and into the mode-specific reports folder for the paper.
    save_evaluation_metrics_json(
        results, class_report, thresholds, np.asarray(y_test),
        class_names=c_names, output_path="models/evaluation_metrics.json",
    )
    save_evaluation_metrics_json(
        results, class_report, thresholds, np.asarray(y_test),
        class_names=c_names, output_path=_os.path.join(REPORTS_DIR, "evaluation_metrics.json"),
    )
    generate_markdown_report(
        results, class_report, thresholds, np.asarray(y_test),
        class_names=c_names, output_path=_os.path.join(REPORTS_DIR, "EVALUATION_REPORT.md"),
    )
    generate_model_quality_report(
        results, class_report,
        class_names=c_names, output_path=_os.path.join(REPORTS_DIR, "MODEL_QUALITY_ASSESSMENT.md"),
    )

    print("\n-- Done! ---")