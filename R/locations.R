#' @title Loads location data from any SensorThings API
#' @description This function parses SensorTHings JSON data and stores it in an R data frame
#' @param url The SensorThings API url containing the data in SensorThings web standard in string(!) format
#' @return A data frame object containing data from url/Things
#' @export
#' @examples
#'x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0/")
#'x
#'
#'v = senseLocations("https://tasking-test.sensorup.com/v1.0/")
#'v
#'
#'a = senseLocations("http://example.sensorup.com/v1.0/")
#'a

senseLocations = function (url){
  locationsExt = "Locations"
  locUrl = paste0(url,locationsExt)
  locJSON = jsonlite::fromJSON(locUrl)
  locations = locJSON$value
  return(locations)
}

#' @title Assign "thingLocation" class to data frame object
#' @description Appends the "thingLocation" class to the already present object classes
#' @param df A data frame created using senseLocations (formatted according to SensorThings API)
#' @return The input data frame with added class "thingLocation"
#' @export
#' @examples
#'x = senseLocations(https://toronto-bike-snapshot.sensorup.com/v1.0/)
#'y = defineThingLocation(x)
#'y

defineThingLocation = function(df){
  obj = df
  class(obj) = append(class(obj), "thingLocation")
  return(obj)
}



#' @title Create a "thingLocation" data frame
#' @description Create a "thingLocation" data frame from a previously parsed SensorThings JSON location object
#' @param locationDF A data frame created using senseLocations (formatted according to SensorThings API)
#' @return Data frame of class "thingLocation"
#' @export
#' @examples
#'n = senseLocations("http://example.sensorup.com/v1.0/")
#'u = makeThingLocation(n)
#'u
#'

makeThingLocation = function(locationDF){
  coords = do.call(rbind, locationDF$location$coordinates)
  coords = data.frame(coords)
  names =locationDF$name
  locObj = cbind(names, coords$X1, coords$X2)
  locObj = data.frame(locObj, stringsAsFactors = FALSE)
  colnames(locObj) = c("name", "long", "lat")
  locObj$long = as.numeric(locObj$long)
  locObj$lat = as.numeric(locObj$lat)
  locObj = defineThingLocation(locObj)
  return(locObj)
}


