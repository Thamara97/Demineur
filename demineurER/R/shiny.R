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

      actionButton("go","Creuser", icon = icon("trowel")),
      actionButton("drap","flag 🏳")
    ),

    mainPanel(
      useShinyjs(),
      tableOutput("board0"),
      tableOutput("board1"),
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

  values <- reactiveValues(n = 0, c = c())

  observeEvent(input$go, {
    values$c[values$n] <- {input$case}
    values$n <- values$n +1
    hide("board0")
    show("board1")
  })

  output$board1 <- renderTable({
    B <- board()
    for (x in values$c) {
      B <- creuser(B, G(), x)
    }
    return(B)
  },colnames = FALSE)

  observeEvent(input$reset, {
    hide("board1")
    show("board0")
    values$n <- 0
    values$c <- c()})

}

shinyApp(ui, server)
