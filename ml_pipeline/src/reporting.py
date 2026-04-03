"""
reporting.py
------------
Utilities for exporting evaluation metrics to structured formats:
  - JSON (machine-readable, suitable for programmatic access)
  - Markdown (human-readable report for documentation / papers)
"""

import json
import os
from datetime import datetime, timezone

import numpy as np


# ---------------------------------------------------------------------------
# JSON export
# ---------------------------------------------------------------------------

def save_evaluation_metrics_json(
    results: dict,
    class_report: dict,
    optimal_thresholds: dict,
    y_test: np.ndarray,
    class_names: list = None,
    output_path: str = "models/evaluation_metrics.json",
) -> str:
    """Save evaluation metrics to a structured JSON file.

    Parameters
    ----------
    results:
        Dict returned by ``evaluate_model()`` — must contain the keys
        ``accuracy``, ``precision``, ``recall``, ``f1``, ``auc_roc``, and
        ``confusion_matrix``.
    class_report:
        Dict returned by ``sklearn.metrics.classification_report(...,
        output_dict=True)``.
    optimal_thresholds:
        Dict mapping class index → optimal Youden threshold (floats).
    y_test:
        True labels for the test set.
    class_names:
        Ordered list of human-readable class labels.
    output_path:
        Destination file path for the JSON output.

    Returns
    -------
    str
        Absolute path of the saved JSON file.
    """
    if class_names is None:
        class_names = ["low", "mid", "high"]

    cm = results["confusion_matrix"]

    # Build structured confusion-matrix dict: {actual_class: {pred_class: count}}
    cm_dict = {}
    for i, actual in enumerate(class_names):
        cm_dict[actual] = {class_names[j]: int(cm[i, j]) for j in range(len(class_names))}

    # Per-class metrics extracted from the classification report
    class_metrics = {}
    for idx, name in enumerate(class_names):
        if name in class_report:
            entry = class_report[name]
            class_metrics[name] = {
                "precision": round(float(entry["precision"]), 4),
                "recall":    round(float(entry["recall"]), 4),
                "f1":        round(float(entry["f1-score"]), 4),
                "support":   int(entry["support"]),
            }

    # Thresholds keyed by class name
    named_thresholds = {
        class_names[int(k)]: round(float(v), 4)
        for k, v in optimal_thresholds.items()
        if int(k) < len(class_names)
    }

    # Test-set class distribution
    unique, counts = np.unique(y_test, return_counts=True)
    test_stats = {
        "total_samples": int(len(y_test)),
        "class_distribution": {
            class_names[int(u)]: int(c)
            for u, c in zip(unique, counts)
            if int(u) < len(class_names)
        },
    }

    payload = {
        "generated_at": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "overall_metrics": {
            "accuracy":  round(float(results["accuracy"]), 4),
            "precision": round(float(results["precision"]), 4),
            "recall":    round(float(results["recall"]), 4),
            "f1":        round(float(results["f1"]), 4),
            "auc_roc":   round(float(results["auc_roc"]), 4),
        },
        "confusion_matrix": cm_dict,
        "class_metrics": class_metrics,
        "optimal_thresholds": named_thresholds,
        "test_set_stats": test_stats,
    }

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as fh:
        json.dump(payload, fh, indent=2)

    print(f"  Evaluation metrics JSON saved -> {output_path}")
    return output_path


# ---------------------------------------------------------------------------
# Markdown report
# ---------------------------------------------------------------------------

