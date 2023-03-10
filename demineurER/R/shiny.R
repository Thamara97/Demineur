library(shiny)
library(shinyjs)

ui <- fluidPage(
  titlePanel("Démineur"),

  sidebarLayout(
<<<<<<< HEAD
    sidebarPanel(
      sliderInput("n_mines", "Nombre de mines :", min = 10, max = 50, value = 20),
      actionButton("reset", "Nouvelle partie")
=======

      sidebarPanel(

          sliderInput("n_mines", "Nombre de mines :", min = 10, max = 100, value = 10),

          sliderInput('ligne', "Nombre de lignes :", 5, min = 4, max = 30),

          sliderInput('colonne', "Nombre de colonnes :", 5, min = 4, max = 30),

          actionButton("reset", "Nouvelle partie"),

          numericInput('case', "Case à creuser :", 1, min = 1, max = 30),

          actionButton("go","Creuser", icon = icon("trowel"))
>>>>>>> 0366077c9386fe04974aa1da1313197c659608e3
    ),

    mainPanel(

      tableOutput("board0"),
      tableOutput("board1")
    )
 )
)

server <- function(input, output, session) {

  n_mines <- reactive({
    input$n_mines
  })

<<<<<<< HEAD
  board <- reactive({
    matrix(rep(" ", 100), ncol = 30, nrow = 30)
  })

  output$board <- renderTable({
    board()
  })

  observeEvent(input$reset, {
    board() <- matrix(rep(" ", 100), ncol = 20, nrow = 20)

  })
=======
  L <- reactive({input$ligne})
  C <- reactive({input$colonne})

  board <- eventReactive(input$reset, {
    matrix(1:(L()*C()), nrow=L(), ncol=C())
  })

  G <- eventReactive(input$reset, {grille(L(), C(), n_mines())})

  observeEvent(input$reset, {hide("board1")})

  output$board0 <- renderTable({
    board()
  }, colnames = FALSE)

  x <- eventReactive(input$go, {input$case})
  observeEvent(input$go, {hide("board0")})

  output$board1 <- renderTable({
    creuser(board(), G(), x())
  },colnames = FALSE)
>>>>>>> 0366077c9386fe04974aa1da1313197c659608e3
}

shinyApp(ui, server)
