library(shiny)

ui <- fluidPage(
  fileInput("selFile", "파일선택", buttonLabel = "파일선택"),
  tableOutput("tbl")
)

server <- function(input, output, session) {
  output$tbl = renderTable({
    req(input$selFile)
    input$selFile
  })
}

shinyApp(ui, server)