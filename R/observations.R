#' @title Lists the datastreams of a thing and loads them into R
#' @description This function parses Thing SensorThings JSON data and stores it in an R data frame. Contains the complete Thing data for further processing.
#' @param url A SensorThings API base url (string!), a thing Id
#' @return A "streamObject" dataframe containing data from url/Thing(id)/Datastreams
#' @export
#' @examples
#' x = getThingDatastreams("http://elcano.init.uji.es:8082/FROST-Server/v1.0", 1)
#' x
#'\dontrun{
#'v = getThingDatastreams("https://tasking-test.sensorup.com/v1.0", 1)
#'v

getThingDatastreams = function(url, thingID){

  # thingsExt = "Things(" + as.character(thingID) + ")"
  thingsExt = paste0("Things(", as.character(thingID), ")")
  streamExt = "Datastreams?$select=name,id"
  streamsUrl = paste0(url, "/", thingsExt, "/", streamExt)


  streamsJSON = jsonlite::fromJSON(streamsUrl)
  streams = streamsJSON$value

  # Add class "streamObject"
  class(streams) = append(class(streams), "streamObject")

  return(streams)
}

#' @title Load datastreams and observations into R
#' @description This function parses Thing SensorThings JSON data and stores it in an R data frame. Contains the complete Thing data for further processing.
#' @param url A SensorThings API base url (string!), a thing Id
#' @return A "streamObject" dataframe containing data from url/Thing(id)/Datastreams
#' @export
#' @examples
#' x = getThingDatastreams("http://elcano.init.uji.es:8082/FROST-Server/v1.0", 1)
#' x
#'\dontrun{
#'v = getThingDatastreams("https://tasking-test.sensorup.com/v1.0", 1)
#'v

getStreamObservations = function(url, streamID){

  streamsExt = paste0("Datastreams(", as.character(streamID), ")")
  obsExt = "Observations?$select=resultTime,result"
  obsUrl = paste0(url, "/", streamsExt, "/", obsExt)
  print(obsUrl)


  obsJSON = jsonlite::fromJSON(obsUrl)
  observations = obsJSON$value

  # Add class "streamObject"
  class(observations) = append(class(observations), "obsObject")

  return(observations)
}
