library(shiny)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),
  textInput("text", "텍스트"),
  a(id="clickme", "클릭하면 입력한 텍스트가 출력됩니다."),
  textOutput("inputText")
)

server <- function(input, output, session) {
  onclick("clickme", {
    output$inputText = renderText({
      isolate(input$text)
    })
  })
}

shinyApp(ui, server)