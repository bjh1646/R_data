library(shiny)

ui <- fluidPage(
  h2("인터렉티브 플롯의 기본"),
  plotOutput("plot1", brush = "brushed_area"),
  h3("클릭한 위치 정보"),
  p(verbatimTextOutput("event_info"))
)

server <- function(input, output, session) {
  output$plot1 = renderPlot({
    x = mtcars$wt
    y = mtcars$mpg
    plot(x,y)
  })
  
  output$event_info = renderText({
    paste("xmin:", input$brushed_area$xmin, 
          "ymin:", input$brushed_area$ymin,
          "\nxmax:", input$brushed_area$xmax, 
          "ymax:", input$brushed_area$ymax)
  })
  
}

shinyApp(ui, server)