#' @title Loads location data from any SensorThings API
#' @description This function parses SensorTHings JSON data and stores it in an R data frame
#' @param url A SensorThings API url (string!) containing the data in SensorThings web standard
#' @return A data frame object containing data from url/Things
#' @export
#' @examples
#'x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'x
#'
#'v = senseLocations("https://tasking-test.sensorup.com/v1.0")
#'v
#'
#'a = senseLocations("http://example.sensorup.com/v1.0")
#'a

senseFoI = function (url){
  FoIExt = "FeaturesOfInterest"
  FoIUrl = paste0(url, "/", FoIExt)
  FoIJSON = jsonlite::fromJSON(FoIUrl)
  FoIs = FoIJSON$value
  return(FoIs)
}

#' @title Create a "thingLocation" data frame
#' @description Creates a data frame from a previously parsed SensorThings JSON location object with the added class "thingLocation"
#' @param FoIDF A data frame created using senseLocations (formatted according to SensorThings API)
#' @return Data frame of class "thingLocation"
#' @export
#' @examples
#'n = senseLocations("http://example.sensorup.com/v1.0")
#'u = makeThingLocation(n)
#'u
#'

makeThingFoI = function(FoIDF){

  # Limit to point data
  FoIDF = FoIDF[FoIDF$feature$type=="Point", ]

  # Stores the longitude and latitude values from SensorThings JSON objects into a table, then converts to data frame
  coords = do.call(rbind, FoIDF$feature$coordinates)
  coords = data.frame(coords)

  # Define data columns
  id = FoIDF[1]
  selfLink = FoIDF[2]
  featureType = FoIDF$feature$type
  name = FoIDF[4]
  obsLink = FoIDF[7]

  # Create new object with data columns
  foiObj = data.frame(id, selfLink, name, featureType, obsLink, coords$X1, coords$X2, stringsAsFactors = FALSE)

  # Define data frame column header
  colnames(foiObj) = c("id", "selfLink", "name", "featureType", "observationLink", "long", "lat")

  # Convert lat + long values to numeric
  foiObj$long = as.numeric(foiObj$long)
  foiObj$lat = as.numeric(foiObj$lat)

  # Append class "thingObject"
  class(foiObj) = append(class(foiObj), "thingObject")

  return(foiObj)
}

