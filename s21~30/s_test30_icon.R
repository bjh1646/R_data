library(shiny)

ui <- navbarPage(
  "아이콘실습", theme = shinythemes::shinytheme("united"),
  tabPanel("플롯", icon=icon("bar-chart-o")),
  tabPanel("정리", icon=icon("bar-alt")),
  tabPanel("표", icon=icon("table"),
    actionButton("btn", "뷰업데이트", icon=icon("refresh")))
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)