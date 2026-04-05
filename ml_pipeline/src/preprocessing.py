"""
preprocessing.py
----------------
Data cleaning, imputation, harmonization, and encoding utilities.
"""

import os
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split


# ---------------------------------------------------------------------------
# Risk label normalisation
# ---------------------------------------------------------------------------

# Maps every raw variant found across the 3 datasets → canonical form
_RAW_TO_CANONICAL = {
    # FUTH variants
    "high":      "high",
    "low":       "low",
    # Mendeley variants
    "high risk": "high",
    "low risk":  "low",
    "mid risk":  "mid",
    # Kaggle variants  (already lowercase after .str.lower())
    # covered by "high" / "low" above
}

def normalise_risk_labels(df: pd.DataFrame, column: str = "RiskLevel") -> pd.DataFrame:
    """Normalise all RiskLevel variants to 'low', 'mid', or 'high'.

    Handles:
      FUTH    — 'High', 'Low'
      Mendeley — 'high risk', 'low risk', 'mid risk'
      Kaggle  — 'HIGH', 'LOW'

    Rows whose label cannot be mapped are dropped.

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
        .map(_RAW_TO_CANONICAL)
    )
    before = len(df)
    df = df.dropna(subset=[column]).reset_index(drop=True)
    dropped = before - len(df)
    if dropped:
        print(f"  [normalise_risk_labels] Dropped {dropped} rows with unmappable labels.")
    return df


# ---------------------------------------------------------------------------
# Deduplication
# ---------------------------------------------------------------------------

def remove_duplicates(df: pd.DataFrame) -> pd.DataFrame:
    """Remove exact duplicate rows."""
    before = len(df)
    df = df.drop_duplicates().reset_index(drop=True)
    print(f"  [remove_duplicates] Removed {before - len(df)} duplicate rows.")
    return df


# ---------------------------------------------------------------------------
# Imputation
# ---------------------------------------------------------------------------

def impute_missing(
    df: pd.DataFrame,
    strategy: str = "median",
    _medians: dict = None,
) -> tuple:
    """Impute missing values in numeric columns using median strategy.

    Fits on the supplied df (training data) and returns fill values
    so they can be applied unchanged to the test set.

    Parameters
    ----------
    df : pd.DataFrame
    strategy : str   — only 'median' is supported
    _medians : dict  — pre-computed fill values (pass for test set)

    Returns
    -------
    (pd.DataFrame, dict)
    """
    numeric_cols = df.select_dtypes(include=[np.number]).columns.tolist()
    if _medians is None:
        if strategy != "median":
            raise ValueError(f"Unsupported strategy: {strategy!r}")
        _medians = {col: df[col].median() for col in numeric_cols}
    df = df.copy()
    for c in numeric_cols:
        df[c] = df[c].fillna(_medians.get(c, df[c].median()))
    return df, _medians


# ---------------------------------------------------------------------------
# Harmonization
# ---------------------------------------------------------------------------

_ALL_FEATURE_COLUMNS = [
    "Age", "SystolicBP", "DiastolicBP", "BloodSugar", "BodyTemp",
    "BMI", "HeartRate", "Weight", "Height",
    "PreviousComplications", "PreexistingDiabetes", "GestationalDiabetes",
]


def harmonize_features(df: pd.DataFrame) -> pd.DataFrame:
    """Ensure all feature columns exist and return them in canonical order.

    Missing feature columns are filled with NaN.  The returned DataFrame
    places the feature columns in the order defined by ``_ALL_FEATURE_COLUMNS``
    so that downstream numpy arrays align with the Flutter app's
    ``_buildInputTensor`` tensor layout.  Any extra columns (e.g. RiskLevel,
    source) are preserved after the feature columns.
    """
    df = df.copy()
    for col in _ALL_FEATURE_COLUMNS:
        if col not in df.columns:
            df[col] = np.nan
    extra_cols = [c for c in df.columns if c not in _ALL_FEATURE_COLUMNS]
    return df[_ALL_FEATURE_COLUMNS + extra_cols]


# ---------------------------------------------------------------------------
# Encoding helpers
# ---------------------------------------------------------------------------

def encode_binary(df: pd.DataFrame, columns: list) -> pd.DataFrame:
    """Binary-encode clinical history columns (present=1, absent=0).

    Handles 'yes'/'no' strings and numeric 1/0 values.
    Unknown values are mapped to 0.
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
    """Ordinal-encode MentalHealthStatus: none=0, mild=1, moderate=2, severe=3."""
    if column not in df.columns:
        return df
    df = df.copy()

    # Fill NaN with 'none' BEFORE mapping (FUTH and Kaggle don't have this column)
    df[column] = df[column].fillna('none')

    mapping = {v: i for i, v in enumerate(_MENTAL_HEALTH_ORDER)}
    df[column] = (
        df[column]
        .astype(str)
        .str.strip()
        .str.lower()
        .map(mapping)
        .fillna(0)
        .astype(int)
    )
    return df


