#' @title Shiny App for SensorThings API
#' @description Runs a SensorThings API data visualisation tool
#' @return Runs the ShinyThings Shiny app
#' @export
#' @examples
#'
#'shinyThings()

# APIurl = "https://toronto-bike-snapshot.sensorup.com/v1.0"

shinyThings = function(){
  ui = shiny::fluidPage(

    shiny::titlePanel("ShinyThings"),
    shiny::sidebarLayout(position = "right",
                  shiny::sidebarPanel(shiny::textInput("inputUrl", "Type SensorThings base URL here and press enter"),
                                      shiny::actionButton("URLsubmit", "Update map", shiny::icon("refresh")),
                                      #shiny::actionButton("urlShow", "show url", shiny::icon("refresh")),
                                      shiny::HTML("<br><br><br>"),
                                      shiny::helpText("Station ID: "),
                                      shiny::textOutput("thingId"),
                                      shiny::HTML("<br>"),
                                      shiny::helpText("Station name: "),
                                      shiny::textOutput("thingName"),
                                      shiny::HTML("<br>"),
                                      shiny::helpText("Description: "),
                                      shiny::textOutput("thingDescription"),
                                      shiny::HTML("<br>"),
                                      shiny::helpText("Thing Self Link: "),
                                      shiny::textOutput("thingSelfLink")
                                      ),
                  shiny::mainPanel(leaflet::leafletOutput("sensorMap", height = 550))
    )
  )


  server <- function(input, output, session) {

    output$sensorMap = leaflet::renderLeaflet({
      initMap = function(){
        map <- leaflet::leaflet()  %>% leaflet::addTiles() %>% leaflet::setView(11.350790, 46.501825, zoom = 3)
        return (map)
      }
      initMap()
    })

    userInput  <- shiny::reactiveVal("")

    shiny::observeEvent(input$urlShow, {
      print(userInput())
    })

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

  shiny::shinyApp(ui, server)

}
