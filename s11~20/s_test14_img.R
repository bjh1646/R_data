library(shiny)

ui <- fluidPage(
  fluidRow(
    column(3,
           img(src="rlogo.png", width="100%")),
    column(9,
           sliderInput("obs", "No. of Random Number", 
                       min = 30, max = 100, value = 50, width = "100%"),
           plotOutput("myPlot", width = "100%"))
  )
)

server <- function(input, output, session) {
  output$myPlot = renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)