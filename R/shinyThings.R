#' @title Shiny App for SensorThings API
#' @description Runs a SensorThings API data visualisation tool
#' @return Runs the ShinyThings app
#' @export
#' @examples
#'
#'shinyThingsApp()

# APIurl = "https://toronto-bike-snapshot.sensorup.com/v1.0"

shinyThingsApp = function(){
  ui = shiny::fluidPage(

    titlePanel("ShinyThings"),
    sidebarLayout(position = "right",
                  sidebarPanel((h4("SensorThings details")), textInput("url", "Type SensorThings base URL here and press enter", "https://tasking-test.sensorup.com/v1.0")),
                  mainPanel(leafletOutput("sensorMap"))
    )
  )



  server <- function(input, output) {
    output$sensorMap <- renderLeaflet({
      expressMapThings(input$url)
    })

    observe(
      {
        click = input$sensorMap_marker_click
        print(input$sensorMap_marker_click$id)
      }
    )
  }

  shinyApp(ui, server)

}
