"""
convert_model.py
----------------
Convert the trained stacking ensemble to ONNX format for use with
Flutter's ONNX Runtime integration.

Improvements over the original:
- Registers the XGBoost → ONNX converter (via onnxmltools) before calling
  skl2onnx, which prevents the conversion from hanging when a
  StackingClassifier contains an XGBClassifier estimator.
- Uses target_opset=12 for a simpler, faster ONNX graph.
- Sets zipmap=False to avoid a slow ZipMap output node that is unnecessary
  for Flutter inference.
- Copies the finished ONNX file to the Flutter assets directory automatically
  so no manual copy step is required.
"""

from __future__ import annotations

import os
import pickle
import shutil
import time

import joblib


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _register_xgboost_converter() -> None:
    """Register the XGBoost → ONNX converter with skl2onnx.

    Without this registration skl2onnx does not know how to convert
    XGBClassifier nodes that appear inside a StackingClassifier, causing the
    conversion to hang or raise an error.  The onnxmltools package provides
    the required converter; if it is not installed the registration is silently
    skipped (conversion may still succeed for non-XGBoost models).
    """
    try:
        from onnxmltools.convert.xgboost.operator_converters.XGBoost import (
            convert_xgboost,
        )
        from skl2onnx import update_registered_converter
        from skl2onnx.common.shape_calculator import (
            calculate_linear_classifier_output_shapes,
        )
        from xgboost import XGBClassifier

        update_registered_converter(
            XGBClassifier,
            "XGBoostXGBClassifier",
            calculate_linear_classifier_output_shapes,
            convert_xgboost,
            options={"nocl": [True, False], "zipmap": [True, False]},
        )
        print("  XGBoost converter registered via onnxmltools.")
    except ImportError:
        pass  # onnxmltools not installed; proceed without XGBoost registration


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

def convert_to_onnx(
    model_path: str,
    output_path: str,
    n_features: int = 13,
    retries: int = 3,
) -> None:
    """Convert a fitted sklearn stacking model to ONNX format.

    Parameters
    ----------
    model_path : str
        Path to the serialised sklearn model (``.pkl`` file).
    output_path : str
        Destination path for the ``.onnx`` file
        (e.g. ``'models/stacking_model.onnx'``).
    n_features : int
        Number of input features expected by the model (default 13 to
        match the feature union used in this project).
    retries : int
        Number of attempts to load the model file before giving up.
        Each failed attempt waits 2 seconds before retrying, which
        handles the race condition where the file is still being written
        (or its OS buffers have not yet been flushed) when this function
        is called.
    """
    # -----------------------------------------------------------------------
    # File validation — guard against truncated / still-being-written files.
    # This check runs before any expensive imports so failures are immediate.
    # -----------------------------------------------------------------------
    _MIN_VALID_BYTES = 1_000_000  # 1 MB; a real stacking ensemble is much larger
    file_size = os.path.getsize(model_path)
    if file_size < _MIN_VALID_BYTES:
        raise ValueError(
            f"Model file is suspiciously small ({file_size} bytes). "
            "It may be incomplete — re-run 'python -m src.train' first."
        )

    # -----------------------------------------------------------------------
    # Load with retry to tolerate any residual OS-buffer timing issues.
    # -----------------------------------------------------------------------
    print("  Loading model from pickle …")
    model = None
    for attempt in range(retries):
        try:
            model = joblib.load(model_path)
            break  # success — exit retry loop
        except (EOFError, pickle.UnpicklingError, ValueError) as exc:
            if attempt < retries - 1:
                print(
                    f"  Attempt {attempt + 1} failed ({exc}), "
                    "waiting 2 seconds before retrying …"
                )
                time.sleep(2)
            else:
                raise

    # -----------------------------------------------------------------------
    # ONNX conversion — imported here so the heavy dependency is only loaded
    # when the file and model are confirmed to be good.
    # -----------------------------------------------------------------------
    try:
        from skl2onnx import convert_sklearn
        from skl2onnx.common.data_types import FloatTensorType
    except ImportError as exc:
        raise ImportError(
            "skl2onnx is required for ONNX conversion. "
            "Install it with: pip install skl2onnx onnx onnxruntime"
        ) from exc

    # Register XGBoost converter so StackingClassifier + XGBClassifier works.
    _register_xgboost_converter()

    # Define input type: batch of n_features floats.
    initial_type = [("float_input", FloatTensorType([None, n_features]))]

    # target_opset=12 produces a simpler graph that converts faster.
    # zipmap=False removes the slow ZipMap output node; Flutter reads the raw
    # probability array directly.
    options = {type(model): {"zipmap": False}}

    print("  Running skl2onnx conversion (target_opset=12, zipmap=False) …")
    onnx_model = convert_sklearn(
        model,
        initial_types=initial_type,
   target_opset={"": 12, "ai.onnx.ml": 3},
        options=options,
    )

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    with open(output_path, "wb") as f:
        f.write(onnx_model.SerializeToString())

    print(f"  Model converted to ONNX → {output_path}")


