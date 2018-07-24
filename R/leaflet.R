#' @title Loads location data from any SensorThings API
#' @description
#' @param url The SensorThings API url containing the data in SensorThings web standard in string(!) format
#' @return A list object containing information from url/Things
#' @export
#' @examples
#'x = senseLocations(https://toronto-bike-snapshot.sensorup.com/v1.0/)
#'x

locationLeaflet = function(locDf){
  map <- leaflet::leaflet(data=locDf) %>% leaflet::addTiles() %>% leaflet::addMarkers(~long, ~lat, popup = ~as.character(name), clusterOptions = leaflet::markerClusterOptions())
  return(map)
  }
