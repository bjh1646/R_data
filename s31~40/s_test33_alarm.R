library(shiny)

ui <- fluidPage(
  actionButton("show", "Show")
)

server <- function(input, output, session) {
  observeEvent(input$show, {
    showNotification("This is a notification.")
  })
}

shinyApp(ui, server)