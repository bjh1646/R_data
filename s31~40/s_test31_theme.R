library(shiny)

ui <- navbarPage(
  "United", 
  theme = shinythemes::shinytheme("united"),
  tabPanel("Plot", "Plot tab contents..."),
  navbarMenu("More",
             tabPanel("summary", "summary tab contenets..."),
             tabPanel("Table", "Table tab contents...")
             )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)