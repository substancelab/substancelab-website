"""Shared generator for the caption fade-in dither pattern.

Used by generate_dither_ramp.py (single static tile) and
generate_dither_ramp_frames.py (animated hover sprite sheet).
"""

import numpy as np
from PIL import Image

BLOCK = 8   # size of each "big pixel", in px
COLS = 36   # tile width in big-pixels (tiles horizontally via background-repeat-x)
ROWS = 8    # 8 big pixels tall = 64px

MAX_ALPHA = 128  # 50% opacity black
JITTER = 0.35  # how much random noise to mix into the checkerboard threshold
MIN_BOTTOM_OFF = 6  # exact number of off (transparent) pixels in the bottom row

# The smooth gradient: 0 (transparent) at the top row, 1 (solid) at the
# bottom row. Each on-pixel's alpha fades with this directly.
_row_idx = np.arange(ROWS)
_col_idx = np.arange(COLS)
GRADIENT_ROW = (_row_idx + 1) / ROWS  # 0.125, 0.25, ..., 1.0
GRADIENT = np.tile(GRADIENT_ROW[:, None], (1, COLS)).astype(np.float64)

# Checkerboard used as an ordered-dither threshold map -- (row + col) % 2
# gives each cell a "low" or "high" threshold, like a 2-level Bayer matrix.
CHECKER_THRESHOLD = np.where((_row_idx[:, None] + _col_idx[None, :]) % 2 == 0, 0.25, 0.75)


def random_seed():
    return int(np.random.SeedSequence().entropy % (2**32))


def generate_alpha(seed):
    """Checkerboard ordered dithering with random jitter and an opacity
    fade. The checkerboard gives each cell a "low" or "high" threshold, and
    per-cell random jitter breaks up the strict alternation into something
    more organic, rather than a perfectly uniform grid.

    The top and bottom rows sit right against a hard boundary (the clean
    photo above, the flat caption background below), so their on-pixel
    *count* is fixed rather than left to chance -- when animating between
    several independently-random frames, a row that happens to be much
    denser or sparser than usual reads as a line flashing in/out right at
    that boundary. Pinning the count (while still randomizing *which*
    columns are on) keeps that boundary visually steady across every frame,
    while the interior rows stay fully random for the flicker effect."""
    rng = np.random.default_rng(seed)
    jitter = rng.uniform(-JITTER, JITTER, size=(ROWS, COLS))
    threshold = np.clip(CHECKER_THRESHOLD + jitter, 0.0, 1.0)
    on = GRADIENT > threshold

    top_on_count = int((GRADIENT[0, 0] > CHECKER_THRESHOLD[0]).sum())
    on[0, :] = False
    on[0, rng.choice(COLS, size=top_on_count, replace=False)] = True

    on[-1, :] = True
    on[-1, rng.choice(COLS, size=MIN_BOTTOM_OFF, replace=False)] = False

    # Use opacity as color too: each "on" pixel's alpha scales with the
    # row's gradient value, instead of a flat alpha for every "on" pixel --
    # so the dots themselves fade out, on top of the pattern getting sparser.
    alpha = np.where(on, GRADIENT * MAX_ALPHA, 0).astype(np.uint8)
    return alpha, seed


def render(alpha):
    """Upscale an (ROWS, COLS) alpha array to a full-size RGBA image."""
    rows, cols = alpha.shape
    rgba = np.zeros((rows, cols, 4), dtype=np.uint8)
    rgba[..., 3] = alpha
    img = Image.fromarray(rgba, mode="RGBA")
    return img.resize((cols * BLOCK, rows * BLOCK), resample=Image.NEAREST)
