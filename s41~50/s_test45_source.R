library(shiny)

myData = mtcars

ui <- fluidPage(
  actionButton("done", "완료"),
  verbatimTextOutput("txt")
)

server <- function(input, output, session) {
  output$txt = renderPrint({
    head(myData)
  })
  
  observeEvent(input$done, {
    k = lapply(myData, class)
    stopAppk(k)
  })
  
}

runGadget(shinyApp(ui, server))
