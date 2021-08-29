library(shiny)

ui <- fluidPage(
  useShinyjs(),
  textInput("text", "텍스트"),
  actionButton("hide", "위젯숨기기/보이기")
)

server <- function(input, output, session) {
  observeEvent(input$hide, {
    toggle("text", anim = TRUE)
  })
}

shinyApp(ui, server)