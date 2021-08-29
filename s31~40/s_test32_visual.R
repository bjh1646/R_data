library(shiny)
library(ggplot2)
mtcars2 = mtcars[,c("mpg", "cyl", "wt")]

ui <- fillPage(
  fillRow(
    fillCol(
      plotOutput("plot1", brush = brushOpts(id = "plot1_brush"), height = "100%"),
      plotOutput("plot2", height = "100%")
    ),
    fillCol(
      tableOutput("tbl")
    )    )   )

server <- function(input, output, session) {
  
  selectedData = reactive({
    data = brushedPoints(mtcars2, input$plot1_brush)
    if(nrow(data) == 0)
      data = mtcars2
    data    })
  
  output$plot1 = renderPlot({
    ggplot(mtcars2, aes(wt, mpg)) + geom_point()     })  
  
  output$plot2 = renderPlot({
    ggplot(selectedData(), aes(factor(cyl), mpg)) + geom_boxplot()
  })  
  
  output$tbl = renderTable({
    selectedData()    })
}

shinyApp(ui, server)