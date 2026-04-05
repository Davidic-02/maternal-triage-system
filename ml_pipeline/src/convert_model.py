"""
convert_model.py
----------------
Convert the trained stacking ensemble to ONNX format for use with
Flutter's ONNX Runtime integration.
"""

from __future__ import annotations

import os


def convert_to_onnx(model_path: str, output_path: str, n_features: int = 13) -> None:
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
    """
    try:
        from skl2onnx import convert_sklearn
        from skl2onnx.common.data_types import FloatTensorType
    except ImportError as exc:
        raise ImportError(
            "skl2onnx is required for ONNX conversion. "
            "Install it with: pip install skl2onnx onnx onnxruntime"
        ) from exc

    import pickle

    with open(model_path, "rb") as f:
        model = pickle.load(f)

    # Define input type: batch of n_features floats
    initial_type = [("float_input", FloatTensorType([None, n_features]))]

    # Convert to ONNX
    onnx_model = convert_sklearn(model, initial_types=initial_type)

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    with open(output_path, "wb") as f:
        f.write(onnx_model.SerializeToString())

    print(f"  Model converted to ONNX → {output_path}")


# ---------------------------------------------------------------------------
# Smoke-test:  python3 -m src.convert_model
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    import os

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
    print("\n-- Done! ---")
