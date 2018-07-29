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

senseThings = function (url){
  thingsExt = "Things"
  query = "?$select=id,name"
  thingsUrl = paste0(url, "/", thingsExt, query)
  print(thingsUrl)
  thingsJSON = jsonlite::fromJSON(thingsUrl)
  things = thingsJSON$value
  return(things)
}
