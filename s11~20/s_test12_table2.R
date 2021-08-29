library(dplyr)
library(reshape)
library(shiny)
ui <- fluidPage(
  fluidRow(
    column(12,
           dataTableOutput('table')
           )
  )
)

server <- function(input, output, session) {
  output$table = renderDataTable(iris,
                                 options = list(
                                   pageLength=5,
                                   initComplete=I("function(settings,json) {alert('Done.');}")))
}


shinyApp(ui, server)