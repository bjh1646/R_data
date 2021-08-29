library(shiny)

ui <- fluidPage(
  h2(textOutput("txt")),
  verbatimTextOutput("sum1")
)

server <- function(input, output, session) {
  output$txt = renderText({
    "mtcars를 사용한 회귀분석"
  })
  
  output$sum1 = renderPrint({
    summary(lm(mpg~wt + qsec, data=mtcars))
  })
}

shinyApp(ui, server)