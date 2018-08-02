#' @title Loads Location data from SensorThings APIs
#' @description This function parses Location SensorThings JSON data and stores it in an R data frame. Contains the complete Location data for further processing.
#' @param url A SensorThings API url (string!) containing the data in SensorThings web standard
#' @return A "locationObject" dataframe containing data from url/Locations
#' @export
#' @examples
#'x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'head(x)
#'
#'\dontrun{
#'v = senseLocations("https://tasking-test.sensorup.com/v1.0")
#'v
#'
#'a = senseLocations("http://example.sensorup.com/v1.0")
#'a
#'}

senseLocations = function (url){
  locationsExt = "Locations"
  locUrl = paste0(url, "/", locationsExt)
  locJSON = jsonlite::fromJSON(locUrl)
  locations = locJSON$value
  class(locations) = append(class(locations), "locationObject")
  return(locations)
}

#' @title Create a "thingLocation" data frame
#' @description Creates a data frame from a previously parsed SensorThings JSON location object with the added class "thingLocation"
#' @param locationDF A data frame created using senseLocations (formatted according to SensorThings API)
#' @return Dataframe of classes "thingLocation" and "mapThing"
#' @export
#' @examples
#'n = senseLocations("http://example.sensorup.com/v1.0")
#'u = makeThingLocation(n)
#'head(u)

makeThingLocation = function(locationDF){

  if (inherits(locationDF,"locationObject")){

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

  # Append classes "thingLocation" and "mapThing"
  class(locObj) = append(class(locObj), "thingLocation")
  class(locObj) = append(class(locObj), "mapThing")

  return(locObj)
  } else {
    stop("This is not a locationObject")
  }
}



#' @title Get things at a location with specific ID
#' @description Gets the things (e.g. abstraction for data generating devices) at a location with specific ID and stores their information in an R dataframe
#' @param url A SensorThings API url (string!)
#' @param locId The location Id of a location within the sensor network (must be present within the SensorThings network of the input url!)
#' @return A dataframe containing data from url/Location(locId)/Things
#' @export
#' @examples
#'thing = getLocationThings("https://toronto-bike-snapshot.sensorup.com/v1.0", 1462)
#'thing

getLocationThings = function(url, locId){
  locationsExt = "Locations"
  thingsExt = "Things"
  locThingsUrl = paste0(url, "/", locationsExt, "(", toString(locId), ")", "/", thingsExt)
  locThingsJSON = jsonlite::fromJSON(locThingsUrl)
  locThings = locThingsJSON$value
  locThings$properties <- NULL
  return(locThings)
}

