#' @title Shiny App for SensorThings API
#' @description Runs a SensorThings API data visualisation tool. Loads all station Locations (url/Locations) on a map when given an input SensorThings URL. Associated Thing info is displayed when map markers are clicked.
#' @return Shiny app UI
#' @export
#' @examples
#'\dontrun{
#'shinyThings()
#'}

shinyThings = function(){
  shiny::shinyApp(

    ui = shiny::fluidPage(

      shiny::titlePanel("ShinyThings"),
      shiny::fluidRow("Welcome to ShinyThings! This shiny app loads the station locations from SensorThings APIs. Paste a SensorThings base URL (e.g. https://toronto-bike-snapshot.sensorup.com/v1.0) into the input field. The sensor locations will appear on the map. Click the map markers for more information about the stations. Have fun using ShinyThings!"),
      shiny::HTML("<br>"),
      shiny::sidebarLayout(position = "right",
                           shiny::sidebarPanel(shiny::textInput("inputUrl", "Paste SensorThings base URL here and update map"),
                                               shiny::actionButton("URLsubmit", "Update map", shiny::icon("refresh")),
                                               # Show URL button, used for testing
                                               #shiny::actionButton("urlShow", "Show URL", shiny::icon("refresh")),
                                               shiny::HTML("<br><br>"),
                                               shiny::helpText("Station ID: "),
                                               shiny::textOutput("thingId"),
                                               shiny::helpText("Station name: "),
                                               shiny::textOutput("thingName"),
                                               shiny::helpText("Description: "),
                                               shiny::textOutput("thingDescription"),
                                               shiny::helpText("Latitude/Longitude: "),
                                               shiny::textOutput("locationCoords"),
                                               shiny::helpText("Thing Self Link: "),
                                               shiny::textOutput("thingSelfLink")
                           ),
                           shiny::mainPanel(leaflet::leafletOutput("sensorMap", height = 500))
      )
    ),
    server <- function(input, output, session) {

      output$sensorMap = leaflet::renderLeaflet({
        initMap = function(){
          map <- leaflet::leaflet()  %>% leaflet::addTiles() %>% leaflet::setView(11.350790, 46.501825, zoom = 3)
          return (map)
        }
        initMap()
      })

      userInput  <- shiny::reactiveVal("")

      # Function for the "Show URL" button, used for testing
      # shiny::observeEvent(input$urlShow, {
      #   print(userInput())
      # })

      shiny::observeEvent(input$URLsubmit, {
        userInputNew = paste0(input$inputUrl)
        userInput(userInputNew)
        output$sensorMap = leaflet::renderLeaflet({
          expressMapLocations(shiny::isolate(userInput()))
        })
      })

      shiny::observeEvent(input$sensorMap_marker_click, {
        markerId = input$sensorMap_marker_click$id
        locThings = getLocationThings(userInput(), input$sensorMap_marker_click$id)
        print(locThings[1,1])

        output$locationCoords = shiny::renderText({
          paste(toString(input$sensorMap_marker_click$lat), "/", toString(input$sensorMap_marker_click$lng))
        })

        output$thingId = shiny::renderText({
          toString(locThings[1,1])
        })

        output$thingDescription = shiny::renderText({
          toString(locThings[1,3])
        })

        output$thingName = shiny::renderText({
          toString(locThings[1,4])
        })

        output$thingSelfLink = shiny::renderText({
          toString(locThings[1,2])
        })
      })
    }
  )
}
