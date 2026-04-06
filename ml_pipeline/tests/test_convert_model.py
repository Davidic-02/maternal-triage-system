"""
Tests for ml_pipeline/src/convert_model.py

Covers the pickle-corruption fix:
- File size validation rejects suspiciously small files.
- Retry logic retries on loading errors and ultimately
  re-raises when all attempts are exhausted.
- Successful load on a later attempt does not raise.
"""

from __future__ import annotations

import os
import pickle
import sys
import tempfile
from unittest.mock import patch, MagicMock

import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from src.convert_model import convert_to_onnx


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _make_large_file(tmp_path) -> str:
    """Write a file large enough to pass the 1 MB size check."""
    path = str(tmp_path / "model.pkl")
    with open(path, "wb") as f:
        f.write(b"\x00" * 2_000_000)
    return path


def _mock_skl2onnx_modules():
    """Return a dict suitable for patch.dict(sys.modules) that stubs skl2onnx."""
    mock_onnx_model = MagicMock()
    mock_onnx_model.SerializeToString.return_value = b"fake_onnx_bytes"

    mock_skl2onnx = MagicMock()
    mock_skl2onnx.convert_sklearn.return_value = mock_onnx_model

    mock_data_types = MagicMock()

    return {
        "skl2onnx": mock_skl2onnx,
        "skl2onnx.common": MagicMock(),
        "skl2onnx.common.data_types": mock_data_types,
    }


# ---------------------------------------------------------------------------
# File-size validation tests
# ---------------------------------------------------------------------------

class TestFileSizeValidation:
    """convert_to_onnx must reject files that are too small."""

    def test_raises_for_empty_file(self, tmp_path):
        path = str(tmp_path / "model.pkl")
        with open(path, "wb"):
            pass  # empty file

        with pytest.raises(ValueError, match="suspiciously small"):
            convert_to_onnx(model_path=path, output_path=str(tmp_path / "out.onnx"))

    def test_raises_for_file_under_threshold(self, tmp_path):
        path = str(tmp_path / "model.pkl")
        with open(path, "wb") as f:
            f.write(b"\x00" * 500_000)  # 500 KB — below the 1 MB threshold

        with pytest.raises(ValueError, match="suspiciously small"):
            convert_to_onnx(model_path=path, output_path=str(tmp_path / "out.onnx"))

    def test_error_message_includes_byte_count(self, tmp_path):
        path = str(tmp_path / "model.pkl")
        with open(path, "wb") as f:
            f.write(b"\x00" * 100)

        with pytest.raises(ValueError, match="100 bytes"):
            convert_to_onnx(model_path=path, output_path=str(tmp_path / "out.onnx"))


# ---------------------------------------------------------------------------
# Retry logic tests
# ---------------------------------------------------------------------------

class TestRetryLogic:
    """convert_to_onnx must retry on loading errors."""

    def test_reraises_after_all_retries_exhausted_unpickling_error(self, tmp_path):
        """If every attempt raises UnpicklingError (joblib internal pickle error), the exception propagates."""
        path = _make_large_file(tmp_path)

        with patch("joblib.load", side_effect=pickle.UnpicklingError("bad data")):
            with patch("time.sleep"):  # don't actually wait
                with pytest.raises(pickle.UnpicklingError):
                    convert_to_onnx(
                        model_path=path,
                        output_path=str(tmp_path / "out.onnx"),
                        retries=3,
                    )

    def test_reraises_after_all_retries_exhausted_eof_error(self, tmp_path):
        """If every attempt raises EOFError, the exception propagates."""
        path = _make_large_file(tmp_path)

        with patch("joblib.load", side_effect=EOFError("unexpected end")):
            with patch("time.sleep"):
                with pytest.raises(EOFError):
                    convert_to_onnx(
                        model_path=path,
                        output_path=str(tmp_path / "out.onnx"),
                        retries=3,
                    )

    def test_sleep_called_between_retries(self, tmp_path):
        """time.sleep(2) must be called between failed attempts."""
        path = _make_large_file(tmp_path)

        with patch("joblib.load", side_effect=pickle.UnpicklingError("bad")):
            with patch("time.sleep") as mock_sleep:
                with pytest.raises(pickle.UnpicklingError):
                    convert_to_onnx(
                        model_path=path,
                        output_path=str(tmp_path / "out.onnx"),
                        retries=3,
                    )
                # 3 retries → sleep called 2 times (not before the final attempt)
                assert mock_sleep.call_count == 2
                mock_sleep.assert_called_with(2)

    def test_no_sleep_on_single_retry(self, tmp_path):
        """With retries=1 (no retry), sleep must never be called."""
        path = _make_large_file(tmp_path)

        with patch("joblib.load", side_effect=pickle.UnpicklingError("bad")):
            with patch("time.sleep") as mock_sleep:
                with pytest.raises(pickle.UnpicklingError):
                    convert_to_onnx(
                        model_path=path,
                        output_path=str(tmp_path / "out.onnx"),
                        retries=1,
                    )
                mock_sleep.assert_not_called()

    def test_succeeds_on_second_attempt(self, tmp_path):
        """If the first attempt fails but the second succeeds, no error is raised
        and the successful model is used for ONNX conversion."""
        import numpy as np
        from sklearn.linear_model import LogisticRegression

        real_model = LogisticRegression()
        real_model.fit(np.array([[0], [1]]), np.array([0, 1]))

        path = _make_large_file(tmp_path)
        output_path = str(tmp_path / "out.onnx")

        # First call raises UnpicklingError; second call returns the real model.
        side_effects = [pickle.UnpicklingError("first attempt bad"), real_model]

        with patch("joblib.load", side_effect=side_effects):
            with patch("time.sleep"):
                with patch("src.convert_model._register_xgboost_converter"):
                    with patch.dict("sys.modules", _mock_skl2onnx_modules()):
                        # Should not raise; second attempt succeeds
                        convert_to_onnx(
                            model_path=path,
                            output_path=output_path,
                            retries=2,
                        )
        # ONNX output file must have been written
        assert os.path.exists(output_path)
