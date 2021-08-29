library(shiny)

ui <- fluidPage(
  useShinyjs(),
  textInput("text", "텍스트"),
  actionButton("btn", "클릭"),
  textOutput("inputText")
)

server <- function(input, output, session) {
  observe({
    if(is.null(input$text) || input$text == "") {
      disable("btn")
    } else {
      enable("btn")
    }
  })
  
  observeEvent(input$btn, {
    output$inputText = renderText({
      isolate(input$text)
    })
  })
  
}

shinyApp(ui, server)