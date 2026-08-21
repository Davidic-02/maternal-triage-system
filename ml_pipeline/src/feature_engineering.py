"""
feature_engineering.py
-----------------------
Derived feature computation and feature-selection analysis utilities.
"""

import os

import matplotlib
matplotlib.use("Agg")   # non-interactive backend — safe on Mac
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
    """
    df = df.copy()
    if "BMI" not in df.columns:
        df["BMI"] = np.nan
    if "Weight" in df.columns and "Height" in df.columns:
        mask = df["BMI"].isna() & df["Weight"].notna() & df["Height"].notna()
        filled = df.loc[mask, "Weight"] / (df.loc[mask, "Height"] ** 2)
        df.loc[mask, "BMI"] = filled
        print(f"  [compute_bmi] Filled {mask.sum()} BMI values from Weight/Height.")
    return df


def compute_pulse_pressure(df: pd.DataFrame) -> pd.DataFrame:
    """Compute Pulse Pressure = SystolicBP - DiastolicBP."""
    df = df.copy()
    if "SystolicBP" in df.columns and "DiastolicBP" in df.columns:
        df["PulsePressure"] = df["SystolicBP"] - df["DiastolicBP"]
        print(f"  [compute_pulse_pressure] Added PulsePressure column.")
    return df


def compute_clinical_features(df: pd.DataFrame) -> pd.DataFrame:
    """Compute obstetric clinical interaction features.

    These derived signals help the model distinguish MID-risk patients
    whose raw vitals overlap with both LOW and HIGH:

    - ShockIndex     = HeartRate / SystolicBP  (>0.9 flags moderate risk)
    - MAP            = DiastolicBP + PulsePressure/3  (mean arterial pressure)
    - HypertensionFlag = 1 if SystolicBP>=130 OR DiastolicBP>=85  (borderline HTN)
    - TachycardiaFlag  = 1 if HeartRate>=100  (mild tachycardia)
    - DiabetesRisk     = BloodSugar * (1 + PreexistingDiabetes + GestationalDiabetes)
    - AgeRiskFlag      = 1 if Age<18 OR Age>35  (obstetric high-risk age bands)
    """
    df = df.copy()

    if "HeartRate" in df.columns and "SystolicBP" in df.columns:
        df["ShockIndex"] = df["HeartRate"] / df["SystolicBP"].replace(0, np.nan)

    if "DiastolicBP" in df.columns and "PulsePressure" in df.columns:
        df["MAP"] = df["DiastolicBP"] + df["PulsePressure"] / 3

    if "SystolicBP" in df.columns and "DiastolicBP" in df.columns:
        df["HypertensionFlag"] = (
            (df["SystolicBP"] >= 130) | (df["DiastolicBP"] >= 85)
        ).astype(int)

    if "HeartRate" in df.columns:
        df["TachycardiaFlag"] = (df["HeartRate"] >= 100).astype(int)

    if "BloodSugar" in df.columns:
        diabetes_cols = [c for c in ["PreexistingDiabetes", "GestationalDiabetes"] if c in df.columns]
        diabetes_sum = df[diabetes_cols].fillna(0).sum(axis=1) if diabetes_cols else 0
        df["DiabetesRisk"] = df["BloodSugar"] * (1 + diabetes_sum)

    if "Age" in df.columns:
        df["AgeRiskFlag"] = ((df["Age"] < 18) | (df["Age"] > 35)).astype(int)

    print(f"  [compute_clinical_features] Added 6 clinical interaction features.")
    return df


# ---------------------------------------------------------------------------
# Analysis helpers
# ---------------------------------------------------------------------------

def correlation_analysis(
    df: pd.DataFrame,
    output_dir: str = "reports",
    filename: str = "correlation_heatmap.png",
) -> pd.DataFrame:
    """Compute Pearson correlation matrix and save a heatmap PNG."""
    numeric_df = df.select_dtypes(include=[np.number])
    corr = numeric_df.corr()

    os.makedirs(output_dir, exist_ok=True)
    out_path = os.path.join(output_dir, filename)
    fig, ax = plt.subplots(figsize=(12, 10))
    sns.heatmap(corr, annot=True, fmt=".2f", cmap="coolwarm", ax=ax)
    ax.set_title("Pearson Correlation Matrix")
    fig.tight_layout()
    fig.savefig(out_path)
    plt.close(fig)
    print(f"  [correlation_analysis] Heatmap saved → {out_path}")
    return corr


def mutual_information_scores(
    X: pd.DataFrame,
    y: pd.Series,
    random_state: int = 42,
) -> pd.Series:
    """Compute Mutual Information scores for all features vs. target label."""
    scores = mutual_info_classif(X.fillna(0), y, random_state=random_state)
    return pd.Series(scores, index=X.columns).sort_values(ascending=False)


# ---------------------------------------------------------------------------
# Full feature-engineering pipeline
# ---------------------------------------------------------------------------

def run_feature_engineering(base_path: str = "data/raw") -> tuple:
    """Run the full feature-engineering pipeline and return enriched splits."""
    from src.preprocessing import run_preprocessing

    print("── Running preprocessing ─────────────────────────────")
    X_train, X_test, y_train, y_test, _ = run_preprocessing(base_path)

    print("\n── Computing derived features ────────────────────────")
    train = X_train.copy()
    test  = X_test.copy()

    train = compute_bmi(train)
    train = compute_pulse_pressure(train)
    train = compute_clinical_features(train)

    test = compute_bmi(test)
    test = compute_pulse_pressure(test)
    test = compute_clinical_features(test)

    print(f"\n── Feature list after engineering ({train.shape[1]} features) ──")
    print("  ", train.columns.tolist())

    print("\n── Correlation analysis ──────────────────────────────")
    from src.config import REPORTS_DIR
    correlation_analysis(train, output_dir=REPORTS_DIR)

    print("\n── Mutual Information scores (top features) ──────────")
    mi = mutual_information_scores(train, y_train)
    print(mi.to_string())

    print("\n── Done ✅ ─────────────────────────────────────────")
    return train, test, y_train, y_test


# ---------------------------------------------------------------------------
# Smoke-test:  python3 -m src.feature_engineering
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    run_feature_engineering()