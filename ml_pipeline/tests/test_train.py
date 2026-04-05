"""
Tests for ml_pipeline/src/train.py  — normalize_features validation.
"""

import json
import os
import sys
import tempfile

import numpy as np
import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from src.train import normalize_features


class TestNormalizeFeatures:
    """normalize_features should raise when any feature has min == max."""

    def _create_feature_matrix(self, n_features: int = 14, n_samples: int = 20):
        rng = np.random.default_rng(42)
        X = rng.uniform(0.0, 1.0, (n_samples, n_features))
        return X

    def test_normal_data_saves_valid_params(self, tmp_path):
        X = self._create_feature_matrix()
        X_train, X_test = X[:15], X[15:]
        params_path = str(tmp_path / "scaler_params.json")

        X_tr_norm, X_te_norm = normalize_features(X_train, X_test, params_path)

        with open(params_path) as f:
            params = json.load(f)

        assert "min" in params and "max" in params
        assert len(params["min"]) == 14
        assert len(params["max"]) == 14

        # All values should be within [0, 1] after normalisation
        assert X_tr_norm.min() >= -1e-9
        assert X_tr_norm.max() <= 1.0 + 1e-9

    def test_raises_when_feature_is_constant(self, tmp_path):
        """normalize_features must raise ValueError when min == max for any feature.

        This replicates the root cause: MentalHealthStatus was all -1 in training
        data because encode_ordinal used fillna(-1) for missing values.
        """
        X = self._create_feature_matrix(n_features=14, n_samples=20)
        # Force feature 12 (MentalHealthStatus) to be constant (all -1)
        X[:, 12] = -1.0
        X_train, X_test = X[:15], X[15:]
        params_path = str(tmp_path / "scaler_params.json")

        with pytest.raises(ValueError, match="min == max"):
            normalize_features(X_train, X_test, params_path)

    def test_raises_includes_degenerate_feature_indices(self, tmp_path):
        """Error message must identify which feature indices are degenerate."""
        X = self._create_feature_matrix(n_features=14, n_samples=20)
        X[:, 12] = 0.0   # MentalHealthStatus constant
        X_train, X_test = X[:15], X[15:]
        params_path = str(tmp_path / "scaler_params.json")

        with pytest.raises(ValueError, match="12"):
            normalize_features(X_train, X_test, params_path)

    def test_no_params_file_written_on_error(self, tmp_path):
        """If validation fails, scaler_params.json must not be written."""
        X = self._create_feature_matrix(n_features=14, n_samples=20)
        X[:, 12] = -1.0
        X_train, X_test = X[:15], X[15:]
        params_path = str(tmp_path / "scaler_params.json")

        try:
            normalize_features(X_train, X_test, params_path)
        except ValueError:
            pass

        assert not os.path.exists(params_path), (
            "scaler_params.json must not be created when validation fails"
        )
