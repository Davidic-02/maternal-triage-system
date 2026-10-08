# Maternal Triage System

An **Explainable AI-Based Maternal Triage Decision-Support System** for Primary Health Centres.

The system combines a Python machine-learning pipeline that trains a binary (low vs high risk)
stacking ensemble on five maternal health data sources (three Nigerian hospitals, plus the public
Mendeley and Kaggle/UCI datasets) and exports it to ONNX, with a Flutter mobile application that
runs inference fully offline and presents colour-coded risk assessments to frontline health workers.

**Per-patient explanations, on-device.** For every assessment the app computes Shapley values for
that patient's own inputs (64 antithetic permutations against a 16-point k-means background,
scored in one batched ONNX call). The method is mirrored and validated in
`ml_pipeline/src/export_explainer_assets.py` against `shap.KernelExplainer`; results are in
`ml_pipeline/reports/binary/explanation_validation.json`.

**Offline by default.** The plain-language explanation is generated on-device from the patient's
SHAP factors. An optional Gemini-written explanation can be enabled at build time with
`--dart-define=ALLOW_ONLINE_EXPLANATIONS=true` (requires `GEMINI_API_KEY` in `flutter_app/.env`);
when enabled, patient vitals are sent to Google's API.

---

## Repository Structure

```
maternal-triage-system/
├── ml_pipeline/               # Python ML pipeline
│   ├── data/
│   │   ├── raw/               # Place raw CSV datasets here
│   │   └── processed/         # Preprocessing outputs
│   ├── models/                # Saved .pkl and .onnx models
│   ├── notebooks/
│   │   └── 01_eda.ipynb       # Exploratory Data Analysis
│   ├── reports/               # Generated plots
│   ├── shap_values/           # Pre-computed SHAP JSON
│   ├── src/
│   │   ├── data_loader.py
│   │   ├── preprocessing.py
│   │   ├── feature_engineering.py
│   │   ├── balancing.py
│   │   ├── train.py
│   │   ├── evaluate.py
│   │   ├── explainability.py
│   │   └── convert_model.py
│   ├── requirements.txt
│   └── README.md
│
├── flutter_app/               # Flutter mobile application
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   ├── providers/
│   │   ├── screens/
│   │   ├── services/
│   │   ├── utils/
│   │   └── widgets/
│   ├── assets/
│   │   ├── models/            # maternal_triage_model.onnx
│   │   └── shap/              # background.json (from export_explainer_assets.py)
│   └── pubspec.yaml
│
└── README.md
```

---

## Python ML Pipeline Setup

```bash
cd ml_pipeline

# Create and activate a virtual environment
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Running the EDA Notebook

```bash
jupyter notebook notebooks/01_eda.ipynb
```

Place the CSV datasets in `ml_pipeline/data/raw/` before running the notebook or pipeline scripts.

---

## Flutter App Setup

```bash
cd flutter_app

# Install Flutter dependencies
flutter pub get
```

### Firebase Setup

1. Create a Firebase project at <https://console.firebase.google.com/>.
2. Add an Android and/or iOS app to the project.
3. Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and place them
   in the appropriate platform directories.
4. Enable **Email/Password** sign-in in Firebase Authentication.
5. Create a **Cloud Firestore** database.

### Running the App

```bash
flutter run
```

---

## Connecting the Two Components

Run each step from `ml_pipeline/`:

1. **Train** with `python -m src.train`. This writes `models/stacking_model.pkl`, `models/scaler_params.json` and `models/decision_threshold.json`.
2. **Convert to ONNX** with `python -m src.convert_model`. This writes `models/stacking_model.onnx` and copies it to `flutter_app/assets/models/maternal_triage_model.onnx`.
3. **Copy** `models/scaler_params.json` and `models/decision_threshold.json` to `flutter_app/assets/scaler/`.
4. **Export the explanation background** with `python -m src.export_explainer_assets`. This writes `flutter_app/assets/shap/background.json` and the validation report.
5. Rebuild the Flutter app.

---

## Datasets

| Dataset    | Records | Reference |
|------------|---------|-----------|
| FUTH Akure | 149     | Local hospital records |
| Mendeley   | 1206    | Mendeley Data repository |
| Kaggle/UCI | 1015    | UCI Machine Learning Repository via Kaggle |
| **Combined** | **2370** | Union of all three |
