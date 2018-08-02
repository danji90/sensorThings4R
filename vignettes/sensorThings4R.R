## ---- eval=FALSE---------------------------------------------------------
#  devtools::install_github("danji90/sensorThings4R")

## ---- include=FALSE------------------------------------------------------
library(kableExtra)

## ------------------------------------------------------------------------
library(sensorThings4R)

## ------------------------------------------------------------------------
# Load SensorThings Locations
loc = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
class(loc)


# Load SensorThings FoIs
foi = senseFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
class(foi)


# Load SensorThings Things
s1 = senseThings("https://toronto-bike-snapshot.sensorup.com/v1.0")

class(s1)

## ------------------------------------------------------------------------
level1 = senseLocations("http://example.sensorup.com/v1.0")
level2 = makeThingLocation(level1)

knitr::kable(level2) %>%
  kable_styling(bootstrap_options = "striped", font_size = 10) %>%
  scroll_box(width = "100%", height = "200px")

class(level2)

n = senseFoI("http://example.sensorup.com/v1.0")
u = makeThingFoI(n)

knitr::kable(tail(u)) %>%
  kable_styling(bootstrap_options = "striped", font_size = 10) %>%
  scroll_box(width = "100%", height = "200px")

## ---- out.width='100%'---------------------------------------------------
x = senseLocations("http://example.sensorup.com/v1.0")
y = makeThingLocation(x)
mapThingLocations(y)

j = senseFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
k = makeThingFoI(j)
mapThingFoI(k)

## ----error=TRUE----------------------------------------------------------
mapThingFoI(j)

## ---- out.width='100%'---------------------------------------------------
leaf1 = expressMapFoI("https://tasking-test.sensorup.com/v1.0")
leaf1

## ---- eval=FALSE---------------------------------------------------------
#  shinyThings()

