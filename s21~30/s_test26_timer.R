library(shiny)

ui <- fluidPage(
  textOutput("currentTime")
)

server <- function(input, output, session) {
  output$currentTime = renderText({
    invalidateLater(1000, session)
    paste("The current time is", Sys.time())
  })
}

shinyApp(ui, server)