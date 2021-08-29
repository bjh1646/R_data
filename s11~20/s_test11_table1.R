library(shiny)
library(broom)

ui <- fluidPage(
  h2(textOutput("txt")),
  tableOutput("tab1")
)

server <- function(input, output, session) {
  output$txt = renderText({
    "mtcars를 사용한 회귀 분석"
  })
  output$tab1 = renderTable({
    tidy(lm(mpg~wt + qsec, data=mtcars))
  }, striped = TRUE, hover = TRUE, bordered = TRUE)
}

shinyApp(ui, server)

iris
