#' @title Loads location data from any SensorThings API
#' @description This function parses SensorTHings JSON data and stores it in an R data frame
#' @param url A SensorThings API url (string!) containing the data in SensorThings web standard
#' @return A data frame object containing data from url/Things
#' @export
#' @examples
#'s1 = senseThings("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'s1
#'
#'s2 = senseThings("https://tasking-test.sensorup.com/v1.0")
#'s2
#'
#'s3 = senseThings("http://example.sensorup.com/v1.0")
#'s3

senseThings = function (url){
  thingsExt = "Things"
  thingsUrl = paste0(url, "/", thingsExt)
  thingsJSON = jsonlite::fromJSON(thingsUrl)
  things = thingsJSON$value
  return(things)
}
