library(shiny)
library(shinyjs)

ui <- fluidPage(

  titlePanel("Démineur"),

  sidebarLayout(

    sidebarPanel(

      sliderInput("n_mines", "Nombre de mines :", min = 10, max = 100, value = 10),

      sliderInput('ligne', "Nombre de lignes :", 5, min = 4, max = 30),

      sliderInput('colonne', "Nombre de colonnes :", 5, min = 4, max = 30),

      actionButton("reset", "Nouvelle partie"),

      numericInput('case', "Case à creuser :", 1, min = 1, max = 30),

      actionButton("go","Creuser", icon = icon("trowel"))
    ),

    mainPanel(
      useShinyjs(),

      tableOutput("board0"),
      tableOutput("board1")
    )
  )
)

server <- function(input, output, session) {

  n_mines <- reactive({
    input$n_mines
  })

  L <- reactive({input$ligne})
  C <- reactive({input$colonne})

  board <- eventReactive(input$reset, {
    matrix(1:(L()*C()), nrow=L(), ncol=C())
  })

  G <- eventReactive(input$reset, {grille(L(), C(), n_mines())})

  output$board0 <- renderTable({
    board()
  }, colnames = FALSE)

  x <- eventReactive(input$go, {input$case})
  observeEvent(input$go, {
    hide("board0")
    show("board1")})

  output$board1 <- renderTable({
     creuser(board(), G(), x())
  },colnames = FALSE)

  observeEvent(input$reset, {
    hide("board1")
    show("board0")})

}

shinyApp(ui, server)
