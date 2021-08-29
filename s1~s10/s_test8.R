library(shiny)

ui <- fluidPage(
  checkboxGroupInput("sels", "전공 언어(복수 선택 가능)",
                     c("C와 그 방언들", "Java", 
                       "JavaScripts", "R", "Perl")),
  verbatimTextOutput("langs")
)

server <- function(input, output, session) {
  output$langs = renderPrint({
    input$sels
  })
}

shinyApp(ui, server)