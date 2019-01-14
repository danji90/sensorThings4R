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

#' @title Filter observations by StreamId and time interval and store them in a dataframe
#' @description This function parses Thing SensorThings JSON data and stores it in an R data frame. Contains the complete Thing data for further processing.
#' @param url A SensorThings API base url (string!)
#' @return A "obsObject" dataframe containing data from url/Datastreams(id)/Observations
#' @export
#' @examples
#' x = filterObservations("http://elcano.init.uji.es:8082/FROST-Server/v1.0", 1, "2018-11-29T00:45:45.842Z", "2018-11-29T05:02:05.445Z")
#' x

filterObservations = function(url, streamID, startTime, endTime){
  streamsExt = paste0("Datastreams(", as.character(streamID), ")")
  obsExt = "Observations"
  selectExt = "?$select=phenomenonTime,result"
  filter = paste0("&$filter=overlaps(phenomenonTime,", as.character(startTime), "/", as.character(endTime), ")")
  obsUrl = paste0(url, "/", streamsExt, "/", obsExt, selectExt, filter)
  print(obsUrl)


  obsJSON = jsonlite::fromJSON(obsUrl)
  observations = obsJSON$value
  print(observations)
  formatObs = data.frame("phenomenonTime"=anytime::anytime(observations$phenomenonTime), "result"=observations$result)

  # Assign object class
  class(formatObs) = append(class(formatObs), "obsObject")

  return(formatObs)
}
