library(shiny)
library(shinyalert)
library(lubridate)

shinyUI(fluidPage(

  # Couleur des slider
  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge,
                  .js-irs-0 .irs-bar {background: BLACK}")),
  tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge,
                  .js-irs-1 .irs-bar {background: BLACK}")),

  # Couleurs de l'arrière plan et des boutons cliquables
  tags$head(
    tags$style(HTML("
  body {background-color:#FF9933;}
                 #reset{color: white;
                 background-color: GREEN;}

                 #drap{color:green; background-color:   }
                  #go{color:red;background-color:white;}
                  #stop{color:green;}
                  #start{color:green;}
                ")
    )
  ),

  # Titre de la page
  titlePanel(HTML("<h1><center><font size=14> Démineur </font></center></h1>"),
             windowTitle = "Démineur"),

  sidebarLayout(

    sidebarPanel(

      width = 3,

      sliderInput("ligne", "Nombre de lignes :", 5, min = 4, max = 30),

      hr(),

      sliderInput("colonne", "Nombre de colonnes :", 5, min = 4, max = 30),

      # Bouton pour lancer une nouvelle partie
      actionButton("reset", "Nouvelle partie"),

      hr(),

      # Boutons pour lancer ou arrêter le chronomètre
      "Chronomètre :",
      actionButton("start", "Start"),
      actionButton("stop", "Stop"),

      hr(),

      # Identifiant de la case
      numericInput("case", "Sélectionne une case :", 1, min = 1, max = 900),

      # Bouton pour creuser
      actionButton("go", "Creuser", icon = icon("trowel")),

      # Bouton pour poser/enlever un drapeau
      actionButton("drap", "🚩")
    ),

    mainPanel(

      # Indication du nombre de bombe et du temps écoulé
      fluidRow(column(2, textOutput("bombe")),
               column(2, textOutput("timeleft"), offset = 7)),

      hr(),

      # Affichage du plateau de jeu
      align = "center",
      tableOutput("board")
    )
  )
))
