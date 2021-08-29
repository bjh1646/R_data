library(shiny)

ui <- fluidPage(
  column(4,
         numericInput("x", "Values", 5),
         br(),
         actionButton("button", "Show")),
  column(8, tableOutput("table"))
)

server <- function(input, output) {
  observeEvent(input$button, {
    cat("Showing", input$x, "rows\n")  
  })
  
  df = eventReactive(input$button, {
    head(cars, input$x)
  })
  
  output$table = renderTable({
    df()
  })
  
}

shinyApp(ui, server)