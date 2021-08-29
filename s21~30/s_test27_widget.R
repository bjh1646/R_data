library(shiny)
team = c("A","B","C")
members= letters[1:9]
years = as.integer(c(5,6,7,9,3,4,4,5,2))
team_members = data.frame(team=rep(team,c(4,3,2)), members, years)

ui <- fluidPage(
  h2("부서의 직원 선택"),
  selectInput("depart", "먼저 부서 선택하세요",
              c("A팀" ="A","B팀" ="B","C팀" ="C")),
  
  selectInput("inDepart", "다른 부서 직원을 선택하세요", choices=character(0)),
  textOutput("txt"),
  h2("직원명단"),
  tableOutput("tbl")
)

server <- function(input, output, session) {
  observe({
    x = team_members[team_members$team == input$depart, "members"]
    x = as.character(x)
    if(is.null(x))
      x = character(0)
    updateSelectInput(session, "inDepart",
                      choices=x
    )
  })  
  
  output$txt = renderText({
    member_years = team_members[team_members$members == input$inDepart, "years"]
    paste(input$depart,"팀의",
          input$inDepart, "직원의 경력",
          member_years, "년 입니다.", sep="")
  })
  
  output$tbl=renderTable({
    team_members
  })
}

shinyApp(ui, server)
