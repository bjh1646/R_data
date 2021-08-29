library(shiny)

ui <- fluidPage(
  sliderInput("obs", "Number of observations", 0, 1000, 500),
  actionButton("goButton", "Go!"),
  plotOutput("disPlot")
)

server <- function(input, output, session) {
  output$disPlot = renderPlot({
    input$goButton
    
    dist = isolate(rnorm(input$obs))
    hist(dist)
  })
}

shinyApp(ui, server)