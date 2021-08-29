library(shiny)

ui <- fluidPage(
  h2("인터렉티브 플롯의 기본"),
  plotOutput("plot1", brush = "brushed_point"),
  h3("선택영역안에있는 데이터셋"),
  p(verbatimTextOutput("event_info"))
)

server <- function(input, output, session) {
  output$plot1 = renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  })
  
  output$event_info = renderPrint({
    brushedPoints(mtcars, input$brushed_point, xvar = "wt", yvar = "mpg")
  })
  
}

shinyApp(ui, server)