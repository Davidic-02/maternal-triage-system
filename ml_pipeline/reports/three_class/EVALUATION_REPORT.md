# Maternal Triage Model — Evaluation Report

*Generated: 2026-06-30 08:52 UTC*

---

## 1. Overall Metrics

| Metric    | Value  |
|-----------|--------|
| Accuracy  | 0.8673 |
| Precision | 0.8009 |
| Recall    | 0.7579 |
| F1 Score  | 0.7722 |
| AUC-ROC   | 0.9469 |

> Precision, Recall, and F1-Score are **macro-averaged** across all classes.  
> AUC-ROC uses the **One-vs-Rest (OvR)** strategy.

---

## 2. Per-Class Metrics

| Class | Precision | Recall | F1-Score | Support |
|-------|-----------|--------|----------|---------|
| low   | 0.9085    | 0.9115 | 0.9100   | 305     |
| mid   | 0.6364    | 0.4308 | 0.5138   | 65      |
| high  | 0.8577    | 0.9313 | 0.8930   | 233     |

---

## 3. Confusion Matrix

*(rows = actual class, columns = predicted class)*

| Actual \ Predicted | low | mid | high |
|---|---|---|---|
| **low** | 278 | 10 | 17 |
| **mid** | 18 | 28 | 19 |
| **high** | 10 | 6 | 217 |

---

## 4. Optimal Decision Thresholds (Youden's Index)

| Class | Optimal Threshold |
|-------|-------------------|
| low   | 0.3454            |
| mid   | 0.1065            |
| high  | 0.4522            |

> The threshold that maximises *sensitivity + specificity − 1* for each class.

---

## 5. Test-Set Statistics

- **Total samples**: 603

- **low**: 305 samples
- **mid**: 65 samples
- **high**: 233 samples

---

## 6. Notes

- All metrics are computed on the held-out test split (30% of the full dataset).
- The model is a **stacking ensemble**: Random Forest + XGBoost + SVM (base),  
  Logistic Regression (meta-learner).
- Features were normalised with Min-Max scaling; training set was balanced with SMOTE.
