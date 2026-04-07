# Model Quality Assessment Report

*Generated: 2026-04-04 20:55 UTC*

---

## Overall Recommendation: Unsafe ❌

### Performance Summary

- **Accuracy:** 85.52% — Good overall correctness
- **Quality Notes:** Classes with recall below 80% (high false-negative rate — clinically unsafe): mid. Classes with precision below 80% (high false-positive rate — increased over-triage): mid.

---

## Quality Thresholds

| Metric              | Threshold | Result |
|---------------------|-----------|--------|
| Overall Accuracy    | ≥ 85%     | 85.52% ✅ |
| Min Recall per class | ≥ 80%     | ❌ mid |
| Min Precision per class | ≥ 80%  | ⚠️ mid |

---

## Per-Class Performance

| Risk Level | Precision | Recall | F1 Score | Assessment |
|------------|-----------|--------|----------|------------|
| Low  | 90%      | 87%   | 88%     | ✅ Meets thresholds |
| Mid  | 25%      | 28%   | 26%     | ❌ Recall too low (unsafe) |
| High | 91%      | 92%   | 91%     | ✅ Meets thresholds |

---

## Clinical Safety Analysis

- **False Negatives (missed high-risk):** 8% — ACCEPTABLE for clinical use
- **False Positives (over-triaged):** 9% — Manageable; errs on side of caution

### Interpretation Guide

| Risk Level | Clinical Concern | Threshold Rationale |
|------------|-----------------|---------------------|
| High       | Missing a high-risk patient is dangerous | Recall ≥ 80% required |
| Mid        | Under-triaging mid-risk delays care | Recall ≥ 80% required |
| Low        | Over-triaging wastes limited resources | Precision ≥ 80% preferred |

---

## Recommendation

**Unsafe ❌**

Classes with recall below 80% (high false-negative rate — clinically unsafe): mid. Classes with precision below 80% (high false-positive rate — increased over-triage): mid.

---

## How Thresholds Were Chosen

- **Accuracy ≥ 85%:** Minimum acceptable overall correctness for a medical triage aid.
- **Recall ≥ 80% per class:** Below this, too many patients in a risk category are
  misclassified — clinically unacceptable, particularly for the high-risk class.
- **Precision ≥ 80% per class:** Below this, excessive over-triage wastes clinical
  resources and reduces trust in the system.
