"""
preprocessing.py
----------------
Data cleaning, imputation, harmonization, and encoding utilities.
"""

import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OrdinalEncoder


# ---------------------------------------------------------------------------
# Deduplication
# ---------------------------------------------------------------------------

def remove_duplicates(df: pd.DataFrame) -> pd.DataFrame:
    """Remove exact duplicate rows from *df*.

    Parameters
    ----------
    df : pd.DataFrame

    Returns
    -------
    pd.DataFrame
        DataFrame without duplicates.
    """
    return df.drop_duplicates().reset_index(drop=True)


# ---------------------------------------------------------------------------
# Imputation
# ---------------------------------------------------------------------------

def impute_missing(
    df: pd.DataFrame,
    strategy: str = "median",
    _medians: dict | None = None,
) -> tuple[pd.DataFrame, dict]:
    """Impute missing values in numeric columns using *strategy*.

    Fits on the supplied *df* (intended for training data) and returns
    the computed fill values so they can be applied to the test set.

    Parameters
    ----------
    df : pd.DataFrame
    strategy : str
        Only ``'median'`` is currently supported.
    _medians : dict | None
        Pre-computed fill values (for applying to test data).  When
        ``None`` the values are computed from *df*.

    Returns
    -------
    tuple[pd.DataFrame, dict]
        Imputed DataFrame and a dict of ``{column: fill_value}``.
    """
    numeric_cols = df.select_dtypes(include=[np.number]).columns.tolist()
    if _medians is None:
        if strategy != "median":
            raise ValueError(f"Unsupported strategy: {strategy!r}")
        _medians = {col: df[col].median() for col in numeric_cols}
    df = df.copy()
    df[numeric_cols] = df[numeric_cols].fillna(
        {c: _medians.get(c, df[c].median()) for c in numeric_cols}
    )
    return df, _medians


# ---------------------------------------------------------------------------
# Harmonization
# ---------------------------------------------------------------------------

_ALL_FEATURE_COLUMNS = [
    "Age", "SystolicBP", "DiastolicBP", "BloodSugar", "BodyTemp",
    "HeartRate", "Weight", "Height", "BMI",
    "PreviousComplications", "PreexistingDiabetes", "GestationalDiabetes",
    "MentalHealthStatus",
]


def harmonize_features(df: pd.DataFrame) -> pd.DataFrame:
    """Ensure all feature columns exist; fill missing ones with NaN.

    Parameters
    ----------
    df : pd.DataFrame

    Returns
    -------
    pd.DataFrame
    """
    df = df.copy()
    for col in _ALL_FEATURE_COLUMNS:
        if col not in df.columns:
            df[col] = np.nan
    return df


# ---------------------------------------------------------------------------
# Encoding helpers
# ---------------------------------------------------------------------------

def encode_binary(df: pd.DataFrame, columns: list[str]) -> pd.DataFrame:
    """Binary-encode clinical history columns (present=1, absent=0).

    Handles ``'yes'``/``'no'`` strings (case-insensitive) and numeric
    1/0 values.  Unknown values are mapped to 0.

    Parameters
    ----------
    df : pd.DataFrame
    columns : list[str]
        Column names to encode.

    Returns
    -------
    pd.DataFrame
    """
    df = df.copy()
    for col in columns:
        if col not in df.columns:
            continue
        df[col] = (
            df[col]
            .astype(str)
            .str.strip()
            .str.lower()
            .map({"yes": 1, "1": 1, "1.0": 1, "no": 0, "0": 0, "0.0": 0})
            .fillna(0)
            .astype(int)
        )
    return df


_MENTAL_HEALTH_ORDER = ["none", "mild", "moderate", "severe"]


def encode_ordinal(df: pd.DataFrame, column: str = "MentalHealthStatus") -> pd.DataFrame:
    """Ordinal-encode *column* using the order none < mild < moderate < severe.

    Parameters
    ----------
    df : pd.DataFrame
    column : str

    Returns
    -------
    pd.DataFrame
    """
    if column not in df.columns:
        return df
    df = df.copy()
    mapping = {v: i for i, v in enumerate(_MENTAL_HEALTH_ORDER)}
    df[column] = (
        df[column]
        .astype(str)
        .str.strip()
        .str.lower()
        .map(mapping)
        .fillna(-1)
        .astype(int)
    )
    return df


_RISK_LABEL_MAP = {"low": 0, "mid": 1, "high": 2}


def encode_risk_label(df: pd.DataFrame, column: str = "RiskLevel") -> pd.DataFrame:
    """Map RiskLevel strings to integers: low=0, mid=1, high=2.

    Parameters
    ----------
    df : pd.DataFrame
    column : str

    Returns
    -------
    pd.DataFrame
    """
    df = df.copy()
    df[column] = (
        df[column]
        .astype(str)
        .str.strip()
        .str.lower()
        .map(_RISK_LABEL_MAP)
    )
    return df


# ---------------------------------------------------------------------------
# Train / test split
# ---------------------------------------------------------------------------

def train_test_split_data(
    df: pd.DataFrame,
    test_size: float = 0.30,
    random_state: int = 42,
    target_column: str = "RiskLevel",
) -> tuple[pd.DataFrame, pd.DataFrame, pd.Series, pd.Series]:
    """Stratified 70/30 train-test split.

    Parameters
    ----------
    df : pd.DataFrame
    test_size : float
    random_state : int
    target_column : str

    Returns
    -------
    tuple[pd.DataFrame, pd.DataFrame, pd.Series, pd.Series]
        X_train, X_test, y_train, y_test
    """
    X = df.drop(columns=[target_column])
    y = df[target_column]
    return train_test_split(
        X, y,
        test_size=test_size,
        random_state=random_state,
        stratify=y,
    )
