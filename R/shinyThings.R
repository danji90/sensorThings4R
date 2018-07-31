#' @title Shiny App for SensorThings API
#' @description Runs a SensorThings API data visualisation tool
#' @return Runs the ShinyThings app
#' @export
#' @examples
#'
#'shinyThingsApp()

# APIurl = "https://toronto-bike-snapshot.sensorup.com/v1.0"

shinyThings = function(){
  ui = shiny::fluidPage(

    shiny::titlePanel("ShinyThings"),
    shiny::sidebarLayout(position = "right",
                  shiny::sidebarPanel(shiny::textInput("inputUrl", "Type SensorThings base URL here and press enter"), shiny::actionButton("URLsubmit", "Update map", shiny::icon("refresh"))),
                  shiny::mainPanel(leaflet::leafletOutput("sensorMap"))
    ),
    shiny::fluidRow(shiny::verbatimTextOutput("markerId"))
  )


  server <- function(input, output, session) {

    output$sensorMap = leaflet::renderLeaflet({
      initMap = function(){
        map <- leaflet::leaflet()  %>% leaflet::addTiles() %>% leaflet::setView(11.350790, 46.501825, zoom = 3)
        return (map)
      }
      initMap()
    })

    userInput  <- reactiveVal("")

    observeEvent(input$URLsubmit, {
      userInputNew = paste0(input$inputUrl)
      userInput(userInputNew)
      output$sensorMap = leaflet::renderLeaflet({
        expressMapFoI(isolate(userInput()))
      })
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
