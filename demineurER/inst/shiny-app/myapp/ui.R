library(shiny)
library(shinyalert)

shinyUI(fluidPage(

  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: BLACK}")),
  tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {background: BLACK}")),

    #____Couleurs de l'arrière plan et des boutons cliquable
  tags$head(
    tags$style(HTML("
  body {background-color:#FF9933;}
                 #reset{color: white;
                 background-color: GREEN;}

                 #drap{color:green; background-color:   }
                  #go{color:red;background-color:white;}
                ")

    )),
  #Titre du jeu

  titlePanel("Démineur"),

  sidebarLayout(

    sidebarPanel(

      sliderInput("ligne", "Nombre de lignes :", 5, min = 4, max = 30),

      hr(),

      sliderInput('colonne', "Nombre de colonnes :", 5, min = 4, max = 30),
      #Boutton pour jouer
      actionButton("reset", "Nouvelle-partie"),

      hr(),
#_________________Boutton pour creuser
      numericInput('case', "Sélectionne une case :", 1, min = 1, max = 900),
      actionButton("go","Creuser", icon = icon("trowel")),
#___________________Drapeau
      actionButton("drap","🚩"),

    ),

    mainPanel(
      useShinyalert(),
      textOutput("rslt"),
      textOutput("bombe"),
      hr(),
      tableOutput("board")
    )
  )
))
