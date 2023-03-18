library(shiny)

shinyServer(function(input, output, session) {

  L <- reactive(
    {
    input$ligne
    })
  C <- reactive(
    {
    input$colonne
    })
  actionstart <- eventReactive(input$Nouvelle-partie, {
    mine_sweeper(input$ligne, input$colonne, input$reset)
  })

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
  }
  )

  values1 <- reactiveValues(n1 = 0, c1 = c())

  observeEvent(input$drap, {
    values1$n1 <- values1$n1 +1
    values1$c1[values1$n1] <- {input$case}
  })
  acreuser <- reactive(a_creuser(G()))
  resultat <- reactive(gagne(values$c, acreuser()))

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

})