def copy_to_flutter_assets(
    onnx_path: str,
    flutter_models_dir: str | None = None,
    dest_filename: str = "maternal_triage_model.onnx",
) -> None:
    """Copy the ONNX model into the Flutter assets/models directory.

    Parameters
    ----------
    onnx_path : str
        Path to the source ``.onnx`` file.
    flutter_models_dir : str | None
        Absolute path to the Flutter ``assets/models`` directory.
        Defaults to ``<repo_root>/flutter_app/assets/models``, resolved
        relative to this source file's location.
    dest_filename : str
        Name to give the file inside the Flutter assets directory.
        Defaults to ``maternal_triage_model.onnx`` (the name referenced in
        ``flutter_app/lib/utils/constants.dart``).
    """
    if flutter_models_dir is None:
        # This file lives at ml_pipeline/src/convert_model.py; the Flutter
        # assets directory is two levels up, then into flutter_app.
        src_dir = os.path.dirname(os.path.abspath(__file__))
        flutter_models_dir = os.path.normpath(
            os.path.join(src_dir, "..", "..", "flutter_app", "assets", "models")
        )

    dst = os.path.join(flutter_models_dir, dest_filename)
    os.makedirs(flutter_models_dir, exist_ok=True)
    shutil.copy2(onnx_path, dst)

    src_size = os.path.getsize(onnx_path)
    dst_size = os.path.getsize(dst)
    if src_size != dst_size:
        raise RuntimeError(
            f"Copy verification failed: source size {src_size} B != "
            f"destination size {dst_size} B"
        )

    print(f"  ONNX model copied to Flutter assets → {dst} ({dst_size / 1024:.1f} KB)")


# ---------------------------------------------------------------------------
# Entry-point:  python -m src.convert_model
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    model_pkl = "models/stacking_model.pkl"
    output_onnx = "models/stacking_model.onnx"

    if not os.path.exists(model_pkl):
        raise FileNotFoundError(
            f"Trained model not found at '{model_pkl}'. "
            "Run 'python -m src.train' first to generate the model."
        )

    print("-- Converting stacking model to ONNX ---")
    convert_to_onnx(model_path=model_pkl, output_path=output_onnx, n_features=13)

    if not os.path.exists(output_onnx):
        raise RuntimeError(f"ONNX file was not created at '{output_onnx}'.")

    size_kb = os.path.getsize(output_onnx) / 1024
    print(f"  ONNX model verified at {output_onnx} ({size_kb:.1f} KB)")

    print("\n-- Copying ONNX model to Flutter assets ---")
    copy_to_flutter_assets(output_onnx)

    print("\n-- Done! ---")
    print("  Next steps:")
    print("    cd ../flutter_app && flutter clean && flutter pub get && flutter run")
