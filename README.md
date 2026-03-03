# Maternal Triage System

An **Explainable AI-Based Maternal Triage Decision-Support System** for Primary Health Centres.

The system combines a Python machine-learning pipeline that trains a stacking ensemble classifier
on three maternal health datasets, generates SHAP explanations, and exports the model to TFLite —
with a Flutter mobile application that runs on-device inference and presents transparent, colour-coded
risk assessments to frontline clinicians.

---

## Repository Structure

```
maternal-triage-system/
├── ml_pipeline/               # Python ML pipeline
│   ├── data/
│   │   ├── raw/               # Place raw CSV datasets here
│   │   └── processed/         # Preprocessing outputs
│   ├── models/                # Saved .pkl and .tflite models
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
│   │   ├── models/            # Place maternal_triage_model.tflite here
│   │   └── shap/              # Place shap_values.json here
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

1. **Train** the model with `ml_pipeline/src/train.py` — produces `models/stacking_model.pkl`.
2. **Export SHAP values** with `ml_pipeline/src/explainability.py` — produces `shap_values/shap_values.json`.
3. **Convert to TFLite** with `ml_pipeline/src/convert_model.py` — produces `models/maternal_triage_model.tflite`.
4. **Copy** `maternal_triage_model.tflite` → `flutter_app/assets/models/`
5. **Copy** `shap_values.json` → `flutter_app/assets/shap/`
6. Update `flutter_app/lib/utils/constants.dart` with the normalisation min/max values from
   `ml_pipeline/models/scaler_params.json`.
7. Rebuild the Flutter app.

---

## Datasets

| Dataset    | Records | Reference |
|------------|---------|-----------|
| FUTH Akure | 149     | Local hospital records |
| Mendeley   | 1206    | Mendeley Data repository |
| Kaggle/UCI | 1015    | UCI Machine Learning Repository via Kaggle |
| **Combined** | **2370** | Union of all three |
