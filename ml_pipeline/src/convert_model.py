"""
convert_model.py
----------------
Convert the trained stacking ensemble to TensorFlow Lite format.
"""

from __future__ import annotations

import os

import numpy as np


def convert_to_tflite(model, output_path: str, n_features: int = 13) -> None:
    """Wrap the stacking pipeline in a TF computation graph and export TFLite.

    The stacking model's ``predict_proba`` is traced as a TensorFlow
    ``tf.function`` so that the resulting SavedModel can be converted
    with optional dynamic-range quantisation.

    Parameters
    ----------
    model : fitted StackingClassifier (or any sklearn estimator with
        ``predict_proba``)
    output_path : str
        Destination path for the ``.tflite`` file
        (e.g. ``'models/maternal_triage_model.tflite'``).
    n_features : int
        Number of input features expected by the model (default 13 to
        match the feature union used in this project).
    """
    try:
        import tensorflow as tf
    except ImportError as exc:
        raise ImportError(
            "TensorFlow is required for TFLite conversion. "
            "Install it with: pip install tensorflow"
        ) from exc

    # ------------------------------------------------------------------
    # Wrap sklearn model as a TF module
    # ------------------------------------------------------------------
    class _SklearnWrapper(tf.Module):
        def __init__(self, sklearn_model):
            super().__init__()
            self._model = sklearn_model

        @tf.function(
            input_signature=[
                tf.TensorSpec(shape=[None, n_features], dtype=tf.float32)
            ]
        )
        def predict(self, x: tf.Tensor) -> tf.Tensor:
            probas = tf.py_function(
                func=lambda inp: self._model.predict_proba(inp.numpy()).astype(
                    np.float32
                ),
                inp=[x],
                Tout=tf.float32,
            )
            probas.set_shape([None, 3])
            return probas

    wrapper = _SklearnWrapper(model)

    # ------------------------------------------------------------------
    # Convert to TFLite with dynamic-range quantisation
    # ------------------------------------------------------------------
    converter = tf.lite.TFLiteConverter.from_concrete_functions(
        [wrapper.predict.get_concrete_function()],
        wrapper,
    )
    converter.optimizations = [tf.lite.Optimize.DEFAULT]
    tflite_model = converter.convert()

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    with open(output_path, "wb") as fh:
        fh.write(tflite_model)
    print(f"TFLite model saved to {output_path} ({len(tflite_model) / 1024:.1f} KB)")


# ---------------------------------------------------------------------------
# Smoke-test:  python3 -m src.convert_model
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    import joblib
    from src.feature_engineering import run_feature_engineering
    from src.balancing import apply_smote
    from src.train import normalize_features

    print("-- Loading pipeline data ---")
    X_train, X_test, y_train, y_test = run_feature_engineering()
    X_res, y_res = apply_smote(X_train, y_train)
    X_train_norm, X_test_norm = normalize_features(X_res, X_test)

    print("-- Loading trained model ---")
    model = joblib.load("models/stacking_model.pkl")
    print("  Model loaded from models/stacking_model.pkl")

    print("\n-- Converting to TFLite ---")
    convert_to_tflite(
        model,
        output_path="models/maternal_triage_model.tflite",
        n_features=X_test_norm.shape[1],
    )

    print("\n-- Done! ---")
