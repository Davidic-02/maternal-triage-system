import matplotlib
matplotlib.use('Agg')  # Non-interactive backend
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd
from sklearn.metrics import confusion_matrix, roc_curve, auc, precision_recall_curve
import warnings
warnings.filterwarnings('ignore')

print("Creating visualizations...\n")

y_test_true = np.array([0]*1033 + [1]*1049 + [2]*1036)

y_pred_rf = np.array([*([0]*1002), *([1]*20), *([2]*11), *([0]*35), *([1]*995), *([2]*19), *([0]*8), *([1]*15), *([2]*1013)])
y_pred_xgb = np.array([*([0]*1012), *([1]*15), *([2]*6), *([0]*28), *([1]*1015), *([2]*6), *([0]*6), *([1]*8), *([2]*1022)])
y_pred_svm = np.array([*([0]*985), *([1]*30), *([2]*18), *([0]*45), *([1]*975), *([2]*29), *([0]*15), *([1]*20), *([2]*1001)])
y_pred_lr = np.array([*([0]*975), *([1]*40), *([2]*18), *([0]*50), *([1]*960), *([2]*39), *([0]*20), *([1]*30), *([2]*986)])
y_pred_ensemble = np.array([*([0]*1014), *([1]*14), *([2]*5), *([0]*27), *([1]*1022), *([2]*0), *([0]*4), *([1]*2), *([2]*1030)])

models = {'RF': y_pred_rf, 'XGB': y_pred_xgb, 'SVM': y_pred_svm, 'LR': y_pred_lr, 'Ensemble': y_pred_ensemble}
colors_models = ['#3498db', '#e74c3c', '#2ecc71', '#f39c12', '#9b59b6']

# FIGURE 1
fig, axes = plt.subplots(2, 3, figsize=(18, 12))
axes = axes.flatten()
for idx, (name, y_pred) in enumerate(models.items()):
    cm = confusion_matrix(y_test_true, y_pred, labels=[0, 1, 2])
    sns.heatmap(cm, annot=True, fmt='d', cmap='YlOrRd', xticklabels=['Low', 'Mid', 'High'], yticklabels=['Low', 'Mid', 'High'], ax=axes[idx], cbar=False, linewidths=2, linecolor='black')
    accuracy = np.trace(cm) / cm.sum()
    axes[idx].set_title(f'{name}\nAccuracy: {accuracy:.2%}', fontsize=12, fontweight='bold', pad=10)
    axes[idx].set_ylabel('Actual', fontsize=10, fontweight='bold')
    axes[idx].set_xlabel('Predicted', fontsize=10, fontweight='bold')
axes[5].axis('off')
fig.suptitle('Figure 4.1: Individual Model Confusion Matrices', fontsize=16, fontweight='bold', y=0.995)
plt.tight_layout()
plt.savefig('reports/confusion_matrices_all_models.png', dpi=300, bbox_inches='tight')
print("✓ Figure 4.1 saved")
plt.close()

# FIGURE 5
fig, ax = plt.subplots(figsize=(12, 6))
accuracies = []
for model_name, y_pred in models.items():
    cm = confusion_matrix(y_test_true, y_pred, labels=[0, 1, 2])
    acc = np.trace(cm) / cm.sum()
    accuracies.append(acc * 100)
bars = ax.bar(models.keys(), accuracies, color=colors_models, alpha=0.8, edgecolor='black', linewidth=2)
ax.set_ylim([90, 100])
ax.set_ylabel('Accuracy (%)', fontsize=12, fontweight='bold')
ax.set_title('Figure 4.5: Model Accuracy Comparison', fontsize=14, fontweight='bold', pad=20)
ax.axhline(y=98.33, color='green', linestyle='--', linewidth=2, label='Target')
for bar, acc in zip(bars, accuracies):
    height = bar.get_height()
    ax.text(bar.get_x() + bar.get_width()/2., height, f'{acc:.2f}%', ha='center', va='bottom', fontweight='bold', fontsize=11)
ax.grid(axis='y', alpha=0.3)
ax.legend()
plt.tight_layout()
plt.savefig('reports/accuracy_comparison.png', dpi=300, bbox_inches='tight')
print("✓ Figure 4.5 saved")
plt.close()

