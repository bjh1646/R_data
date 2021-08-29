library(shiny)
#install.packages("shinyjs")
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),
  
  actionButton("button", "Click me"),
  textInput("text", "Text")
)

server <- function(input, output, session) {
  observeEvent(input$button, {
    toggle("text")
  })
}

shinyApp(ui, server)