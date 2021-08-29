library(shiny)
myData = mtcars

ui <- fluidPage(
  numericInput("sel", "mtcars 데이터 행의 개수 입력",
               value=6, min=6, max=nrow(myData)),
  tableOutput("carData")
)

server <- function(input, output, session) {
  #이 부분만 반응성
  output$carData = renderTable({
    head(myData, input$sel)
  })
  
  tryCatch({
    #반응성은 비반응성에 대입할 수 없음
    #대입하고자 하면 observer()함수 사용용
    x = input$sel
  }, error=function(c)cat(c$message))
  
}

shinyApp(ui, server)