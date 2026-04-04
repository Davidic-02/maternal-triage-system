"""
reporting.py
------------
Utilities for exporting evaluation metrics to structured formats:
  - JSON (machine-readable, suitable for programmatic access)
  - Markdown evaluation report
  - Markdown model quality assessment report
"""

import json
import os
from datetime import datetime, timezone

import numpy as np


# ---------------------------------------------------------------------------
# Quality thresholds
# ---------------------------------------------------------------------------

MODEL_QUALITY_THRESHOLDS = {
    "min_accuracy":  0.85,   # Below this → model is weak overall
    "min_recall":    0.80,   # Below this per class → unsafe (high false negatives)
    "min_precision": 0.80,   # Below this per class → high false positives
}


# ---------------------------------------------------------------------------
# Quality assessment
# ---------------------------------------------------------------------------

def assess_model_quality(
    results: dict,
    class_metrics: dict,
    class_names: list = None,
) -> dict:
    """Evaluate whether the model meets clinical deployment thresholds.

    Parameters
    ----------
    results:
        Dict from ``evaluate_model()`` (must contain ``accuracy``).
    class_metrics:
        Per-class metrics dict keyed by class name, each having
        ``precision`` and ``recall`` keys.
    class_names:
        Ordered list of class names; defaults to ``['low', 'mid', 'high']``.

    Returns
    -------
    dict
        Assessment with keys: ``min_accuracy``, ``is_weak``,
        ``unsafe_recall_classes``, ``unsafe_precision_classes``,
        ``recommendation``, and ``notes``.
    """
    if class_names is None:
        class_names = ["low", "mid", "high"]

    thresholds = MODEL_QUALITY_THRESHOLDS
    accuracy = float(results["accuracy"])

    is_weak = accuracy < thresholds["min_accuracy"]

    unsafe_recall_classes = [
        name
        for name in class_names
        if name in class_metrics
        and float(class_metrics[name]["recall"]) < thresholds["min_recall"]
    ]
    unsafe_precision_classes = [
        name
        for name in class_names
        if name in class_metrics
        and float(class_metrics[name]["precision"]) < thresholds["min_precision"]
    ]

    if is_weak or unsafe_recall_classes:
        recommendation = "Unsafe \u274c"
    elif unsafe_precision_classes:
        recommendation = "Needs Improvement \u26a0\ufe0f"
    else:
        recommendation = "Production Ready \u2705"

    # Build human-readable notes
    notes_parts = []
    if is_weak:
        notes_parts.append(
            f"Overall accuracy {accuracy:.1%} is below the {thresholds['min_accuracy']:.0%} "
            "threshold — model needs further training or data augmentation."
        )
    if unsafe_recall_classes:
        classes_str = ", ".join(unsafe_recall_classes)
        notes_parts.append(
            f"Classes with recall below {thresholds['min_recall']:.0%} "
            f"(high false-negative rate — clinically unsafe): {classes_str}."
        )
    if unsafe_precision_classes:
        classes_str = ", ".join(unsafe_precision_classes)
        notes_parts.append(
            f"Classes with precision below {thresholds['min_precision']:.0%} "
            f"(high false-positive rate — increased over-triage): {classes_str}."
        )
    if not notes_parts:
        # Find the best performing class on recall for a positive note
        best_cls = max(
            (n for n in class_names if n in class_metrics),
            key=lambda n: class_metrics[n]["recall"],
            default=None,
        )
        if best_cls:
            best_recall = class_metrics[best_cls]["recall"]
            notes_parts.append(
                "Model shows strong balanced performance across all risk levels. "
                f"{best_cls.capitalize()}-risk identification is excellent "
                f"({best_recall:.0%} recall)."
            )
        else:
            notes_parts.append(
                "Model meets all clinical quality thresholds."
            )

    return {
        "min_accuracy":            round(accuracy, 4),
        "is_weak":                 is_weak,
        "unsafe_recall_classes":   unsafe_recall_classes,
        "unsafe_precision_classes": unsafe_precision_classes,
        "recommendation":          recommendation,
        "notes":                   " ".join(notes_parts),
    }


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
    """Save evaluation metrics (including quality assessment) to JSON.

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
    for name in class_names:
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

    quality = assess_model_quality(results, class_metrics, class_names)

    payload = {
        "generated_at": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "overall_metrics": {
            "accuracy":  round(float(results["accuracy"]), 4),
            "precision": round(float(results["precision"]), 4),
            "recall":    round(float(results["recall"]), 4),
            "f1":        round(float(results["f1"]), 4),
            "auc_roc":   round(float(results["auc_roc"]), 4),
        },
        "confusion_matrix":  cm_dict,
        "class_metrics":     class_metrics,
        "quality_assessment": quality,
        "optimal_thresholds": named_thresholds,
        "test_set_stats":     test_stats,
    }

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as fh:
        json.dump(payload, fh, indent=2)

    print(f"  Evaluation metrics JSON saved -> {output_path}")
    return output_path


# ---------------------------------------------------------------------------
# Markdown evaluation report
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

- All metrics are computed on the held-out test split (30% of the full dataset).
- The model is a **stacking ensemble**: Random Forest + XGBoost + SVM (base),  
  Logistic Regression (meta-learner).
- Features were normalised with Min-Max scaling; training set was balanced with SMOTE.
"""

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as fh:
        fh.write(report)

    print(f"  Evaluation report (Markdown) saved -> {output_path}")
    return output_path


