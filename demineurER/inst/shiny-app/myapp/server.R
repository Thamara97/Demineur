library(shiny)

shinyServer(function(input, output, session) {
  # Initialize the timer, 10 seconds, not active.
  timer <- reactiveVal()
  active <- reactiveVal(FALSE)

  # Output du temps restant.
  output$timeleft <- renderText({
    paste("Time left: ", seconds_to_period(timer()))
  })

  # si le timer est active on avance par 1
  observe({
    invalidateLater(2000, session)
    isolate({
      if(active())
      {
        timer(timer()-1)
        if(timer()<1)
        {
          active(FALSE)
          showModal(modalDialog(
            title = "Message important",
            "Temps terminé 😕 !"
          ))
        }
      }
    })
  })

  # observers for actionbuttons
  observeEvent(input$start, {active(TRUE)})
  observeEvent(input$stop, {active(FALSE)})
  observeEvent(input$reset, {timer(input$seconds)
    })



  L <- reactive({
    input$ligne
    })

  C <- reactive({
    input$colonne
    })

#____________Afficher le tableau de jeu
  board <- eventReactive(input$reset, {
    matrix(1:(L() * C()), nrow = L(), ncol = C())
  })

  G <- eventReactive(input$reset, {
    grille(L(), C())
    })

  bombe <- eventReactive(input$reset, {
    nbr_bombe(G())
    })

  output$bombe <- renderText({
    paste("Il y a", bombe(), "💣")
    })

  values <- reactiveValues(n = 0, c = c())

  observeEvent(input$go, {
    values$n <- values$n + 1
    values$c[values$n] <- {
      input$case
    }
  })

  values1 <- reactiveValues(n1 = 0, c1 = c())
#__________la fonction du drapeau
  observeEvent(input$drap, {
    values1$n1 <- values1$n1 + 1
    values1$c1[values1$n1] <- {
      input$case
    }
  })


  acreuser <- reactive(a_creuser(G()))



  observeEvent(input$go, {

    acreuser <- a_creuser(G())
    B <- board()

    for (x in values$c) {
      B <- creuser(B, G(), x)
      }

    resultat <- gagne(values$c, acreuser, B)

    if (!(is.null(resultat))) {
      shinyalert(title = "Partie terminée", text = resultat)
    }
  })

  output$board <- renderTable({
    B <- board()
    for (y in values1$c1) {
      B <- drapeau(B, y)
    }
    for (x in values$c) {
      B <- creuser(B, G(), x)
    }
    return(B)
  }, colnames = FALSE, bordered = TRUE)

  observeEvent(input$reset, {
    values$n <- 0
    values$c <- c()
    values1$n1 <- 0
    values1$c1 <- c()
    })



})
