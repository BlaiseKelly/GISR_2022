library(postr)

## ratio set to A1, but should be same for other A sizes.
ratio <- 1188/841

# adjust the height and width wil lcalculate based on ratio
ht <- 1500
wd <- ht/ratio

## generates png the delay is to allow the equations to generate
postr::render("GISR_poster.html", output = "poster.png", aspect_ratio = ht/wd, poster_width = wd, delay = 10)

