"""
feature_engineering.py
-----------------------
Derived feature computation and feature-selection analysis utilities.
"""

from __future__ import annotations

import os

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from sklearn.feature_selection import mutual_info_classif


# ---------------------------------------------------------------------------
# Derived clinical features
# ---------------------------------------------------------------------------

def compute_bmi(df: pd.DataFrame) -> pd.DataFrame:
    """Compute BMI = Weight / Height² for records where BMI is missing.

    Height is assumed to be in metres.  If *Weight* or *Height* columns
    are absent the DataFrame is returned unchanged.

    Parameters
    ----------
    df : pd.DataFrame

    Returns
    -------
    pd.DataFrame
    """
    df = df.copy()
    if "BMI" not in df.columns:
        df["BMI"] = np.nan
    if "Weight" in df.columns and "Height" in df.columns:
        mask = df["BMI"].isna() & df["Weight"].notna() & df["Height"].notna()
        df.loc[mask, "BMI"] = df.loc[mask, "Weight"] / (df.loc[mask, "Height"] ** 2)
    return df


def compute_pulse_pressure(df: pd.DataFrame) -> pd.DataFrame:
    """Compute Pulse Pressure = SystolicBP - DiastolicBP.

    Parameters
    ----------
    df : pd.DataFrame

    Returns
    -------
    pd.DataFrame
    """
    df = df.copy()
    if "SystolicBP" in df.columns and "DiastolicBP" in df.columns:
        df["PulsePressure"] = df["SystolicBP"] - df["DiastolicBP"]
    return df


# ---------------------------------------------------------------------------
# Analysis helpers
# ---------------------------------------------------------------------------

def correlation_analysis(
    df: pd.DataFrame,
    output_dir: str = "reports",
    filename: str = "correlation_heatmap.png",
) -> pd.DataFrame:
    """Compute Pearson correlation matrix and save a heatmap.

    Parameters
    ----------
    df : pd.DataFrame
        Should contain only numeric features (no target column).
    output_dir : str
        Directory in which the heatmap PNG will be saved.
    filename : str
        Output file name.

    Returns
    -------
    pd.DataFrame
        Correlation matrix.
    """
    numeric_df = df.select_dtypes(include=[np.number])
    corr = numeric_df.corr()

    os.makedirs(output_dir, exist_ok=True)
    fig, ax = plt.subplots(figsize=(12, 10))
    sns.heatmap(corr, annot=True, fmt=".2f", cmap="coolwarm", ax=ax)
    ax.set_title("Pearson Correlation Matrix")
    fig.tight_layout()
    fig.savefig(os.path.join(output_dir, filename))
    plt.close(fig)

    return corr


def mutual_information_scores(
    X: pd.DataFrame,
    y: pd.Series,
    random_state: int = 42,
) -> pd.Series:
    """Compute Mutual Information scores for all features vs. target label.

    Parameters
    ----------
    X : pd.DataFrame
        Feature matrix (numeric).
    y : pd.Series
        Target labels.
    random_state : int

    Returns
    -------
    pd.Series
        MI scores indexed by feature name, sorted descending.
    """
    scores = mutual_info_classif(X.fillna(0), y, random_state=random_state)
    return (
        pd.Series(scores, index=X.columns)
        .sort_values(ascending=False)
    )
