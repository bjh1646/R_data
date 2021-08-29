library(shiny)

ui <- fluidPage(
  radioButtons("dist", "Distribution type:",
               c("Normal" = "norm",
                 "Uniform" = "unif",
                 "Log-normal" = "lnom",
                 "Exponential" = "exp")),
  plotOutput("distPlot")
)

server <- function(input, output, session) {
  output$distPlot = renderPlot({
    dist = switch(input$dist,
                  norm=rnorm,
                  unif=runif,
                  lnorm=rlnorm,
                  exp=rexp,
                  rnorm)
    hist(dist(500))
  })
}

shinyApp(ui, server)
