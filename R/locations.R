#' @title Loads location data from any SensorThings API
#' @description
#' @param url The SensorThings API url containing the data in SensorThings web standard in string(!) format
#' @return A list object containing information from url/Things
#' @export
#' @examples
#'x = senseLocations(https://toronto-bike-snapshot.sensorup.com/v1.0/)
#'x
#'
#'

senseLocations = function (url){
  locationsExt = "Locations"
  locUrl = paste0(url,locationsExt)
  locJSON = fromJSON(locUrl)
  locations = locJSON$value
  return(locations)
}

#' @title Create Track Object

#' @description Reads table format .txt files
#' @param input Path or URL to input file
#' @param headerBool Boolean value for presence of header in the file
#' @param sepStr String of the separator character (e.g. ",")
#' @return Object of class "track"
#' @export
#' @examples
#'dataPath <- system.file("extdata", "data_pm10.csv", package="tracks4r")
#'
#'x = readTrack(dataPath)
#'
#'class(x)
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
  return(loc_array)
}
