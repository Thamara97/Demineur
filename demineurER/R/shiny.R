library(shiny)
library(shinyjs)

ui <- fluidPage(
  tags$head(
  tags$style(HTML("
  body {background-color:#CCFFFF;}
                 #reset{color: white;
                 background-color: orange;}

                 #drap{color:green; background-color:green;}
                  #go{color:green;background-color:white;
                ")

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
      textOutput("bombe")
    ),

    mainPanel(
      textOutput("rslt"),
      hr(),
      tableOutput("board")
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

  bombe <- eventReactive(input$reset, {nbr_bombe(G())})

  output$bombe <- renderText({paste("Il y a", bombe(), "💣")})

  values <- reactiveValues(n = 0, c = c())

  observeEvent(input$go, {
    values$n <- values$n +1
    values$c[values$n] <- {input$case}
  })

  values1 <- reactiveValues(n1 = 0, c1 = c())

  observeEvent(input$drap, {
    values1$n1 <- values1$n1 +1
    values1$c1[values1$n1] <- {input$case}
  })

  resultat <- reactive(gagne(values$c, a_creuser(G())))

  output$rslt <- renderText(resultat())

  output$board <- renderTable({
    B <- board()
    for (y in values1$c1) {
      B <- drapeau(B,y)
    }
    for (x in values$c) {
      B <- creuser(B, G(), x)
    }
    return(B)
  },colnames = FALSE)

  observeEvent(input$reset, {
    values$n <- 0
    values$c <- c()
    values1$n1 <- 0
    values1$c1 <- c()})

}

shinyApp(ui, server)