def generate_markdown_report(
    results: dict,
    class_report: dict,
    optimal_thresholds: dict,
    y_test: np.ndarray,
    class_names: list = None,
    output_path: str = "reports/EVALUATION_REPORT.md",
) -> str:
    """Generate a human-readable Markdown evaluation report.

    Parameters
    ----------
    results:
        Dict returned by ``evaluate_model()``.
    class_report:
        Dict returned by ``sklearn.metrics.classification_report(...,
        output_dict=True)``.
    optimal_thresholds:
        Dict mapping class index → optimal Youden threshold.
    y_test:
        True labels for the test set.
    class_names:
        Ordered list of human-readable class labels.
    output_path:
        Destination file path for the Markdown report.

    Returns
    -------
    str
        Absolute path of the saved Markdown file.
    """
    if class_names is None:
        class_names = ["low", "mid", "high"]

    cm = results["confusion_matrix"]
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")

    # ---- overall metrics table -------------------------------------------
    overall_table = (
        "| Metric    | Value  |\n"
        "|-----------|--------|\n"
        f"| Accuracy  | {results['accuracy']:.4f} |\n"
        f"| Precision | {results['precision']:.4f} |\n"
        f"| Recall    | {results['recall']:.4f} |\n"
        f"| F1 Score  | {results['f1']:.4f} |\n"
        f"| AUC-ROC   | {results['auc_roc']:.4f} |\n"
    )

    # ---- per-class metrics table -----------------------------------------
    header = "| Class | Precision | Recall | F1-Score | Support |\n"
    sep    = "|-------|-----------|--------|----------|---------|\n"
    rows   = []
    for name in class_names:
        if name in class_report:
            e = class_report[name]
            rows.append(
                f"| {name:<5} | {e['precision']:.4f}    | "
                f"{e['recall']:.4f} | {e['f1-score']:.4f}   | "
                f"{int(e['support']):<7} |"
            )
    per_class_table = header + sep + "\n".join(rows) + "\n"

    # ---- confusion matrix table ------------------------------------------
    cm_header = "| Actual \\ Predicted | " + " | ".join(class_names) + " |\n"
    cm_sep    = "|---|" + "---|" * len(class_names) + "\n"
    cm_rows   = []
    for i, actual in enumerate(class_names):
        cells = " | ".join(str(cm[i, j]) for j in range(len(class_names)))
        cm_rows.append(f"| **{actual}** | {cells} |")
    cm_table = cm_header + cm_sep + "\n".join(cm_rows) + "\n"

    # ---- Youden thresholds table -----------------------------------------
    thresh_header = "| Class | Optimal Threshold |\n"
    thresh_sep    = "|-------|-------------------|\n"
    thresh_rows   = []
    for k, v in optimal_thresholds.items():
        name = class_names[int(k)] if int(k) < len(class_names) else str(k)
        thresh_rows.append(f"| {name:<5} | {v:.4f}            |")
    thresh_table = thresh_header + thresh_sep + "\n".join(thresh_rows) + "\n"

    # ---- class distribution in test set ----------------------------------
    unique, counts = np.unique(y_test, return_counts=True)
    dist_lines = [
        f"- **{class_names[int(u)]}**: {int(c)} samples"
        for u, c in zip(unique, counts)
        if int(u) < len(class_names)
    ]
    dist_section = "\n".join(dist_lines)

    # ---- assemble report -------------------------------------------------
    report = f"""# Maternal Triage Model — Evaluation Report

*Generated: {now}*

---

## 1. Overall Metrics

{overall_table}
> Precision, Recall, and F1-Score are **macro-averaged** across all classes.  
> AUC-ROC uses the **One-vs-Rest (OvR)** strategy.

---

## 2. Per-Class Metrics

{per_class_table}
---

## 3. Confusion Matrix

*(rows = actual class, columns = predicted class)*

{cm_table}
---

## 4. Optimal Decision Thresholds (Youden's Index)

{thresh_table}
> The threshold that maximises *sensitivity + specificity − 1* for each class.

---

## 5. Test-Set Statistics

- **Total samples**: {len(y_test)}

{dist_section}

---

## 6. Notes

- All metrics are computed on the held-out test split (20% of the full dataset).
- The model is a **stacking ensemble**: Random Forest + XGBoost + SVM (base),  
  Logistic Regression (meta-learner).
- Features were normalised with Min-Max scaling; training set was balanced with SMOTE.
"""

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as fh:
        fh.write(report)

    print(f"  Evaluation report (Markdown) saved -> {output_path}")
    return output_path
