#' @title Shiny App for SensorThings API
#' @description Runs a SensorThings API data visualisation tool
#' @return Runs the ShinyThings app
#' @export
#' @examples
#'
#'shinyThingsApp()

# APIurl = "https://toronto-bike-snapshot.sensorup.com/v1.0"

shinyThings = function(){

  homeText = "ShinyThings was developed as an R visualisation tool for data from SensorThings APIs.\n In the map tab the user can insert a SensorThings base url (e.g. https://toronto-bike-snapshot.sensorup.com/v1.0). This generates a leaflet map with the features of interest present in the sensor network."

  ui = shiny::fluidPage(

    shiny::titlePanel("ShinyThings"),
    shiny::tabsetPanel(type = "tabs",
                       tabPanel("Home", fluidRow(column(8, homeText),column(4, h4("insert image here")))),
                       tabPanel("Map", shiny::sidebarLayout(position = "right",
                                                            shiny::sidebarPanel(shiny::textInput("inputUrl", "Enter SensorThings base URL here"), shiny::actionButton("URLsubmit", "Update map", shiny::icon("refresh"))),
                                                      shiny::mainPanel(leaflet::leafletOutput("sensorMap"), shiny::fluidRow(shiny::verbatimTextOutput("markerId"))))),
                      tabPanel("Data streams", "plots"))
                  )


  server <- function(input, output, session) {

    output$sensorMap = leaflet::renderLeaflet({
      initMap = function(){
        map <- leaflet::leaflet()  %>% leaflet::addTiles() %>% leaflet::setView(11.350790, 46.501825, zoom = 10)
        return (map)
      }
      initMap()
    })

    userInput <- reactiveVal("")

    observeEvent(input$URLsubmit, {
      userInputNew = paste0(input$inputUrl)
      userInput(userInputNew)
      cat("url:", input$inputUrl, "\n")
      output$sensorMap = leaflet::renderLeaflet({
        expressMapFoI(isolate(userInput()))
      })
    })

    observeEvent(input$userInput, {
      print(userInput)
    })

    observe(
      {
        click = input$sensorMap_marker_click
        print(click)
        output$markerId = shiny::renderText(input$sensorMap_marker_click$id)
      }
    )
  }

  shiny::shinyApp(ui, server)

}
