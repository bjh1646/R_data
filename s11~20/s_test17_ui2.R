library(shiny)

ui <- fluidPage(
  titlePanel("표나 플롯중에서 선택하는 앱"),
  radioButtons("selected", label = "표시할 내용 선택", choices=list("table","plot")),
  uiOutput("tbl2"),
  uiOutput("plot2"),
)

server <- function(input, output, session) {
  output$tbl = renderTable({
    mtcars
  })
  output$tbl2 = renderUI({
    if(input$selected == "table") {
      tableOutput("tbl")
    }
  })
  
  
  output$plt = renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  })
  output$plot2 = renderUI({
    if(input$selected == "plot") {
      plotOutput("plt")
    }
  })
}

shinyApp(ui, server)