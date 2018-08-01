#' @title Load FeatureOfInterest data from SensorThings APIs
#' @description This function parses FoI SensorThings JSON data and stores it in an R data frame. Contains the complete FoI data for further processing.
#' @param url A SensorThings API base url (string!)
#' @return A "foiObject" dataframe containing data from url/FeaturesOfInterest
#' @export
#' @examples
#'x = senseFoI("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'head(x)
#'
#'\dontrun{
#'v = senseFoI("https://tasking-test.sensorup.com/v1.0")
#'v
#'
#'a = senseFoI("http://example.sensorup.com/v1.0")
#'a
#'}

senseFoI = function (url){
  FoIExt = "FeaturesOfInterest"
  FoIUrl = paste0(url, "/", FoIExt)
  FoIJSON = jsonlite::fromJSON(FoIUrl)
  FoIs = FoIJSON$value
  class(FoIs) = append(class(FoIs), "foiObject")
  return(FoIs)
}

#' @title Create "thingFoI" data frame
#' @description Creates a data frame from "foiObject" data with the added classes "thingFoI" and "mapThing". "thingFoI" objects contain web links to the observations of every feature of interest, granting access to the observed data. "mapThing" objects can be imported onto a leaflet map.
#' @param FoIDF Dataframe of class "foiObject"
#' @return Dataframe of class "thingFoI" and "mapThing"
#' @export
#' @examples
#'n = senseFoI("http://example.sensorup.com/v1.0")
#'u = makeThingFoI(n)
#'head(u)

makeThingFoI = function(FoIDF){

  # Check if input is a foiObject
  if (inherits(FoIDF,"foiObject")){

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

  # Append classes "thingFoI" and "mapThing"
  class(foiObj) = append(class(foiObj), "thingFoI")
  class(foiObj) = append(class(foiObj), "mapThing")

  return(foiObj)
  } else {
    stop("This is not a foiObject")
  }
}

