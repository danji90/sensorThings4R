## ------------------------------------------------------------------------
# Load SensorThings locations
library(sensorThings4R)
x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
head(x, n=1L)

# Load SensorThings FoIs
x = senseFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
head(x,n=1L)

## ---- eval=FALSE---------------------------------------------------------
#  shinyThings()

## ---- echo=FALSE, results='asis'-----------------------------------------
knitr::kable(head(mtcars, 10))

