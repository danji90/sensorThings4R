#' @title Loads location data from any SensorThings API
#' @description
#' @param url The SensorThings API url containing the data in SensorThings web standard in string(!) format
#' @return A list object containing information from url/Things
#' @export
#' @examples
#'x = createThingMap("https://toronto-bike-snapshot.sensorup.com/v1.0/")
#'y = locToDf(x)
#'mapThings(y)

mapThings = function(locDf){
  if (inherits(locDf,"thingLocation")){
    map <- leaflet::leaflet(data=locDf) %>% leaflet::addTiles() %>% leaflet::addMarkers(~long, ~lat, popup = ~as.character(name), clusterOptions = leaflet::markerClusterOptions())
    return(map)
  } else {
    stop("This is not a thingLocation object")
  }

}


#' @title Directly plot thing locations to map

#' @description Uses
#' @param url Path or URL to input file
#' @return Object of class "track"
#' @export
#' @examples
#'map1 = thingsToMap("https://tasking-test.sensorup.com/v1.0/")
#'map1
#'
#'map2 = thingsToMap("https://toronto-bike-snapshot.sensorup.com/v1.0/")
#'map2


expressMapThings = function(url){
  x = senseLocations(url)
  y = makeThingLocation(x)
  z = mapThings(y)
  return(z)
}
