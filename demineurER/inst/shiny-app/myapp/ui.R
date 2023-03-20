library(shiny)
library(shinyalert)
library(lubridate)

shinyUI(fluidPage(

  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge,
                  .js-irs-0 .irs-bar {background: BLACK}")),
  tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge,
                  .js-irs-1 .irs-bar {background: BLACK}")),

    #____Couleurs de l'arrière plan et des boutons cliquable
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

  #Titre du jeu
  titlePanel(HTML("<h1><center><font size=14> Démineur </font></center></h1>"),
             windowTitle = "Démineur"),

  sidebarLayout(

    sidebarPanel(

      sliderInput("ligne", "Nombre de lignes :", 5, min = 4, max = 30),

      hr(),


      sliderInput("colonne", "Nombre de colonnes :", 5, min = 4, max = 30),
      #Boutton pour jouer
      actionButton("reset", "Nouvelle partie"),

      hr(),

      #numericInput("seconds","secondes :",value=10,min=0,max=99999,step=10),
      "Chronomètre :",
      actionButton("start","Start"),
      actionButton("stop","Stop"),

      hr(),

      numericInput("case", "Sélectionne une case :", 1, min = 1, max = 900),
        #Bouton pour creuser
      actionButton("go", "Creuser", icon = icon("trowel")),
        #Drapeau
      actionButton("drap", "🚩")
    ),

    mainPanel(
      textOutput("bombe"),
      br(),
      textOutput("timeleft", inline = TRUE),
      hr(),
      tableOutput("board")
    )
  )
))
