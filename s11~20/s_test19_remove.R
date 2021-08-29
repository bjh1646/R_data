library(shiny)

ui <- fluidPage(
  actionButton("rmv", "RemoveUI"),
  textInput("txt", "This is no longer useful")
)

server <- function(input, output, session) {
  observeEvent(input$rmv, {
    removeUI(
      selector = "div:has(> #txt)"  #txt 전체를 선택하기 위함
    )
  })
}

shinyApp(ui, server)