library(shiny)

ui <- shinyUI(basicPage(
  plotOutput('plot', width = "300px", height = "300px"),
  actionButton('ggplot', 'Go plot')
)
  
)

server <- function(input, output, session) {
  output$plot = renderPlot({
    input$goPlot
    
    dat = data.frame(x=numeric(0), y=numeric(0))
    
    withProgress(message = 'Makingplot', value = 0, {
      n = 10
      
      for(i in 1:n) {
        dat = rbind(dat, data.frame(x=rnorm(1), y=rnorm(1)))
        incProgress(1/n, detail = paste("Doingpart", i))
        Sys.sleep(0.1)
      }
    })
    plot(dat$x, dat$y)
  })
}

shinyApp(ui, server)