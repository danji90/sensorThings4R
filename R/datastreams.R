#' @title Loads datastream data from any SensorThings API
#' @description This function parses SensorThings JSON data and stores it in an R data frame
#' @param url A SensorThings API base url (string!) containing the data in SensorThings web standard
#' @return A data frame object containing data from url/Datastreams
#' @export
#' @examples
  #'ds = senseDataStreams("https://toronto-bike-snapshot.sensorup.com/v1.0")
#'ds

senseDataStreams = function(url){
  dataStreamExt = "Datastreams"
  dataStreamUrl = paste0(url, "/", dataStreamExt)
  dataStreamJSON = jsonlite::fromJSON(dataStreamUrl)
  dataStreams = dataStreamJSON$value
  class(dataStreams) = append(class(dataStreams), "thingObject")
  return(dataStreams)
}

