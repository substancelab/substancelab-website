import numpy as np
from PIL import Image

from dither_ramp import BLOCK, COLS, ROWS, generate_alpha, random_seed

# Animated hover sprite sheet: FRAME_COUNT independent dither patterns
# (generated the same way as generate_dither_ramp.py) stacked vertically
# into one tall image. In CSS, `.ui-gallery-item:hover` swaps in this image
# for the caption's fade band and steps `background-position-y` down
# through the stack on a loop, so the pixels flicker between patterns while
# hovered.
#
# Re-run this script to get a fresh set of frames.

FRAME_COUNT = 6

frames = []
seed = random_seed()
for _ in range(FRAME_COUNT):
    alpha, seed = generate_alpha(seed)
    frames.append(alpha)
    seed += 1  # advance past the seed just used, so frames don't repeat

stacked_alpha = np.concatenate(frames, axis=0)  # (FRAME_COUNT * ROWS, COLS)

rgba = np.zeros((*stacked_alpha.shape, 4), dtype=np.uint8)
rgba[..., 3] = stacked_alpha
img = Image.fromarray(rgba, mode="RGBA")
img = img.resize((COLS * BLOCK, FRAME_COUNT * ROWS * BLOCK), resample=Image.NEAREST)
img.save("src/images/dither-ramp-frames.png")
print("saved src/images/dither-ramp-frames.png", img.size, f"({FRAME_COUNT} frames)")
