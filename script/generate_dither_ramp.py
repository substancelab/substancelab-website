import numpy as np
from PIL import Image

# Ramp tile: a fixed-height band (8 big pixels = 64px) that fades from
# transparent to solid black, anchored to the top of the caption box (via
# `bottom: 100%` in CSS) so it always sits immediately above the caption
# (see .ui-gallery-item-caption in frontend/styles/index.scss).
#
# Random dithering: each cell gets an independent uniform-random threshold,
# so the on/off pattern is genuinely random rather than a repeating ordered
# matrix. Each "on" pixel's own alpha also fades with the gradient (rather
# than a flat alpha), so both the dot density AND each dot's opacity ease
# out toward the transparent end.
#
# Re-run this script to get a different random pattern -- it picks a fresh
# seed from OS entropy each time.

BLOCK = 8   # size of each "big pixel", in px
COLS = 36   # tile width in big-pixels (tiles horizontally via background-repeat-x)
ROWS = 8    # 8 big pixels tall = 64px

MAX_ALPHA = 128  # 50% opacity black
MAX_DENSITY = 0.8  # cap the on/off density below 1.0 so even the bottom row keeps some gaps
MIN_BOTTOM_OFF = 6  # require at least this many off (transparent) pixels in the bottom row

# The smooth gradient: 0 (transparent) at the top row, 1 (solid) at the
# bottom row. Each on-pixel's alpha fades with this directly.
row_idx = np.arange(ROWS)
gradient_row = (row_idx + 1) / ROWS  # 0.125, 0.25, ..., 1.0
gradient = np.tile(gradient_row[:, None], (1, COLS)).astype(np.float64)

# Density (on/off fraction) fades the same way, but capped below 1.0 -- so
# the bottom row is still mostly-on but never fully solid; it keeps a few
# off (fully transparent) pixels for texture, same as every other row.
density = gradient * MAX_DENSITY

seed = np.random.SeedSequence().entropy % (2**32)
while True:
    rng = np.random.default_rng(seed)
    thresh = rng.uniform(0.0, 1.0, size=(ROWS, COLS))
    on = thresh < density
    off_in_bottom_row = (~on[-1, :]).sum()
    if off_in_bottom_row >= MIN_BOTTOM_OFF:
        break
    seed += 1

# Use opacity as color too: each "on" pixel's alpha scales with the row's
# gradient value, instead of a flat alpha for every "on" pixel -- so the
# dots themselves fade out, on top of the dither pattern getting sparser.
alpha = np.where(on, gradient * MAX_ALPHA, 0).astype(np.uint8)

rgba = np.zeros((ROWS, COLS, 4), dtype=np.uint8)
rgba[..., 3] = alpha
img = Image.fromarray(rgba, mode="RGBA")
img = img.resize((COLS * BLOCK, ROWS * BLOCK), resample=Image.NEAREST)
img.save("src/images/dither-ramp.png")
print("saved src/images/dither-ramp.png", img.size, "(seed", seed, ")")
print("on-fraction per row:", on.mean(axis=1))
print("alpha of on-pixels per row:", (gradient[:, 0] * MAX_ALPHA).astype(np.uint8))
