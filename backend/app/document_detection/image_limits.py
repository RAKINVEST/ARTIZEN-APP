"""Bounds how large an embedded image the visual detectors will decode.

A PDF can embed an image whose *compressed* size is trivial and whose
decoded size is not: a 1.85 MB file carrying an 11000x11000 image expands
to ~350 MB of RSS, and both LogoDetector and ColorDetector decode it — so
the real cost is double that, on the event loop, per request. A handful of
concurrent detections is enough to get the container OOM-killed, at no
cost to the caller.

Pillow has a guard for exactly this, but its default is only half a guard:
above ``MAX_IMAGE_PIXELS`` it emits a ``DecompressionBombWarning`` — a
*warning*, which does not stop the decode — and only raises above twice
that. Since a warning sails straight through the detectors' ``except
Exception``, the bomb was fully decoded before anyone noticed.

Importing this module turns that warning into the exception it should have
been, so a bomb degrades to "not detected" through the error handling both
detectors already have.

The limit is a real-document bound, not a security guess: an A4 page
scanned at 600 dpi is ~35 Mpx, so 40 Mpx accepts any plausible logo or
scan while rejecting anything built to be expensive.
"""

import warnings

from PIL import Image

MAX_IMAGE_PIXELS = 40_000_000

Image.MAX_IMAGE_PIXELS = MAX_IMAGE_PIXELS
warnings.simplefilter("error", Image.DecompressionBombWarning)
