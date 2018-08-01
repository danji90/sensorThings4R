#' @title Display SensorThing locations on a map
#' @description Creates markers from "thingLocation" objects and loads them onto a Leaflet map
#' @param locDf Data frame with class "thingLocations"
#' @return A list object containing information from url/Things
#' @export
#' @examples
#'x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'y = makeThingLocation(x)
#'mapThingLocations(y)

mapThingLocations = function(locDf){
  if (inherits(locDf,"mapThing")){
    map <- leaflet::leaflet(data=locDf)  %>% leaflet::addTiles() %>% leaflet::addMarkers(~long, ~lat, popup = ~as.character(address), layerId=~id, clusterOptions = leaflet::markerClusterOptions())
    return(map)
  } else {
    stop("This is not a mapThing object")
  }

}


#' @title Directly load thing locations to leaflet map
#' @description Uses senseLocations(), makeThingLocation() and mapThings to build leaflet map with a single function
#' @param url Path or URL to input file
#' @export
#' @examples
#'map1 = expressMapLocations("https://tasking-test.sensorup.com/v1.0")
#'map1
#'
#'\dontrun{
#'map2 = expressMapLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'map2
#'}


expressMapLocations = function(url){
  x = senseLocations(url)
  y = makeThingLocation(x)
  z = mapThingLocations(y)
  return(z)
}


#' @title Display SensorThing Features of Interest on a map
#' @description Creates markers from "thingObject" objects and loads them onto a Leaflet map
#' @param locDf Data frame with class "thingObject"
#' @return A list object containing information from url/FeaturesOfInterest
#' @export
#' @examples
#'x = senseFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'y = makeThingFoI(x)
#'mapThingFoI(y)

mapThingFoI = function(locDf){
  if (inherits(locDf,"mapThing")){
    map <- leaflet::leaflet(data=locDf)  %>% leaflet::addTiles() %>% leaflet::addMarkers(~long, ~lat, popup = ~as.character(name), layerId=~id, clusterOptions = leaflet::markerClusterOptions())
    return(map)
  } else {
    stop("This is not a mapThing")
  }
}

#' @title Directly load thing FoIs to leaflet map
#' @description Uses senseFoI(), makeThingFoI() and mapThingFoI to build leaflet map with a single function
#' @param url Path or URL to input file
#' @export
#' @examples
#'leaf1 = expressMapFoI("https://tasking-test.sensorup.com/v1.0")
#'leaf1
#'
#'\dontrun{
#'leaf2 = expressMapFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'leaf2
#'}

expressMapFoI = function(url){
  x = senseFoI(url)
  y = makeThingFoI(x)
  z = mapThingFoI(y)
  return(z)
}
