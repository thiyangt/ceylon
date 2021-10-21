library(hexSticker)
library(here)
sticker(here("data-raw", "ceylon.png"), package="ceylon",
        p_color="#99000d",
        p_size=7, s_x=1, s_y=0.7, s_width=.3,
        h_fill = "#ebeef0",
        h_color="#2ba6e3",
        filename="man/figures/hex.png")