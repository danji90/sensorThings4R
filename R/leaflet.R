#' @title Display SensorThing locations on a map
#' @description Creates markers from "thingLocation" objects and loads them onto a Leaflet map
#' @param locDf Data frame with class "thingLocations" and "mapThing"
#' @return A list object containing information from url/Things
#' @export
#' @importFrom dplyr %>%
#' @examples
#'x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'y = makeThingLocation(x)
#'mapThingLocations(y)

mapThingLocations = function(locDf){
  if (class(locDf)[2] == "thingLocation" & class(locDf)[3] == "mapThing"){
    map <- leaflet::leaflet(data=locDf) %>% leaflet::addTiles() %>% leaflet::addCircleMarkers(radius = 8, color = "blue", fillOpacity = 0.6, ~long, ~lat, popup = ~as.character(address), layerId=~id, clusterOptions = leaflet::markerClusterOptions())
    return(map)
  } else {
    stop("This is not a mapThing and/or thingLocation object")
  }

}


#' @title Directly load thing locations to leaflet map
#' @description Uses senseLocations(), makeThingLocation() and mapThings to build leaflet map with a single function
#' @param url Path or URL to input file
#' @export
#' @examples
#'\dontrun{
#'map1 = expressMapLocations("https://tasking-test.sensorup.com/v1.0")
#'map1
#'
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
#' @description Creates markers from "mapThing" objects and loads them onto a Leaflet map
#' @param foiDf Data frame with class "thingFoI" and "mapThing"
#' @return A list object containing information from url/FeaturesOfInterest
#' @importFrom dplyr %>%
#' @export
#' @examples
#'x = senseFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'y = makeThingFoI(x)
#'mapThingFoI(y)

mapThingFoI = function(foiDf){
  if (class(foiDf)[2] == "thingFoI" & class(foiDf)[3] == "mapThing"){
    map <- leaflet::leaflet(data=foiDf) %>% leaflet::addTiles() %>% leaflet::addCircleMarkers(radius = 8, color = "red", fillOpacity = 0.6, ~long, ~lat, popup = ~as.character(name), layerId=~id, clusterOptions = leaflet::markerClusterOptions())
    return(map)
  } else {
    stop("This is not a mapThing and/or thingFoI object")
  }
}

#' @title Directly load thing FoIs to leaflet map
#' @description Uses senseFoI(), makeThingFoI() and mapThingFoI to build leaflet map with a single function
#' @param url Path or URL to input file
#' @export
#' @examples
#'\dontrun{
#'leaf1 = expressMapFoI("https://tasking-test.sensorup.com/v1.0")
#'leaf1
#'
#'leaf2 = expressMapFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'leaf2
#'}

expressMapFoI = function(url){
  x = senseFoI(url)
  y = makeThingFoI(x)
  z = mapThingFoI(y)
  return(z)
}