_RISK_LABEL_MAP = {"low": 0, "mid": 1, "high": 2}

def encode_risk_label(df: pd.DataFrame, column: str = "RiskLevel") -> pd.DataFrame:
    """Map normalised RiskLevel strings → integers: low=0, mid=1, high=2."""
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
) -> tuple:
    """Stratified 70/30 train-test split.

    Returns
    -------
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


# ---------------------------------------------------------------------------
# Full pipeline runner
# ---------------------------------------------------------------------------

def run_preprocessing(base_path: str = "data/raw") -> tuple:
    """End-to-end preprocessing pipeline.

    Loads, cleans, normalises, encodes, imputes and splits all 3 datasets.

    Parameters
    ----------
    base_path : str  — folder containing the 3 raw CSV files

    Returns
    -------
    (X_train, X_test, y_train, y_test, medians)
    """
    from src.data_loader import (
        load_futh_dataset,
        load_mendeley_dataset,
        load_kaggle_dataset,
        combine_datasets,
    )

    print("─��� Loading datasets ──────────────────────────────────")
    df_futh     = load_futh_dataset(os.path.join(base_path, "futh_dataset.csv"))
    df_mendeley = load_mendeley_dataset(os.path.join(base_path, "mendeley_dataset.csv"))
    df_kaggle   = load_kaggle_dataset(os.path.join(base_path, "kaggle_dataset.csv"))
    df = combine_datasets(df_futh, df_mendeley, df_kaggle)
    print(f"  Combined shape: {df.shape}")

    print("── Normalising risk labels ───────────────────────────")
    df = normalise_risk_labels(df)
    print(f"  After normalisation: {df['RiskLevel'].value_counts().to_dict()}")

    print("── Removing duplicates ───────────────────────────────")
    df = remove_duplicates(df)

    print("── Harmonising features ──────────────────────────────")
    df = harmonize_features(df)

    print("── Encoding binary columns ───────────────────────────")
    binary_cols = ["PreviousComplications", "PreexistingDiabetes", "GestationalDiabetes"]
    df = encode_binary(df, binary_cols)

    print("── Encoding risk label ───────────────────────────────")
    df = encode_risk_label(df)
    df = df.dropna(subset=["RiskLevel"]).reset_index(drop=True)

    # Drop non-feature columns before split
    drop_cols = [c for c in ["source"] if c in df.columns]
    df = df.drop(columns=drop_cols)

    print("── Splitting 70/30 ───────────────────────────────────")
    X_train, X_test, y_train, y_test = train_test_split_data(df)
    print(f"  Train: {X_train.shape}  Test: {X_test.shape}")

    print("── Imputing missing values ───────────────────────────")
    X_train, medians = impute_missing(X_train)
    X_test,  _       = impute_missing(X_test, _medians=medians)

    print("── Done ✅ ──────────────────────────────────────────")
    print(f"  X_train: {X_train.shape}  y_train distribution: {y_train.value_counts().to_dict()}")
    print(f"  X_test : {X_test.shape}   y_test  distribution: {y_test.value_counts().to_dict()}")

    return X_train, X_test, y_train, y_test, medians


# ---------------------------------------------------------------------------
# Quick smoke-test:  python3 -m src.preprocessing
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    run_preprocessing()
