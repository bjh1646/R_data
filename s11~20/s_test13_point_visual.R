library(shiny)

ui <- fluidPage(
  plotOutput("myPlot")
)

server <- function(input, output, session) {
  output$myPlot = renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  })
}

shinyApp(ui, server)