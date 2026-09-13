"""
evaluate_individual_models.py
-----------------------------
Generate individual confusion matrices, ROC curves, and precision-recall curves
for each base learner and the stacking ensemble.

Works for BOTH binary (low vs high) and three-class (low/mid/high) modes; the
number of classes is detected from the test labels at runtime and outputs are
written to the mode-specific reports folder (reports/binary or reports/three_class).

Usage:
    python -m src.evaluate_individual_models
    CLASSIFICATION_MODE=multiclass python -m src.evaluate_individual_models
"""

import os
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import seaborn as sns
import joblib
from sklearn.preprocessing import label_binarize
from sklearn.metrics import (
    confusion_matrix,
    roc_curve,
    precision_recall_curve,
    auc,
    classification_report,
)


# Display names / colours indexed by the integer label (0=low, 1=high)
LABEL_DISPLAY = {0: "Low Risk", 2: "High Risk"}
LABEL_COLOR = {0: "#3498db", 2: "#e74c3c"}


def _class_info(y_true):
    """Return (sorted class ints, display names, colours) present in y_true."""
    classes = sorted(int(c) for c in np.unique(y_true))
    names = [LABEL_DISPLAY[c] for c in classes]
    colors = [LABEL_COLOR[c] for c in classes]
    return classes, names, colors


# ---------------------------------------------------------------------------
# Confusion matrix
# ---------------------------------------------------------------------------

