library(shiny)
library(shinyjs)


ui <- fluidPage(
  useShinyjs(),
  h2("연습장"),
  actionButton("btn", "클릭"),
  p(id="myPara", "이 문장을 새로운 문장으로 바꿉니다.")
)

server <- function(input, output, session) {
  observeEvent(input$btn, {
    html("myPara", "이것은 교체된 문장입니다.")
  })
}

shinyApp(ui, server)