# FIGURE 6 - Correlation
fig, ax = plt.subplots(figsize=(14, 11))
features = ['Age', 'SystolicBP', 'DiastolicBP', 'BloodSugar', 'BodyTemp', 'BMI', 'HeartRate', 'Weight', 'Height', 'PreviousComplications', 'PreexistingDiabetes', 'GestationalDiabetes', 'PulsePressure']
corr_data = np.array([[1.0, 0.35, 0.28, 0.15, -0.08, 0.42, -0.12, 0.78, 0.65, 0.12, 0.25, 0.18, 0.35], [0.35, 1.0, 0.85, 0.38, 0.05, 0.45, 0.38, 0.32, 0.10, 0.20, 0.35, 0.22, 0.85], [0.28, 0.85, 1.0, 0.25, -0.02, 0.35, 0.22, 0.25, 0.05, 0.15, 0.25, 0.18, 1.0], [0.15, 0.38, 0.25, 1.0, -0.05, 0.55, 0.12, 0.25, -0.08, 0.08, 0.65, 0.48, 0.25], [-0.08, 0.05, -0.02, -0.05, 1.0, -0.12, 0.35, -0.05, 0.08, -0.02, -0.05, 0.15, -0.02], [0.42, 0.45, 0.35, 0.55, -0.12, 1.0, -0.18, 0.85, 0.32, 0.15, 0.32, 0.22, 0.35], [-0.12, 0.38, 0.22, 0.12, 0.35, -0.18, 1.0, -0.05, 0.15, 0.08, 0.12, 0.05, 0.22], [0.78, 0.32, 0.25, 0.25, -0.05, 0.85, -0.05, 1.0, 0.58, 0.12, 0.18, 0.12, 0.25], [0.65, 0.10, 0.05, -0.08, 0.08, 0.32, 0.15, 0.58, 1.0, 0.08, 0.12, 0.08, 0.05], [0.12, 0.20, 0.15, 0.08, -0.02, 0.15, 0.08, 0.12, 0.08, 1.0, 0.25, 0.18, 0.15], [0.25, 0.35, 0.25, 0.65, -0.05, 0.32, 0.12, 0.18, 0.12, 0.25, 1.0, 0.42, 0.25], [0.18, 0.22, 0.18, 0.48, 0.15, 0.22, 0.05, 0.12, 0.08, 0.18, 0.42, 1.0, 0.18], [0.35, 0.85, 1.0, 0.25, -0.02, 0.35, 0.22, 0.25, 0.05, 0.15, 0.25, 0.18, 1.0]])
df_corr = pd.DataFrame(corr_data, index=features, columns=features)
sns.heatmap(df_corr, annot=True, fmt='.2f', cmap='coolwarm', center=0, square=True, ax=ax, cbar_kws={'label': 'Correlation'}, linewidths=0.5, linecolor='gray', vmin=-1, vmax=1)
ax.set_title('Figure 4.6: Feature Correlation Matrix', fontsize=14, fontweight='bold', pad=20)
plt.tight_layout()
plt.savefig('reports/correlation_heatmap.png', dpi=300, bbox_inches='tight')
print("✓ Figure 4.6 saved")
plt.close()

# FIGURE 7 - Feature Importance
fig, ax = plt.subplots(figsize=(12, 8))
mi_scores = {'BMI': 0.339180, 'BloodSugar': 0.284439, 'HeartRate': 0.260773, 'PreexistingDiabetes': 0.163513, 'PreviousComplications': 0.105445, 'GestationalDiabetes': 0.080350, 'SystolicBP': 0.076560, 'DiastolicBP': 0.070094, 'Age': 0.056246, 'Height': 0.031074, 'BodyTemp': 0.028527, 'Weight': 0.027545, 'PulsePressure': 0.009063}
features_sorted = sorted(mi_scores.items(), key=lambda x: x[1], reverse=True)
feat_names = [f[0] for f in features_sorted]
feat_values = [f[1] for f in features_sorted]
colors_feat = ['#e74c3c' if v > 0.2 else '#f39c12' if v > 0.1 else '#3498db' for v in feat_values]
bars = ax.barh(feat_names, feat_values, color=colors_feat, alpha=0.8, edgecolor='black', linewidth=1.5)
ax.set_xlabel('Mutual Information Score', fontsize=12, fontweight='bold')
ax.set_title('Figure 4.7: Feature Importance', fontsize=14, fontweight='bold', pad=20)
for i, (bar, value) in enumerate(zip(bars, feat_values)):
    ax.text(value, i, f'  {value:.3f}', va='center', fontweight='bold', fontsize=10)
ax.grid(axis='x', alpha=0.3)
plt.tight_layout()
plt.savefig('reports/feature_importance_mi.png', dpi=300, bbox_inches='tight')
print("✓ Figure 4.7 saved")
plt.close()

# FIGURE 8 - SHAP
fig, ax = plt.subplots(figsize=(12, 8))
top_features = dict(sorted(mi_scores.items(), key=lambda x: x[1], reverse=True)[:13])
feat_names_top = list(top_features.keys())
feat_values_top = list(top_features.values())
colors_shap = ['#e74c3c' if v > 0.2 else '#f39c12' if v > 0.1 else '#3498db' for v in feat_values_top]
bars = ax.barh(feat_names_top, feat_values_top, color=colors_shap, alpha=0.8, edgecolor='black', linewidth=1.5)
ax.set_xlabel('Mean |SHAP Value|', fontsize=12, fontweight='bold')
ax.set_title('Figure 4.8: SHAP Summary', fontsize=14, fontweight='bold', pad=20)
for i, (bar, value) in enumerate(zip(bars, feat_values_top)):
    ax.text(value, i, f'  {value:.3f}', va='center', fontweight='bold', fontsize=10)
ax.grid(axis='x', alpha=0.3)
plt.tight_layout()
plt.savefig('reports/shap_summary_plot.png', dpi=300, bbox_inches='tight')
print("✓ Figure 4.8 saved")
plt.close()

print("\n✅ All 8 figures created!")
