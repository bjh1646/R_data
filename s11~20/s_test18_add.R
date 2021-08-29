library(shiny)

ui <- fluidPage(
  actionButton("add", "addUI")
)

server <- function(input, output, session) {
  observeEvent(input$add, {
    insertUI(
      select = "#add",
      where = "afterEnd",
      ui = textInput(paste0("txt", input$add),
                     "Insert some text")
    )
  })
}

shinyApp(ui, server)