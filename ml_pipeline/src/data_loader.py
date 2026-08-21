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

# First Mercy & Tim Unity share the same column layout
HOSPITAL_RENAME = {
    "Age": "Age",
    "Systolic BP": "SystolicBP",
    "Diastolic BP": "DiastolicBP",
    "Blood Sugar": "BloodSugar",
    "Body Temp (°F)": "BodyTemp",
    "Heart Rate": "HeartRate",
    "Weight (kg)": "Weight",
    "Height (cm)": "Height",
    "Risk Level": "RiskLevel",
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


def load_hospital_dataset(path: str, source_name: str) -> pd.DataFrame:
    """Load a local hospital dataset (First Mercy or Tim Unity format).

    Height is stored in cm in these files; it is converted to metres here
    so it is consistent with FUTH and the BMI computation downstream.

    Parameters
    ----------
    path : str
        Path to the hospital CSV file.
    source_name : str
        Label used for the 'source' column (e.g. 'first_mercy').

    Returns
    -------
    pd.DataFrame
    """
    df = pd.read_csv(path)
    df.columns = [c.strip() for c in df.columns]
    df = df.rename(columns=HOSPITAL_RENAME)
    # Height in these files is in cm — convert to metres to match FUTH
    if "Height" in df.columns:
        df["Height"] = df["Height"] / 100.0
    df["source"] = source_name
    return df


def combine_datasets(*dfs: pd.DataFrame) -> pd.DataFrame:
    """Merge all datasets into one unified DataFrame.

    Accepts any number of DataFrames so new hospital datasets can be
    passed in without changing the call signature.  Columns are aligned
    via the UNIFIED_COLUMNS schema; missing columns are filled with NaN.

    Returns
    -------
    pd.DataFrame
        Combined DataFrame with all unified columns present.
    """
    combined = pd.concat(list(dfs), axis=0, ignore_index=True)
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

    df_futh        = load_futh_dataset(os.path.join(BASE, "futh_dataset.csv"))
    df_mendeley    = load_mendeley_dataset(os.path.join(BASE, "mendeley_dataset.csv"))
    df_kaggle      = load_kaggle_dataset(os.path.join(BASE, "kaggle_dataset.csv"))
    df_first_mercy = load_hospital_dataset(os.path.join(BASE, "First_Mercy_Hospital_155_Records.csv"), "first_mercy")
    df_tim_unity   = load_hospital_dataset(os.path.join(BASE, "Tim_Unity_Hospital_105_Records.csv"),   "tim_unity")

    print(f"FUTH        : {df_futh.shape[0]} rows")
    print(f"Mendeley    : {df_mendeley.shape[0]} rows")
    print(f"Kaggle      : {df_kaggle.shape[0]} rows")
    print(f"First Mercy : {df_first_mercy.shape[0]} rows")
    print(f"Tim Unity   : {df_tim_unity.shape[0]} rows")

    combined = combine_datasets(df_futh, df_mendeley, df_kaggle, df_first_mercy, df_tim_unity)
    print(f"\nCombined : {combined.shape[0]} rows, {combined.shape[1]} cols")
    print("\nClass distribution (raw):")
    print(combined["RiskLevel"].value_counts())
    print("\nMissing values per column:")
    print(combined.isnull().sum())