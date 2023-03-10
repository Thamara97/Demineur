library(shiny)

ui <- fluidPage(
  titlePanel("Démineur"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n_mines", "Nombre de mines :", min = 10, max = 50, value = 20),
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
    matrix(rep(" ", 100), ncol = 30, nrow = 30)
  })

  output$board <- renderTable({
    board()
  })

  observeEvent(input$reset, {
    board() <- matrix(rep(" ", 100), ncol = 20, nrow = 20)

  })
}

shinyApp(ui, server)
