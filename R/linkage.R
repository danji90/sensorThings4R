#' @title Links features of interest with classes necessary for plotting
#' @description Runs a SensorThings API data visualisation tool
#' @return Runs the ShinyThings app
#' @export
#' @examples
#'
#'shinyThingsApp()

# APIurl = "https://toronto-bike-snapshot.sensorup.com/v1.0"

getObservations = function(url, FoIID){
  foiExt = "FeatureOfInterest"
  obsExt = "Observations"
  obsUrl = paste0(url,"/",foiExt,"(",FoIID,")","/",obsExt)
  obsJSON = jsonlite::fromJSON(obsUrl)
  obs = obsJSON$value
  return(obs)
}

#' @title Compile plotting Data
#' @description Runs a SensorThings API data visualisation tool
#' @return Runs the ShinyThings app
#' @export
#' @examples
#'
#'shinyThingsApp()

# APIurl = "https://toronto-bike-snapshot.sensorup.com/v1.0"

createPlotDF = function(obsDF){

  plotDF = data.frame(matrix(ncol = 5, nrow = 0), stringsAsFactors=FALSE)
  colnames(plotDF) = c("obsId", "timestamp", "result", "observedProperty", "datastream")

  observation = vector()
  for (row in 1:nrow(obsDF)){
    row_obsId = obsDF[row,1]
    row_timestamp = obsDF[row,3]
    row_result = obsDF[row,4]
    dsLink = jsonlite::fromJSON(obsDF[row, 6])
    View(dsLink)
    #print(colnames(dsLink))
    #opLink = jsonlite::fromJSON(obsDF[row, 11])
    row_dataStream = dsLink[1]




    #test = c(row_obsId,row_timestamp,row_result,row_dataStream)
    #print(test)
  }
}
