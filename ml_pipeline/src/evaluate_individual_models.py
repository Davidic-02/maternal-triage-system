"""
evaluate_individual_models.py
-----------------------------
Generate individual confusion matrices, ROC curves, and precision-recall curves
for each model (RF, SVM, XGBoost, LR) and the stacking ensemble.

Usage: python -m src.evaluate_individual_models
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


CLASS_NAMES = ["low_risk", "mid_risk", "high_risk"]
COLORS = ["#3498db", "#e74c3c", "#2ecc71"]


# ---------------------------------------------------------------------------
# Individual Model Figures (3×3 confusion matrix)
# ---------------------------------------------------------------------------

def plot_individual_confusion_matrix(y_true, y_pred, model_name, output_dir="reports"):
    """Save confusion matrix for a single model."""
    os.makedirs(output_dir, exist_ok=True)
    
    cm = confusion_matrix(y_true, y_pred, labels=[0, 1, 2])
    
    fig, ax = plt.subplots(figsize=(8, 6))
    sns.heatmap(
        cm,
        annot=True,
        fmt='d',
        cmap='YlOrRd',
        xticklabels=['Low Risk', 'Mid Risk', 'High Risk'],
        yticklabels=['Low Risk', 'Mid Risk', 'High Risk'],
        ax=ax,
        cbar=True,
        linewidths=2,
        linecolor='black'
    )
    
    ax.set_title(f'{model_name} - Confusion Matrix (3×3)', fontsize=14, fontweight='bold')
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
# ROC Curves (One-vs-Rest for each class)
# ---------------------------------------------------------------------------

def plot_individual_roc_curves(y_true, y_proba, model_name, output_dir="reports"):
    """Save ROC curves for all 3 classes (one-vs-rest)."""
    os.makedirs(output_dir, exist_ok=True)
    
    y_bin = label_binarize(y_true, classes=[0, 1, 2])
    
    fig, ax = plt.subplots(figsize=(8, 6))
    
    class_names = ['Low Risk', 'Mid Risk', 'High Risk']
    
    for i, (color, name) in enumerate(zip(COLORS, class_names)):
        fpr, tpr, _ = roc_curve(y_bin[:, i], y_proba[:, i])
        roc_auc = auc(fpr, tpr)
        ax.plot(fpr, tpr, color=color, lw=2.5, label=f'{name} (AUC = {roc_auc:.4f})')
    
    ax.plot([0, 1], [0, 1], 'k--', lw=2, label='Random Classifier')
    ax.set_xlim([0.0, 1.0])
    ax.set_ylim([0.0, 1.05])
    ax.set_xlabel('False Positive Rate', fontsize=12, fontweight='bold')
    ax.set_ylabel('True Positive Rate', fontsize=12, fontweight='bold')
    ax.set_title(f'{model_name} - ROC Curves (One-vs-Rest)', fontsize=14, fontweight='bold')
    ax.legend(loc='lower right', fontsize=10)
    ax.grid(alpha=0.3)
    
    filename = f"{model_name.lower().replace(' ', '_')}_roc_curves.png"
    filepath = os.path.join(output_dir, filename)
    fig.tight_layout()
    fig.savefig(filepath, dpi=300, bbox_inches='tight')
    plt.close(fig)
    print(f"  ✓ {model_name} ROC curves saved → {filepath}")


# ---------------------------------------------------------------------------
# Precision-Recall Curves (One-vs-Rest for each class)
# ---------------------------------------------------------------------------

def plot_individual_precision_recall_curves(y_true, y_proba, model_name, output_dir="reports"):
    """Save precision-recall curves for all 3 classes."""
    os.makedirs(output_dir, exist_ok=True)
    
    y_bin = label_binarize(y_true, classes=[0, 1, 2])
    
    fig, ax = plt.subplots(figsize=(8, 6))
    
    class_names = ['Low Risk', 'Mid Risk', 'High Risk']
    
    for i, (color, name) in enumerate(zip(COLORS, class_names)):
        precision, recall, _ = precision_recall_curve(y_bin[:, i], y_proba[:, i])
        ax.plot(recall, precision, color=color, lw=2.5, label=f'{name}')
    
    ax.set_xlim([0.0, 1.0])
    ax.set_ylim([0.0, 1.05])
    ax.set_xlabel('Recall', fontsize=12, fontweight='bold')
    ax.set_ylabel('Precision', fontsize=12, fontweight='bold')
    ax.set_title(f'{model_name} - Precision-Recall Curves (One-vs-Rest)', fontsize=14, fontweight='bold')
    ax.legend(loc='best', fontsize=10)
    ax.grid(alpha=0.3)
    
    filename = f"{model_name.lower().replace(' ', '_')}_precision_recall_curves.png"
    filepath = os.path.join(output_dir, filename)
    fig.tight_layout()
    fig.savefig(filepath, dpi=300, bbox_inches='tight')
    plt.close(fig)
    print(f"  ✓ {model_name} precision-recall curves saved → {filepath}")


# ---------------------------------------------------------------------------
# Comprehensive Model Evaluation
# ---------------------------------------------------------------------------

def evaluate_single_model(model, X_test, y_test, model_name, output_dir="reports"):
    """Evaluate a single model and generate all visualizations."""
    print(f"\n{'='*70}")
    print(f"Evaluating: {model_name}")
    print(f"{'='*70}")
    
    # Predictions
    y_pred = model.predict(X_test)
    y_proba = model.predict_proba(X_test)
    
    # Generate confusion matrix
    cm = plot_individual_confusion_matrix(y_test, y_pred, model_name, output_dir)
    
    # Generate ROC curves
    plot_individual_roc_curves(y_test, y_proba, model_name, output_dir)
    
    # Generate precision-recall curves
    plot_individual_precision_recall_curves(y_test, y_proba, model_name, output_dir)
    
    # Print metrics
    target_names = ['Low Risk', 'Mid Risk', 'High Risk']
    print(f"\n-- Classification Report: {model_name} ---")
    print(classification_report(y_test, y_pred, target_names=target_names, zero_division=0))
    
    return cm, y_pred, y_proba


# ---------------------------------------------------------------------------
# Main execution
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    from src.feature_engineering import run_feature_engineering
    from src.balancing import apply_smote
    from src.train import normalize_features, build_stacking_ensemble
    
    print("\n" + "="*70)
    print("INDIVIDUAL MODEL EVALUATION WITH VISUALIZATIONS")
    print("="*70)
    
    print("\n-- Loading and preprocessing data ---")
    X_train, X_test, y_train, y_test = run_feature_engineering()
    
    X_res, y_res = apply_smote(X_train, y_train)
    X_train_norm, X_test_norm = normalize_features(X_res, X_test)
    
    y_test = np.asarray(y_test)
    
    print("\n-- Loading trained stacking ensemble model ---")
    try:
        stacking_model = joblib.load("models/stacking_model.pkl")
        print("  ✓ Stacking model loaded from models/stacking_model.pkl")
    except FileNotFoundError:
        print("  ✗ models/stacking_model.pkl not found!")
        print("  Building fresh stacking ensemble...")
        stacking_model = build_stacking_ensemble()
        stacking_model.fit(X_train_norm, y_res)
        joblib.dump(stacking_model, "models/stacking_model.pkl")
        print("  ✓ New model trained and saved")
    
    # Evaluate stacking ensemble
    print("\n" + "="*70)
    print("EVALUATING STACKING ENSEMBLE")
    print("="*70)
    evaluate_single_model(stacking_model, X_test_norm, y_test, "Stacking Ensemble", "reports")
    
    # Extract and evaluate individual base learners
      # Extract and evaluate individual base learners
    print("\n" + "="*70)
    print("EVALUATING INDIVIDUAL BASE LEARNERS")
    print("="*70)
    
    model_names_map = {0: "Random Forest", 1: "XGBoost", 2: "Support Vector Machine"}
    
    for i, estimator in enumerate(stacking_model.estimators_):
        display_name = model_names_map.get(i, f"Model {i}")
        evaluate_single_model(estimator, X_test_norm, y_test, display_name, "reports")
    
    # Meta-learner cannot be evaluated independently
    print("\n" + "="*70)
    print("NOTE: Meta-learner evaluation skipped")
    print("="*70)
    print("The Logistic Regression meta-learner expects meta-features")
    print("(predictions from base learners), not raw test features.")
    print("Its performance is already evaluated as part of the Stacking Ensemble.")
    
    print("\n" + "="*70)
    print("✅ ALL EVALUATIONS COMPLETE!")
    print("="*70)
    print("\nGenerated figures in 'reports/' directory:")
    print("  - stacking_ensemble_*")
    print("  - random_forest_*")
    print("  - xgboost_*")
    print("  - support_vector_machine_*")
    print("\nEach model has 3 figures:")
    print("  - *_confusion_matrix.png")
    print("  - *_roc_curves.png")
    print("  - *_precision_recall_curves.png")
    print("\nModels evaluated:")
    print("  1. Stacking Ensemble (full model with meta-learner)")
    print("  2. Random Forest (base learner)")
    print("  3. XGBoost (base learner)")
    print("  4. Support Vector Machine (base learner)")
    print("  1. Stacking Ensemble (full model)")
    print("  2. Random Forest (base learner)")
    print("  3. XGBoost (base learner)")
    print("  4. Support Vector Machine (base learner)")
    print("  5. Logistic Regression (meta-learner)")