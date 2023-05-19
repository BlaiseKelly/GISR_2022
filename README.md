GISR 2022 Reproducible Poster, paper and plots
================

Poster, paper and plot for GISRUK conference

First run “dutchcityzones.R” in the plots folder to downlaod shape files
from CBS and generate 3_regions.png

All packages are on the CRAN except for postr which can be installed
using:

devtools::install_github(“odeleongt/postr”)

Run GISR_poster.Rmd

This outputs a html, unfortunately this doesn’t display well in a
browser in the way I have configured the poster.

Run Render.R to generate the .png from the html. Can adjust the height
and width will calculate based on the ratio of an A1 page which has been
defined.

I had some trouble getting the images to display where I wanted them. In
the concentration window the images sat nicely below the text and seem
to adjust when there was more or less text, however for the other
windows they stubbornly displayed in the middle of the window and text
went behind. I ran out of time to solve this so had to compromise on
some info I wanted to show, but hopefully can find a solution for the
future.

![](poster.png)
