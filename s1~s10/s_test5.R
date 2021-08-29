library(shiny)

ui <- fluidPage(
  passwordInput("password", "패스워드")
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
