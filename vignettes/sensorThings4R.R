## ------------------------------------------------------------------------
library(kableExtra)
library(sensorThings4R)

## ------------------------------------------------------------------------
# Load SensorThings locations
loc = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
class(loc)


# Load SensorThings FoIs
foi = senseFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
class(foi)

## ------------------------------------------------------------------------
s1 = senseThings("https://toronto-bike-snapshot.sensorup.com/v1.0")

class(s1)

## ------------------------------------------------------------------------
n = senseLocations("http://example.sensorup.com/v1.0")
u = makeThingLocation(n)

knitr::kable(u) %>%
  kable_styling(bootstrap_options = "striped", font_size = 10) %>%
  scroll_box(width = "100%", height = "200px")

class(u)

## ---- eval=FALSE---------------------------------------------------------
#  shinyThings()

## ---- echo=FALSE, results='asis'-----------------------------------------
knitr::kable(head(mtcars, 10))