# ---------------------------------------------------------------------------
# Model quality assessment report
# ---------------------------------------------------------------------------

def generate_model_quality_report(
    results: dict,
    class_report: dict,
    class_names: list = None,
    output_path: str = "reports/MODEL_QUALITY_ASSESSMENT.md",
) -> str:
    """Generate a clinical deployment readiness report in Markdown.

    Parameters
    ----------
    results:
        Dict returned by ``evaluate_model()``.
    class_report:
        Dict returned by ``sklearn.metrics.classification_report(...,
        output_dict=True)``.
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

    # Build class_metrics dict from class_report
    class_metrics = {}
    for name in class_names:
        if name in class_report:
            entry = class_report[name]
            class_metrics[name] = {
                "precision": round(float(entry["precision"]), 4),
                "recall":    round(float(entry["recall"]), 4),
                "f1":        round(float(entry["f1-score"]), 4),
                "support":   int(entry["support"]),
            }

    quality = assess_model_quality(results, class_metrics, class_names)
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")
    thresholds = MODEL_QUALITY_THRESHOLDS

    # Overall accuracy description
    acc = results["accuracy"]
    acc_desc = "Good overall correctness" if acc >= thresholds["min_accuracy"] else "Below clinical threshold"

    # Per-class performance table rows
    def _status(m):
        p_ok = m["precision"] >= thresholds["min_precision"]
        r_ok = m["recall"]    >= thresholds["min_recall"]
        if p_ok and r_ok:
            return "\u2705 Meets thresholds"
        if not r_ok:
            return "\u274c Recall too low (unsafe)"
        return "\u26a0\ufe0f Precision needs improvement"

    perf_rows = []
    for name in class_names:
        if name in class_metrics:
            m = class_metrics[name]
            perf_rows.append(
                f"| {name.capitalize():<4} | {m['precision']:.0%}      | "
                f"{m['recall']:.0%}   | {m['f1']:.0%}     | {_status(m)} |"
            )
    perf_table = (
        "| Risk Level | Precision | Recall | F1 Score | Assessment |\n"
        "|------------|-----------|--------|----------|------------|\n"
        + "\n".join(perf_rows) + "\n"
    )

    # False negative / false positive summary for high-risk class
    high_metrics = class_metrics.get("high", {})
    high_recall    = high_metrics.get("recall", 0.0)
    high_precision = high_metrics.get("precision", 0.0)
    fn_pct = (1 - high_recall) * 100
    fp_pct = (1 - high_precision) * 100
    fn_verdict = "ACCEPTABLE for clinical use" if high_recall >= thresholds["min_recall"] else "TOO HIGH — unsafe for clinical use"
    fp_verdict = "Manageable; errs on side of caution" if high_precision >= thresholds["min_precision"] else "Too high — investigate class imbalance"

    report = f"""# Model Quality Assessment Report

*Generated: {now}*

---

## Overall Recommendation: {quality['recommendation']}

### Performance Summary

- **Accuracy:** {acc:.2%} — {acc_desc}
- **Quality Notes:** {quality['notes']}

---

## Quality Thresholds

| Metric              | Threshold | Result |
|---------------------|-----------|--------|
| Overall Accuracy    | ≥ {thresholds['min_accuracy']:.0%}     | {acc:.2%} {"✅" if not quality['is_weak'] else "❌"} |
| Min Recall per class | ≥ {thresholds['min_recall']:.0%}     | {"✅ All clear" if not quality['unsafe_recall_classes'] else "❌ " + ", ".join(quality['unsafe_recall_classes'])} |
| Min Precision per class | ≥ {thresholds['min_precision']:.0%}  | {"✅ All clear" if not quality['unsafe_precision_classes'] else "⚠️ " + ", ".join(quality['unsafe_precision_classes'])} |

---

## Per-Class Performance

{perf_table}
---

## Clinical Safety Analysis

- **False Negatives (missed high-risk):** {fn_pct:.0f}% — {fn_verdict}
- **False Positives (over-triaged):** {fp_pct:.0f}% — {fp_verdict}

### Interpretation Guide

| Risk Level | Clinical Concern | Threshold Rationale |
|------------|-----------------|---------------------|
| High       | Missing a high-risk patient is dangerous | Recall ≥ {thresholds['min_recall']:.0%} required |
| Mid        | Under-triaging mid-risk delays care | Recall ≥ {thresholds['min_recall']:.0%} required |
| Low        | Over-triaging wastes limited resources | Precision ≥ {thresholds['min_precision']:.0%} preferred |

---

## Recommendation

**{quality['recommendation']}**

{quality['notes']}

---

## How Thresholds Were Chosen

- **Accuracy ≥ {thresholds['min_accuracy']:.0%}:** Minimum acceptable overall correctness for a medical triage aid.
- **Recall ≥ {thresholds['min_recall']:.0%} per class:** Below this, too many patients in a risk category are
  misclassified — clinically unacceptable, particularly for the high-risk class.
- **Precision ≥ {thresholds['min_precision']:.0%} per class:** Below this, excessive over-triage wastes clinical
  resources and reduces trust in the system.
"""

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as fh:
        fh.write(report)

    print(f"  Model quality assessment saved -> {output_path}")
    return output_path
