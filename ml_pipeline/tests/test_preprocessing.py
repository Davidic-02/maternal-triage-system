"""
Tests for ml_pipeline/src/preprocessing.py

Covers the MentalHealthStatus encoding bug fix:
  - encode_ordinal must map none/mild/moderate/severe to 0/1/2/3
  - Unknown or missing values must default to 0 (not -1)
"""

import numpy as np
import pandas as pd
import pytest
import sys
import os

# Allow importing from the src package when running from ml_pipeline/
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from src.preprocessing import encode_ordinal, encode_binary, harmonize_features


class TestEncodeOrdinal:
    """encode_ordinal should map MentalHealthStatus → 0/1/2/3."""

    def _make_df(self, values):
        return pd.DataFrame({"MentalHealthStatus": values})

    def test_known_values_lowercase(self):
        df = self._make_df(["none", "mild", "moderate", "severe"])
        result = encode_ordinal(df)
        assert list(result["MentalHealthStatus"]) == [0, 1, 2, 3]

    def test_known_values_mixed_case(self):
        df = self._make_df(["None", "Mild", "MODERATE", "Severe"])
        result = encode_ordinal(df)
        assert list(result["MentalHealthStatus"]) == [0, 1, 2, 3]

    def test_known_values_with_whitespace(self):
        df = self._make_df(["  none  ", " mild", "moderate ", "severe"])
        result = encode_ordinal(df)
        assert list(result["MentalHealthStatus"]) == [0, 1, 2, 3]

    def test_unknown_value_defaults_to_zero_not_negative_one(self):
        """The critical regression: unmappable values must become 0, never -1."""
        df = self._make_df(["unknown", "n/a", "", "nan"])
        result = encode_ordinal(df)
        for val in result["MentalHealthStatus"]:
            assert val >= 0, (
                f"encode_ordinal produced negative value {val}; "
                "missing MentalHealthStatus must default to 0 (none), not -1."
            )

    def test_missing_nan_defaults_to_zero_not_negative_one(self):
        """NaN rows (from datasets that lack MentalHealthStatus) must become 0."""
        df = pd.DataFrame({"MentalHealthStatus": [np.nan, "mild", np.nan]})
        result = encode_ordinal(df)
        assert result["MentalHealthStatus"].iloc[0] == 0
        assert result["MentalHealthStatus"].iloc[1] == 1
        assert result["MentalHealthStatus"].iloc[2] == 0

    def test_no_negative_values_in_output(self):
        """Output must contain only values in {0, 1, 2, 3}."""
        df = self._make_df(["none", "mild", "moderate", "severe", np.nan, "bad"])
        result = encode_ordinal(df)
        for val in result["MentalHealthStatus"]:
            assert val in {0, 1, 2, 3}, f"Unexpected value {val}"

    def test_column_absent_returns_dataframe_unchanged(self):
        """If MentalHealthStatus is not present, the DataFrame is returned as-is."""
        df = pd.DataFrame({"Age": [25, 30]})
        result = encode_ordinal(df)
        assert "MentalHealthStatus" not in result.columns

    def test_original_dataframe_not_mutated(self):
        df = self._make_df(["none", "severe"])
        original = df.copy()
        encode_ordinal(df)
        pd.testing.assert_frame_equal(df, original)


class TestNormalizeFeaturesSanity:
    """Sanity-check that scaler params are valid after preprocessing."""

    def test_mental_health_range_is_zero_to_three(self):
        """MentalHealthStatus column should have min=0 and max=3 in clean data."""
        df = pd.DataFrame({
            "MentalHealthStatus": ["none", "mild", "moderate", "severe"] * 5
        })
        result = encode_ordinal(df)
        col = result["MentalHealthStatus"]
        assert col.min() == 0
        assert col.max() == 3

    def test_min_not_equal_max_after_encoding(self):
        """After encoding a dataset with varied MentalHealthStatus, min != max."""
        df = pd.DataFrame({
            "MentalHealthStatus": ["none", "mild", "moderate", "severe"]
        })
        result = encode_ordinal(df)
        col = result["MentalHealthStatus"]
        assert col.min() != col.max(), (
            "Encoded MentalHealthStatus has min == max; this would corrupt the "
            "scaler (division by zero) when building scaler_params.json."
        )
