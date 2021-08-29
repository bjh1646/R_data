library(shiny)

numberDisplayUI = function(Id){
  ns - NS(Id)
  tagList(
    sliderInput("inputNum"), "Select Number:", min=1, max=100, value=500,
    textOutput(ns("OutputNum"))
  )
}

numberDisplay = function(input, output, session){
  output$outputNum = renderText({
    input$inputNum
  })
}

ui <- fluidPage(
  numberDisplayUI("firstID")
)

server <- function(input, output) {
  callModule(numberDisplay, "firstID")
}

shinyApp(ui, server)