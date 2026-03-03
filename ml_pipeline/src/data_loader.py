"""
data_loader.py
--------------
Functions to load and combine the three maternal health datasets.
"""

import pandas as pd
import numpy as np


# ---------------------------------------------------------------------------
# Expected column sets per dataset
# ---------------------------------------------------------------------------
FUTH_COLUMNS = [
    "Age", "SystolicBP", "DiastolicBP", "BodyTemp", "HeartRate",
    "Weight", "Height", "RiskLevel",
]

MENDELEY_COLUMNS = [
    "Age", "SystolicBP", "DiastolicBP", "BloodSugar", "BodyTemp", "BMI",
    "HeartRate", "PreviousComplications", "PreexistingDiabetes",
    "GestationalDiabetes", "MentalHealthStatus", "RiskLevel",
]

KAGGLE_COLUMNS = [
    "Age", "SystolicBP", "DiastolicBP", "BloodSugar", "BodyTemp",
    "HeartRate", "RiskLevel",
]


def load_futh_dataset(path: str) -> pd.DataFrame:
    """Load the FUTH Akure dataset (149 records).

    Parameters
    ----------
    path : str
        Path to the CSV file.

    Returns
    -------
    pd.DataFrame
        DataFrame with expected FUTH columns; adds a ``source`` column.
    """
    df = pd.read_csv(path)
    df.columns = [c.strip() for c in df.columns]
    df = df[[c for c in FUTH_COLUMNS if c in df.columns]]
    df["source"] = "futh"
    return df


def load_mendeley_dataset(path: str) -> pd.DataFrame:
    """Load the Mendeley dataset (1206 records).

    Parameters
    ----------
    path : str
        Path to the CSV file.

    Returns
    -------
    pd.DataFrame
        DataFrame with expected Mendeley columns; adds a ``source`` column.
    """
    df = pd.read_csv(path)
    df.columns = [c.strip() for c in df.columns]
    df = df[[c for c in MENDELEY_COLUMNS if c in df.columns]]
    df["source"] = "mendeley"
    return df


def load_kaggle_dataset(path: str) -> pd.DataFrame:
    """Load the Kaggle/UCI dataset (1015 records).

    Parameters
    ----------
    path : str
        Path to the CSV file.

    Returns
    -------
    pd.DataFrame
        DataFrame with expected Kaggle columns; adds a ``source`` column.
    """
    df = pd.read_csv(path)
    df.columns = [c.strip() for c in df.columns]
    df = df[[c for c in KAGGLE_COLUMNS if c in df.columns]]
    df["source"] = "kaggle"
    return df


def combine_datasets(
    df_a: pd.DataFrame,
    df_b: pd.DataFrame,
    df_c: pd.DataFrame,
) -> pd.DataFrame:
    """Merge all three datasets into one unified DataFrame (N=2370).

    Columns are aligned via the union of feature sets; missing columns are
    filled with ``NaN``.

    Parameters
    ----------
    df_a : pd.DataFrame
        FUTH dataset.
    df_b : pd.DataFrame
        Mendeley dataset.
    df_c : pd.DataFrame
        Kaggle dataset.

    Returns
    -------
    pd.DataFrame
        Combined DataFrame with all columns present.
    """
    combined = pd.concat([df_a, df_b, df_c], axis=0, ignore_index=True)
    return combined
