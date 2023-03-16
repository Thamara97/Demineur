library(shiny)
library(shinyjs)

ui <- fluidPage(
  tags$head(
  tags$style(HTML("
  body {background-color:grey;}
                 #reset{color: white;
                 background-color:green;}

                 #drap{color:green; background-color:yellow;}
                  #go{color:green;background-color:white;")

  )),

  titlePanel("Démineur"),

  sidebarLayout(

    sidebarPanel(

      sliderInput('ligne', "Nombre de lignes :", 5, min = 4, max = 30),

      sliderInput('colonne', "Nombre de colonnes :", 5, min = 4, max = 30),

      actionButton("reset", "Nouvelle partie"),

      numericInput('case', "Case à creuser :", 1, min = 1, max = 900),

      actionButton("go","Creuser", icon = icon("trowel")),
      actionButton("drap","🚩"),
      textOutput("text")
    ),

    mainPanel(
      useShinyjs(),
      tableOutput("board0"),
      tableOutput("board1")
    )
  )
)

server <- function(input, output, session) {

  L <- reactive({input$ligne})
  C <- reactive({input$colonne})

  board <- eventReactive(input$reset, {
    matrix(1:(L()*C()), nrow=L(), ncol=C())
  })

  G <- eventReactive(input$reset, {grille(L(), C())})

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

  values1 <- reactiveValues(n1 = 0, c1 = c())
  observeEvent(input$drap, {
    values1$c1[values1$n1] <- {input$case}
    values1$n1 <- values1$n1 +1
  })

  output$board1 <- renderTable({
    B <- board()
    for (x in values$c) {
      B <- creuser(B, G(), x)
    }
    for (y in values1$c1) {
      B <- drapeau(B,y)
      }
    return(B)
  },colnames = FALSE)

  observeEvent(input$reset, {
    hide("board1")
    show("board0")
    values$n <- 0
    values$c <- c()})

  bombe <- eventReactive(input$reset, {nbr_bombe(G())})

  output$text <- renderText({paste0("Il y a ", bombe(), " bombes")})
}

shinyApp(ui, server)
