# Maternal Triage Model — Evaluation Report

*Generated: 2026-07-22 04:28 UTC*

---

## 1. Overall Metrics

| Metric    | Value  |
|-----------|--------|
| Accuracy  | 0.9498 |
| Precision | 0.9491 |
| Recall    | 0.9486 |
| F1 Score  | 0.9489 |
| AUC-ROC   | 0.9860 |

> Precision, Recall, and F1-Score are **macro-averaged** across all classes.  
> AUC-ROC uses the **One-vs-Rest (OvR)** strategy.

---

## 2. Per-Class Metrics

| Class | Precision | Recall | F1-Score | Support |
|-------|-----------|--------|----------|---------|
| low   | 0.9542    | 0.9574 | 0.9558   | 305     |
| high  | 0.9440    | 0.9399 | 0.9419   | 233     |

---

## 3. Confusion Matrix

*(rows = actual class, columns = predicted class)*

| Actual \ Predicted | low | high |
|---|---|---|
| **low** | 292 | 13 |
| **high** | 14 | 219 |

---

## 4. Optimal Decision Thresholds (Youden's Index)

| Class | Optimal Threshold |
|-------|-------------------|
| low   | 0.4377            |
| 2     | 0.5709            |

> The threshold that maximises *sensitivity + specificity − 1* for each class.

---

## 5. Test-Set Statistics

- **Total samples**: 538

- **low**: 305 samples

---

## 6. Notes

- All metrics are computed on the held-out test split (30% of the full dataset).
- The model is a **stacking ensemble**: Random Forest + XGBoost + SVM (base),  
  Logistic Regression (meta-learner).
- Features were normalised with Min-Max scaling; training set was balanced with SMOTE.
