library(shiny)
#install.packages("miniUI")
library(miniUI)

myG(iris)
myG = function(myData) {
  ui <- fluidPage(
    gadgetTitleBar("연습장"),
    verbatimTextOutput("txt")
  )


  server <- function(input, output, session) {
    output$txt = renderPrint({
      head(myData)
    })
    
    observeEvent(input$done, {
      k = lapply(myData, class)
      stopApp(k)
    })
  }

  runGadget(shinyApp(ui, server))

}

