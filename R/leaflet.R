#' @title Display SensorThing locations on a map
#' @description Creates markers from "thingLocation" objects and loads them onto a Leaflet map
#' @param locDf Data frame with class "thingLocations"
#' @return A list object containing information from url/Things
#' @export
#' @examples
#'x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'y = makeThingLocation(x)
#'mapThings(y)

mapThings = function(locDf){
  if (inherits(locDf,"thingLocation")){
    map <- leaflet::leaflet(data=locDf)  %>% leaflet::addTiles() %>% leaflet::addMarkers(~long, ~lat, popup = ~as.character(address), layerId=~id, clusterOptions = leaflet::markerClusterOptions())
    return(map)
  } else {
    stop("This is not a thingLocation object")
  }

}


#' @title Directly load thing locations to leaflet map
#' @description Uses senseLocations(), makeThingLocation() and mapThings
#' @param url Path or URL to input file
#' @return Object of class "track"
#' @export
#' @examples
#'map1 = expressMapThings("https://tasking-test.sensorup.com/v1.0")
#'map1
#'
#'map2 = expressMapThings("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'map2


expressMapThings = function(url){
  x = senseLocations(url)
  y = makeThingLocation(x)
  z = mapThings(y)
  return(z)
}
