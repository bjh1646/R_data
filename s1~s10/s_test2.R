library(shiny)

ui <- fluidPage(
  textInput("myText", "텍스트를 입력하세요"),
  verbatimTextOutput("txt")
)

server <- function(input, output, session) {
  output$txt = renderPrint({
    req(input$myText)
    input$myText
  })
}

shinyApp(ui, server)
