library(shiny)

ui <- fluidPage(
  numericInput("obs", "Observation:", 10, min=1, max=100),
  verbatimTextOutput("value")
)

server <- function(input, output, session) {
  output$value = renderText({input$obs})
}

shinyApp(ui, server)
