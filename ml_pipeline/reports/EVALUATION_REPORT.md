# Maternal Triage Model — Evaluation Report

*Generated: 2026-04-04 20:55 UTC*

---

## 1. Overall Metrics

| Metric    | Value  |
|-----------|--------|
| Accuracy  | 0.8552 |
| Precision | 0.6837 |
| Recall    | 0.6915 |
| F1 Score  | 0.6872 |
| AUC-ROC   | 0.9106 |

> Precision, Recall, and F1-Score are **macro-averaged** across all classes.  
> AUC-ROC uses the **One-vs-Rest (OvR)** strategy.

---

## 2. Per-Class Metrics

| Class | Precision | Recall | F1-Score | Support |
|-------|-----------|--------|----------|---------|
| low   | 0.8953    | 0.8702 | 0.8826   | 285     |
| mid   | 0.2500    | 0.2812 | 0.2647   | 32      |
| high  | 0.9057    | 0.9231 | 0.9143   | 208     |

---

## 3. Confusion Matrix

*(rows = actual class, columns = predicted class)*

| Actual \ Predicted | low | mid | high |
|---|---|---|---|
| **low** | 248 | 22 | 15 |
| **mid** | 18 | 9 | 5 |
| **high** | 11 | 5 | 192 |

---

## 4. Optimal Decision Thresholds (Youden's Index)

| Class | Optimal Threshold |
|-------|-------------------|
| low   | 0.6578            |
| mid   | 0.0354            |
| high  | 0.3167            |

> The threshold that maximises *sensitivity + specificity − 1* for each class.

---

## 5. Test-Set Statistics

- **Total samples**: 525

- **low**: 285 samples
- **mid**: 32 samples
- **high**: 208 samples

---

## 6. Notes

- All metrics are computed on the held-out test split (30% of the full dataset).
- The model is a **stacking ensemble**: Random Forest + XGBoost + SVM (base),  
  Logistic Regression (meta-learner).
- Features were normalised with Min-Max scaling; training set was balanced with SMOTE.
