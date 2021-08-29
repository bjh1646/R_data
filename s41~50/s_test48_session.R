library(shiny)

ui <- fluidPage(
  verbatimTextOutput("session_info")
)

server <- function(input, output, session) {
  output$session_info = renderPrint({
    names(session)
  })
}

shinyApp(ui, server)