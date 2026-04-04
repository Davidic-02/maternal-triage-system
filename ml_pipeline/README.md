# ML Pipeline — Maternal Triage System

Python machine-learning pipeline for the Explainable AI-Based Maternal Triage Decision-Support System.

## Directory Layout

```
ml_pipeline/
├── data/
│   ├── raw/          ← place raw CSV datasets here
│   └── processed/    ← preprocessed outputs
├── models/
│   ├── *.pkl / *.tflite         ← saved models
│   └── evaluation_metrics.json  ← auto-generated metrics (JSON)
├── notebooks/
│   └── 01_eda.ipynb  ← Exploratory Data Analysis
├── reports/
│   ├── confusion_matrix.png          ← generated confusion-matrix plot
│   ├── roc_curves.png                ← generated ROC-curve plot
│   ├── EVALUATION_REPORT.md          ← auto-generated evaluation report
│   └── MODEL_QUALITY_ASSESSMENT.md   ← auto-generated quality assessment
├── shap_values/      ← precomputed SHAP JSON files
├── src/
│   ├── __init__.py
│   ├── data_loader.py
│   ├── preprocessing.py
│   ├── feature_engineering.py
│   ├── balancing.py
│   ├── train.py
│   ├── evaluate.py
│   ├── reporting.py
│   ├── explainability.py
│   └── convert_model.py
└── requirements.txt
```

## Setup

```bash
# Create and activate a virtual environment
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

## Running the Notebook

```bash
cd ml_pipeline
jupyter notebook notebooks/01_eda.ipynb
```

## Pipeline Steps

1. **Data Loading** (`src/data_loader.py`) — load and merge the three CSV datasets.
2. **Preprocessing** (`src/preprocessing.py`) — deduplication, imputation, encoding.
3. **Feature Engineering** (`src/feature_engineering.py`) — BMI, Pulse Pressure, correlation/MI analysis.
4. **Balancing** (`src/balancing.py`) — SMOTE oversampling on the training set.
5. **Training** (`src/train.py`) — stacking ensemble (RF + XGBoost + SVM → LR meta-learner).
6. **Evaluation** (`src/evaluate.py`) — accuracy, precision, recall, F1, AUC-ROC, confusion matrix.
7. **Explainability** (`src/explainability.py`) — SHAP global and local explanations.
8. **Conversion** (`src/convert_model.py`) — export model to TFLite for the Flutter app.

## Pipeline Outputs

Running `python -m src.evaluate` automatically produces:

| File | Description |
|------|-------------|
| `models/evaluation_metrics.json`       | Structured JSON: overall metrics, per-class metrics, confusion matrix, Youden thresholds, and quality assessment |
| `reports/EVALUATION_REPORT.md`         | Human-readable Markdown evaluation report |
| `reports/MODEL_QUALITY_ASSESSMENT.md`  | Clinical deployment readiness report with per-class safety analysis |
| `reports/confusion_matrix.png`         | Confusion-matrix heatmap |
| `reports/roc_curves.png`               | One-vs-Rest ROC curves with per-class AUC |

### Example JSON structure

```json
{
  "generated_at": "2026-04-03T00:00:00Z",
  "overall_metrics": {
    "accuracy": 0.9234,
    "precision": 0.9156,
    "recall": 0.8945,
    "f1": 0.9049,
    "auc_roc": 0.9567
  },
  "confusion_matrix": {
    "low":  {"low": 80, "mid": 3, "high": 1},
    "mid":  {"low": 2,  "mid": 75, "high": 4},
    "high": {"low": 0,  "mid": 2,  "high": 70}
  },
  "class_metrics": {
    "low":  {"precision": 0.9756, "recall": 0.9524, "f1": 0.9639, "support": 84},
    "mid":  {"precision": 0.9375, "recall": 0.9259, "f1": 0.9317, "support": 81},
    "high": {"precision": 0.9333, "recall": 0.9722, "f1": 0.9524, "support": 72}
  },
  "quality_assessment": {
    "min_accuracy": 0.9234,
    "is_weak": false,
    "unsafe_recall_classes": [],
    "unsafe_precision_classes": [],
    "recommendation": "Production Ready ✅",
    "notes": "Model shows strong balanced performance across all risk levels."
  },
  "optimal_thresholds": {
    "low": 0.4821,
    "mid": 0.5103,
    "high": 0.4967
  },
  "test_set_stats": {
    "total_samples": 237,
    "class_distribution": {"low": 84, "mid": 81, "high": 72}
  }
}
```

## Evaluating Model Quality for Clinical Use

The `reporting.py` module applies objective thresholds to flag deployment concerns:

| Threshold | Value | Rationale |
|-----------|-------|-----------|
| Minimum overall accuracy | 85% | Below this the model is too unreliable for triage decisions |
| Minimum recall per class | 80% | Below this, too many patients in that risk category are missed |
| Minimum precision per class | 80% | Below this, excessive over-triage wastes limited clinical resources |

The `quality_assessment` block in the JSON provides:
- **`is_weak`** — `true` when accuracy falls below the minimum threshold.
- **`unsafe_recall_classes`** — list of risk classes where recall < 80 % (clinically unsafe).
- **`unsafe_precision_classes`** — list of classes where precision < 80 % (excessive over-triage).
- **`recommendation`** — one of `"Production Ready ✅"`, `"Needs Improvement ⚠️"`, or `"Unsafe ❌"`.

`reports/MODEL_QUALITY_ASSESSMENT.md` presents the same findings as a human-readable document
with a per-class performance table and clinical safety analysis.

## Datasets

| Dataset    | Records | Source               |
|------------|---------|----------------------|
| FUTH Akure | 149     | Local hospital records |
| Mendeley   | 1206    | Mendeley Data repository |
| Kaggle/UCI | 1015    | UCI via Kaggle       |

Place the CSV files in `data/raw/` before running the pipeline.
