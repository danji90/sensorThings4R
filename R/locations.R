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

senseLocations = function (url){
  locationsExt = "Locations"
  locUrl = paste0(url, "/", locationsExt)
  locJSON = jsonlite::fromJSON(locUrl)
  locations = locJSON$value
  return(locations)
}

#' @title Create a "thingLocation" data frame
#' @description Creates a data frame from a previously parsed SensorThings JSON location object with the added class "thingLocation"
#' @param locationDF A data frame created using senseLocations (formatted according to SensorThings API)
#' @return Data frame of class "thingLocation"
#' @export
#' @examples
#'n = senseLocations("http://example.sensorup.com/v1.0")
#'u = makeThingLocation(n)
#'u
#'

makeThingLocation = function(locationDF){

  # Limit to point data
  locationDF = locationDF[locationDF$location$type=="Point", ]

  # Stores the longitude and latitude values from SensorThings JSON objects into a table, then converts to data frame
  coords = do.call(rbind, locationDF$location$coordinates)
  coords = data.frame(coords)

  # Define data columns
  id = locationDF[1]
  selfLink = locationDF[2]
  featureType = locationDF$location$type
  address =locationDF[4]

  # Create new object with data columns
  locObj = data.frame(id, address, selfLink, featureType, coords$X1, coords$X2, stringsAsFactors = FALSE)

  # Define data frame column header
  colnames(locObj) = c("id", "address", "selfLink", "featureType", "long", "lat")

  # Convert lat + long values to numeric
  locObj$long = as.numeric(locObj$long)
  locObj$lat = as.numeric(locObj$lat)

  # Append class "thingLocation"
  class(locObj) = append(class(locObj), "thingObject")
  class(locObj) = append(class(locObj), "mapThing")

  return(locObj)
}

