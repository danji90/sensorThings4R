#' @title Loads location data from any SensorThings API
#' @description
#' @param url The SensorThings API url containing the data in SensorThings web standard in string(!) format
#' @return A list object containing information from url/Things
#' @export
#' @examples
#'x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0/")
#'x

locationLeaflet = function(locDf){
  if (inherits(locDf,"thingLocation")){
    map <- leaflet::leaflet(data=locDf) %>% leaflet::addTiles() %>% leaflet::addMarkers(~long, ~lat, popup = ~as.character(name), clusterOptions = leaflet::markerClusterOptions())
  } else {
    print("This is not a thingLocation object")
  }
  return(map)
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


thingsToMap = function(url){
  x = senseLocations(url)
  y = locToDf(x)
  z = locationLeaflet(y)
  return(z)
}
