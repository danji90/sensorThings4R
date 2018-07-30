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

    test <- reactiveVal("")

    print(isolate(test()))

    observeEvent(input$URLsubmit, {
      testNew = paste0(input$inputUrl)
      test(testNew)
      cat("url:", input$inputUrl, "\n")
      output$sensorMap = leaflet::renderLeaflet({
        expressMapFoI(isolate(test()))
      })
    })

    observeEvent(input$test, {
      print(test)
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
