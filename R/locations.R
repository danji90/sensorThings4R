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

#' @title Assign "thingLocation" class to data.frame object
#' @description
#' @param url The SensorThings API url containing the data in SensorThings web standard in string(!) format
#' @return A list object containing information from url/Things
#' @export
#' @examples
#'x = senseLocations(https://toronto-bike-snapshot.sensorup.com/v1.0/)
#'x
#'
defineThingLocation = function(df){
  obj = df
  class(obj) = append(class(obj), "thingLocation")
  return(obj)
}



#' @title Create Track Object
#' @description Reads table format .txt files
#' @param locationDF Path or URL to input file
#' @return Object of class "track"
#' @export
#' @examples
#'n = senseLocations("http://example.sensorup.com/v1.0/")
#'u = locToDf(n)
#'u
#'
#'

locToDf = function(locationDF){
  coords = do.call(rbind, locationDF$location$coordinates)
  coords = data.frame(coords)
  longs = as.numeric(coords$X1)
  lats = as.numeric(coords$X2)
  names =locationDF$name
  loc_array = cbind(names, as.numeric(coords$X1), as.numeric(coords$X2))
  loc_array = data.frame(loc_array, stringsAsFactors = FALSE)
  colnames(loc_array) = c("name", "long", "lat")
  loc_array$long = as.numeric(loc_array$long)
  loc_array$lat = as.numeric(loc_array$lat)
  loc_array = defineThingLocation(loc_array)
  return(loc_array)
}


