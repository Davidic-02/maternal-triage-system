"""
data_loader.py
--------------
Functions to load and combine the three maternal health datasets.
"""

import os
import pandas as pd
import numpy as np


# ---------------------------------------------------------------------------
# Raw column names AS THEY APPEAR in each CSV  →  unified name
# ---------------------------------------------------------------------------
FUTH_RENAME = {
    "Age": "Age",
    "StytolicBp": "SystolicBP",      # typo in source file
    "DiastolicBp": "DiastolicBP",
    "BodyTemp": "BodyTemp",
    "Heart Rate": "HeartRate",
    "Weight": "Weight",
    "Height": "Height",
    "RiskLevel": "RiskLevel",
}

MENDELEY_RENAME = {
    "Age": "Age",
    "Systolic BP": "SystolicBP",
    "Diastolic": "DiastolicBP",
    "BS": "BloodSugar",
    "Body Temp": "BodyTemp",
    "BMI": "BMI",
    "Previous Complications": "PreviousComplications",
    "Preexisting Diabetes": "PreexistingDiabetes",
    "Gestational Diabetes": "GestationalDiabetes",
    "Mental Health": "MentalHealthStatus",
    "Heart Rate": "HeartRate",
    "Risk Level": "RiskLevel",
}

KAGGLE_RENAME = {
    "Age": "Age",
    "SystolicBP": "SystolicBP",
    "DiastolicBP": "DiastolicBP",
    "BS": "BloodSugar",
    "BodyTemp": "BodyTemp",
    "HeartRate": "HeartRate",
    "RiskLevel": "RiskLevel",
}

# Unified feature schema (union of all three feature sets)
UNIFIED_COLUMNS = [
    "Age", "SystolicBP", "DiastolicBP", "BloodSugar", "BodyTemp",
    "BMI", "HeartRate", "Weight", "Height",
    "PreviousComplications", "PreexistingDiabetes",
    "GestationalDiabetes", "MentalHealthStatus",
    "RiskLevel", "source",
]


def load_futh_dataset(path: str) -> pd.DataFrame:
    """Load the FUTH Akure dataset.

    Parameters
    ----------
    path : str
        Path to futh_dataset.csv

    Returns
    -------
    pd.DataFrame
    """
    df = pd.read_csv(path)
    df.columns = [c.strip() for c in df.columns]
    df = df.rename(columns=FUTH_RENAME)
    df["source"] = "futh"
    return df


def load_mendeley_dataset(path: str) -> pd.DataFrame:
    """Load the Mendeley dataset.

    Parameters
    ----------
    path : str
        Path to mendeley_dataset.csv

    Returns
    -------
    pd.DataFrame
    """
    df = pd.read_csv(path)
    df.columns = [c.strip() for c in df.columns]
    df = df.rename(columns=MENDELEY_RENAME)
    df["source"] = "mendeley"
    return df


def load_kaggle_dataset(path: str) -> pd.DataFrame:
    """Load the Kaggle/UCI dataset.

    Parameters
    ----------
    path : str
        Path to kaggle_dataset.csv

    Returns
    -------
    pd.DataFrame
    """
    df = pd.read_csv(path)
    df.columns = [c.strip() for c in df.columns]
    df = df.rename(columns=KAGGLE_RENAME)
    df["source"] = "kaggle"
    return df


def combine_datasets(
    df_a: pd.DataFrame,
    df_b: pd.DataFrame,
    df_c: pd.DataFrame,
) -> pd.DataFrame:
    """Merge all three datasets into one unified DataFrame.

    Columns are aligned via the union of feature sets; missing columns
    are filled with NaN.

    Parameters
    ----------
    df_a : pd.DataFrame  — FUTH dataset
    df_b : pd.DataFrame  — Mendeley dataset
    df_c : pd.DataFrame  — Kaggle dataset

    Returns
    -------
    pd.DataFrame
        Combined DataFrame with all unified columns present.
    """
    combined = pd.concat([df_a, df_b, df_c], axis=0, ignore_index=True)
    # Ensure all unified columns exist (fill missing with NaN)
    for col in UNIFIED_COLUMNS:
        if col not in combined.columns:
            combined[col] = np.nan
    combined = combined[UNIFIED_COLUMNS]
    return combined


# ---------------------------------------------------------------------------
# Quick smoke-test when run directly:  python3 -m src.data_loader
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    BASE = os.path.join(os.path.dirname(__file__), "..", "data", "raw")

    futh_path     = os.path.join(BASE, "futh_dataset.csv")
    mendeley_path = os.path.join(BASE, "mendeley_dataset.csv")
    kaggle_path   = os.path.join(BASE, "kaggle_dataset.csv")

    df_futh     = load_futh_dataset(futh_path)
    df_mendeley = load_mendeley_dataset(mendeley_path)
    df_kaggle   = load_kaggle_dataset(kaggle_path)

    print(f"FUTH     : {df_futh.shape[0]} rows, {df_futh.shape[1]} cols")
    print(f"Mendeley : {df_mendeley.shape[0]} rows, {df_mendeley.shape[1]} cols")
    print(f"Kaggle   : {df_kaggle.shape[0]} rows, {df_kaggle.shape[1]} cols")

    combined = combine_datasets(df_futh, df_mendeley, df_kaggle)
    print(f"\nCombined : {combined.shape[0]} rows, {combined.shape[1]} cols")
    print("\nColumns  :", combined.columns.tolist())
    print("\nClass distribution:")
    print(combined["RiskLevel"].value_counts())
    print("\nMissing values per column:")
    print(combined.isnull().sum())