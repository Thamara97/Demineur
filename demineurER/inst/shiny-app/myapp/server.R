shinyServer(function(input, output, session) {

  # Création du chronomètre
  timer <- reactiveVal()
  active <- reactiveVal(FALSE)

  # Output du temps écoulé
  output$timeleft <- renderText({paste("Temps écoulé : ",
                                       seconds_to_period(timer()))
  })

  # Si le chronomètre est activé on avance de 1
  observe({

    invalidateLater(2000, session)

    isolate({
      if (active()) {
        timer(timer() + 1)
      }
    })
  })

  # Activation / désactivation / initialisation du chronomètre
  observeEvent(input$start, {
    active(TRUE)
    })

  observeEvent(input$stop, {
    active(FALSE)
    })

  observeEvent(input$reset, {
    timer(0)
    })

  # Taille de la grille
  L <- reactive({
    input$ligne
    })

  C <- reactive({
    input$colonne
    })

  # Création du plateau de jeu
  board <- eventReactive(input$reset, {
    matrix(1:(L() * C()), nrow = L(), ncol = C())
  })

  # Création de la grille de jeu
  G <- eventReactive(input$reset, {
    grille(L(), C())
    })

  # Indication du nombre de bombe
  bombe <- eventReactive(input$reset, {
    nbr_bombe(G())
    })

  output$bombe <- renderText({
    paste("Il y a", bombe(), "💣")
    })

  # Cases creusées
  values <- reactiveValues(n = 0, c = c())

  observeEvent(input$go, {
    values$n <- values$n + 1
    values$c[values$n] <- {
      input$case
    }
  })

  # Cases avec/sans drapeau
  values1 <- reactiveValues(n1 = 0, c1 = c())

  observeEvent(input$drap, {
    values1$n1 <- values1$n1 + 1
    values1$c1[values1$n1] <- {
      input$case
    }
  })

  # Annonce de la victoire/défaite et du temps de jeu
  acreuser <- reactive(a_creuser(G()))

  observeEvent(input$go, {

    acreuser <- a_creuser(G())
    B <- board()

    for (x in values$c) {
      B <- creuser(B, G(), x)
      }

    resultat <- gagne(values$c, acreuser, B)

    if (!(is.null(resultat))) {
      active(FALSE)
      shinyalert(title = "Partie terminée !",
                 text = paste0(resultat, "\n Temps de jeu : ", timer(),
                               " secondes"))
    }
  })

  # Output du plateau creusé
  output$board <- renderTable({

    B <- board()

    for (y in values1$c1) {
      B <- drapeau(B, y)
    }

    for (x in values$c) {
      B <- creuser(B, G(), x)
    }

    return(B)

  }, colnames = FALSE, bordered = TRUE, align = "c")

  # Réinitialisation
  observeEvent(input$reset, {
    values$n <- 0
    values$c <- c()
    values1$n1 <- 0
    values1$c1 <- c()
    })
})
