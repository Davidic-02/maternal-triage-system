# ML Pipeline — Maternal Triage System

Python machine-learning pipeline for the Explainable AI-Based Maternal Triage Decision-Support System.

## Directory Layout

```
ml_pipeline/
├── data/
│   ├── raw/          ← place raw CSV datasets here
│   └── processed/    ← preprocessed outputs
├── models/           ← saved .pkl and .tflite models
├── notebooks/
│   └── 01_eda.ipynb  ← Exploratory Data Analysis
├── reports/          ← generated plots (heatmaps, ROC curves, …)
├── shap_values/      ← precomputed SHAP JSON files
├── src/
│   ├── __init__.py
│   ├── data_loader.py
│   ├── preprocessing.py
│   ├── feature_engineering.py
│   ├── balancing.py
│   ├── train.py
│   ├── evaluate.py
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

## Datasets

| Dataset    | Records | Source               |
|------------|---------|----------------------|
| FUTH Akure | 149     | Local hospital records |
| Mendeley   | 1206    | Mendeley Data repository |
| Kaggle/UCI | 1015    | UCI via Kaggle       |

Place the CSV files in `data/raw/` before running the pipeline.