def plot_individual_confusion_matrix(y_true, y_pred, model_name, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    classes, names, _ = _class_info(y_true)
    cm = confusion_matrix(y_true, y_pred, labels=classes)

    fig, ax = plt.subplots(figsize=(8, 6))
    sns.heatmap(
        cm, annot=True, fmt='d', cmap='YlOrRd',
        xticklabels=names, yticklabels=names,
        ax=ax, cbar=True, linewidths=2, linecolor='black',
    )
    dims = f"{len(classes)}×{len(classes)}"
    ax.set_title(f'{model_name} - Confusion Matrix ({dims})', fontsize=14, fontweight='bold')
    ax.set_ylabel('Actual Risk Level', fontsize=12, fontweight='bold')
    ax.set_xlabel('Predicted Risk Level', fontsize=12, fontweight='bold')

    filename = f"{model_name.lower().replace(' ', '_')}_confusion_matrix.png"
    filepath = os.path.join(output_dir, filename)
    fig.tight_layout()
    fig.savefig(filepath, dpi=300, bbox_inches='tight')
    plt.close(fig)
    print(f"  ✓ {model_name} confusion matrix saved → {filepath}")
    return cm


# ---------------------------------------------------------------------------
# ROC curves
# ---------------------------------------------------------------------------

def plot_individual_roc_curves(y_true, y_proba, model_name, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    classes, names, colors = _class_info(y_true)

    fig, ax = plt.subplots(figsize=(8, 6))

    if len(classes) == 2:
        # Binary: single ROC curve for the positive (second) class.
        fpr, tpr, _ = roc_curve(y_true, y_proba[:, 1], pos_label=classes[1])
        roc_auc = auc(fpr, tpr)
        ax.plot(fpr, tpr, color=colors[1], lw=2.5,
                label=f'{names[1]} vs {names[0]} (AUC = {roc_auc:.4f})')
    else:
        y_bin = label_binarize(y_true, classes=classes)
        for i, (color, name) in enumerate(zip(colors, names)):
            fpr, tpr, _ = roc_curve(y_bin[:, i], y_proba[:, i])
            roc_auc = auc(fpr, tpr)
            ax.plot(fpr, tpr, color=color, lw=2.5, label=f'{name} (AUC = {roc_auc:.4f})')

    ax.plot([0, 1], [0, 1], 'k--', lw=2, label='Random Classifier')
    ax.set_xlim([0.0, 1.0]); ax.set_ylim([0.0, 1.05])
    ax.set_xlabel('False Positive Rate', fontsize=12, fontweight='bold')
    ax.set_ylabel('True Positive Rate', fontsize=12, fontweight='bold')
    suffix = "" if len(classes) == 2 else " (One-vs-Rest)"
    ax.set_title(f'{model_name} - ROC Curves{suffix}', fontsize=14, fontweight='bold')
    ax.legend(loc='lower right', fontsize=10)
    ax.grid(alpha=0.3)

    filename = f"{model_name.lower().replace(' ', '_')}_roc_curves.png"
    filepath = os.path.join(output_dir, filename)
    fig.tight_layout()
    fig.savefig(filepath, dpi=300, bbox_inches='tight')
    plt.close(fig)
    print(f"  ✓ {model_name} ROC curves saved → {filepath}")


# ---------------------------------------------------------------------------
# Precision-Recall curves
# ---------------------------------------------------------------------------

def plot_individual_precision_recall_curves(y_true, y_proba, model_name, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    classes, names, colors = _class_info(y_true)

    fig, ax = plt.subplots(figsize=(8, 6))

    if len(classes) == 2:
        precision, recall, _ = precision_recall_curve(
            (np.asarray(y_true) == classes[1]).astype(int), y_proba[:, 1]
        )
        ax.plot(recall, precision, color=colors[1], lw=2.5, label=f'{names[1]} vs {names[0]}')
    else:
        y_bin = label_binarize(y_true, classes=classes)
        for i, (color, name) in enumerate(zip(colors, names)):
            precision, recall, _ = precision_recall_curve(y_bin[:, i], y_proba[:, i])
            ax.plot(recall, precision, color=color, lw=2.5, label=f'{name}')

    ax.set_xlim([0.0, 1.0]); ax.set_ylim([0.0, 1.05])
    ax.set_xlabel('Recall', fontsize=12, fontweight='bold')
    ax.set_ylabel('Precision', fontsize=12, fontweight='bold')
    suffix = "" if len(classes) == 2 else " (One-vs-Rest)"
    ax.set_title(f'{model_name} - Precision-Recall Curves{suffix}', fontsize=14, fontweight='bold')
    ax.legend(loc='best', fontsize=10)
    ax.grid(alpha=0.3)

    filename = f"{model_name.lower().replace(' ', '_')}_precision_recall_curves.png"
    filepath = os.path.join(output_dir, filename)
    fig.tight_layout()
    fig.savefig(filepath, dpi=300, bbox_inches='tight')
    plt.close(fig)
    print(f"  ✓ {model_name} precision-recall curves saved → {filepath}")


# ---------------------------------------------------------------------------
# Single-model evaluation
# ---------------------------------------------------------------------------

def evaluate_single_model(model, X_test, y_test, model_name, output_dir, threshold=None):
    print(f"\n{'='*70}\nEvaluating: {model_name}\n{'='*70}")
    y_proba = model.predict_proba(X_test)
    present = sorted(int(c) for c in np.unique(y_test))

    if threshold is not None and len(present) == 2:
        # Apply the Youden decision threshold (deployed model) instead of argmax.
        pos, neg = present[1], present[0]
        y_pred = np.where(y_proba[:, 1] >= threshold, pos, neg)
        print(f"  Applying decision threshold {threshold:.4f} (positive class = {pos}).")
    else:
        y_pred = model.predict(X_test)
        # Base learners inside a StackingClassifier are fitted on label-encoded
        # targets (0..n-1), so in binary mode they return {0,1} while the true
        # labels are {0,2}. Remap encoded predictions back to original labels.
        # The ensemble itself already returns original labels (no remap).
        model_classes = list(getattr(model, "classes_", present))
        if model_classes == list(range(len(present))) and present != list(range(len(present))):
            y_pred = np.array([present[int(p)] for p in y_pred])

    cm = plot_individual_confusion_matrix(y_test, y_pred, model_name, output_dir)
    plot_individual_roc_curves(y_test, y_proba, model_name, output_dir)
    plot_individual_precision_recall_curves(y_test, y_proba, model_name, output_dir)

    _, names, _ = _class_info(y_test)
    print(f"\n-- Classification Report: {model_name} ---")
    print(classification_report(y_test, y_pred, target_names=names, zero_division=0))
    return cm, y_pred, y_proba


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    from src.config import REPORTS_DIR, CLASSIFICATION_MODE
    from src.feature_engineering import run_feature_engineering
    from src.balancing import apply_smote
    from src.train import normalize_features, build_stacking_ensemble

    print("\n" + "="*70)
    print(f"INDIVIDUAL MODEL EVALUATION (mode: {CLASSIFICATION_MODE})")
    print("="*70)
    os.makedirs(REPORTS_DIR, exist_ok=True)

    X_train, X_test, y_train, y_test = run_feature_engineering()
    X_res, y_res = apply_smote(X_train, y_train)
    X_train_norm, X_test_norm = normalize_features(X_res, X_test)
    y_test = np.asarray(y_test)

    print("\n-- Loading trained stacking ensemble model ---")
    try:
        stacking_model = joblib.load("models/stacking_model.pkl")
        print("  ✓ Stacking model loaded from models/stacking_model.pkl")
    except FileNotFoundError:
        print("  ✗ models/stacking_model.pkl not found — training fresh.")
        stacking_model = build_stacking_ensemble()
        stacking_model.fit(X_train_norm, y_res)
        joblib.dump(stacking_model, "models/stacking_model.pkl")

    # Load the binary decision threshold (if present) so the Stacking Ensemble
    # plot matches the deployed, thresholded model. Base learners stay at argmax
    # for a fair like-for-like model comparison.
    import json as _json
    _thr = None
    if os.path.exists("models/decision_threshold.json"):
        with open("models/decision_threshold.json") as _fh:
            _thr = float(_json.load(_fh)["threshold"])

    # Stacking ensemble (deployed model → apply threshold in binary mode)
    evaluate_single_model(stacking_model, X_test_norm, y_test, "Stacking Ensemble", REPORTS_DIR, threshold=_thr)

    # Base learners — derive display names from the estimator order in the
    # ensemble so it stays correct if learners are added/removed.
    estimator_name_map = {
        "rf": "Random Forest",
        "xgb": "XGBoost",
        "svm": "Support Vector Machine",
        "lgbm": "LightGBM",
    }
    print("\n" + "="*70 + "\nEVALUATING INDIVIDUAL BASE LEARNERS\n" + "="*70)
    for (est_key, _), fitted in zip(stacking_model.estimators, stacking_model.estimators_):
        display_name = estimator_name_map.get(est_key, est_key)
        evaluate_single_model(fitted, X_test_norm, y_test, display_name, REPORTS_DIR)

    print("\n" + "="*70)
    print(f"✅ ALL EVALUATIONS COMPLETE → {REPORTS_DIR}/")
    print("="*70)
