library(shiny)

ui <- fluidPage(
  titlePanel("Démineur"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n_mines", "Nombre de mines :", min = 10, max = 100, value = 30),
      actionButton("reset", "Nouvelle partie")
    ),
    mainPanel(
      tableOutput("board")
    )
  )
)

server <- function(input, output, session) {
  n_mines <- reactive({
    input$n_mines
  })
  
  board <- reactive({
    matrix(rep(" ", 100), ncol = 10, nrow = 10)
  })
  
  output$board <- renderTable({
    board()
  })
  
  observeEvent(input$reset, {
    board() <- matrix(rep(" ", 100), ncol = 10, nrow = 10)
  })
}
shinyApp(ui, server)
