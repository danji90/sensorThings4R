#' @title Load Thing data from SensorThings APIs
#' @description This function parses Thing SensorThings JSON data and stores it in an R data frame. Contains the complete Thing data for further processing.
#' @param url A SensorThings API base url (string!)
#' @return A "thingObject" dataframe containing data from url/Things
#' @export
#' @examples
#'s1 = senseThings("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'head(s1)
#'
#'\dontrun{
#'s2 = senseThings("https://tasking-test.sensorup.com/v1.0")
#'s2
#'
#'s3 = senseThings("http://example.sensorup.com/v1.0")
#'class(s3)
#'}

senseThings = function (url){
  thingsExt = "Things"
  thingsUrl = paste0(url, "/", thingsExt)
  thingsJSON = jsonlite::fromJSON(thingsUrl)
  things = thingsJSON$value

  # Add class "thingObject"
  class(things) = append(class(things), "thingObject")

  return(things)
}
