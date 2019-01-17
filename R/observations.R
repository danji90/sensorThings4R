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
  filter = paste0("&$filter=phenomenonTime%20gt%20", as.character(startTime), "%20and%20phenomenonTime%20lt%20", as.character(endTime))
  obsUrl = paste0(url, "/", streamsExt, "/", obsExt, selectExt, filter)
  cat("Request URL: ", obsUrl)

  # Create data frame with first 100 values (this is the maximum size a SensorThings request will get)
  # Store link for the next 100 values in variable and declare variable for last request
  obsJSON = jsonlite::fromJSON(obsUrl)
  observations = obsJSON$value

  # If the dataset is larger than 100 values
  if (is.null(obsJSON$"@iot.nextLink") == FALSE){
    nextLink = obsJSON$"@iot.nextLink"
    lastLink = NULL

    # Loop request json using the @iot.nextLink for the follwing 100 values until nextLink == NULL
    # Store last @iot.nextLink in lastLink to get the final JSON file
    # Bind results in every loop
    while (is.null(nextLink) == FALSE)
    {
      nextJSON = jsonlite::fromJSON(nextLink)
      nextValues = nextJSON$value
      nextLink = nextJSON$"@iot.nextLink"
      observations = rbind(observations,nextValues)
      if (is.null(nextLink) == FALSE){
        lastLink = nextLink
      }
    }
    if (is.null(lastLink) == FALSE){
      # Get final JSON file using lastLink and bind result
      lastJSON = jsonlite::fromJSON(lastLink)
      lastValues = lastJSON$value
      observations = rbind(observations,lastValues)
    }
  }

  formatObs = data.frame("phenomenonTime"=anytime::anytime(observations$phenomenonTime), "result"=observations$result)

  # Assign object class
  class(formatObs) = append(class(formatObs), "obsObject")

  return(formatObs)
}
