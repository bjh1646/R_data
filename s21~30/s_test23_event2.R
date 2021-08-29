library(shiny)

ui <- fluidPage(
  actionButton("do", "실행"),
  plotOutput("histo")
)

server <- function(input, output, session) {
  df = eventReactive(input$do, {
    rnorm(1000) })
    output$histo = renderPlot({
      hist(df())
    })
}

shinyApp(ui, server)