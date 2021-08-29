library(shiny)

numberDisplayUI = function(Id){
  ns - NS(Id)
  tagList(
    sliderInput(ns("inputNum")), "Select Number:", min=1, max=100, value=500,
    textOutput(ns("OutputNum"))
  )
}

numberDisplay = function(input, output, session){
  output$outputNum = renderText({
    input$inputNum
  })
}

ui <- fluidPage(
  numberDisplayUI("firstID"),
  numberDisplayUI("secondID")
)

server <- function(input, output) {
  callModule(numberDisplay, "firstID")
  callModule(numberDisplay, "secondID")
}

shinyApp(ui, server)