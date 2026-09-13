"""
config.py
---------
Central pipeline configuration.

CLASSIFICATION_MODE controls whether the model is trained as a binary
(low vs high) or three-class (low / mid / high) classifier.

  - "binary"     : MID-risk rows are dropped. Cleaner, stronger headline
                   metrics (low vs high). Consistent with the FUTH and
                   Mendeley datasets which use binary labels.
  - "multiclass" : all three risk tiers retained (low / mid / high).
                   Kept for the secondary three-class experiment.

Override at runtime without editing this file:

    CLASSIFICATION_MODE=multiclass python3 -m src.train
"""

import os

# Default to binary — the primary, publishable configuration.
CLASSIFICATION_MODE = os.environ.get("CLASSIFICATION_MODE", "binary").strip().lower()

if CLASSIFICATION_MODE not in ("binary", "multiclass"):
    raise ValueError(
        f"CLASSIFICATION_MODE must be 'binary' or 'multiclass', got {CLASSIFICATION_MODE!r}"
    )

IS_BINARY = CLASSIFICATION_MODE == "binary"

# Each mode writes its reports/plots into its own folder so the binary and
# three-class outputs never overwrite each other.
#   reports/binary/        ← low vs high
#   reports/three_class/   ← low / mid / high
REPORTS_DIR = os.path.join("reports", "binary" if IS_BINARY else "three_class")
