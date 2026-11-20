from dither_ramp import generate_alpha, random_seed, render

# Ramp tile: a fixed-height band (8 big pixels = 64px) that fades from
# transparent to solid black, anchored to the top of the caption box (via
# `bottom: 100%` in CSS) so it always sits immediately above the caption
# (see .ui-gallery-item-caption in frontend/styles/index.scss).
#
# This is the static default shown while a card isn't hovered. See
# generate_dither_ramp_frames.py for the animated hover sprite sheet.
#
# Re-run this script to get a different random pattern -- it picks a fresh
# seed from OS entropy each time.

alpha, seed = generate_alpha(random_seed())
img = render(alpha)
img.save("src/images/dither-ramp.png")
print("saved src/images/dither-ramp.png", img.size, "(seed", seed, ")")
print("on-fraction per row:", (alpha > 0).mean(axis=1))
