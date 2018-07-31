#' @title Create interactive plot for SensorThings data
#' @description Creates interactive graph for display on the ShinyThings app
#' @param locDf Data frame with class "thingLocations"
#' @return A list object containing information from url/Things
#' @export
#' @examples
#'
createShinyGraph = function(obsDf){
  plot(parsedate::parse_iso_8601(obsDf$phenomenonTime), obsDf$result)
}

