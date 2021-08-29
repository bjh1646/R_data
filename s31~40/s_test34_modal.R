shinyApp(
  ui=basicPage(
    actionButton("show", "Show Modal dialog")
  ),
  
  server = function(input, output) {
    observeEvent(input$show, {
      showModal(modalDialog(
        title = "Important message",
        "This is an important message!"
      ))
    })
  }
  
)
