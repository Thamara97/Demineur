library(shiny)

shinyUI(fluidPage(
  #____Couleurs de l'arrière plan et des boutons cliquable
  tags$head(
    tags$style(HTML("
  body {background-color:#FFCCFF;}
                 #reset{color: white;
                 background-color: #0000FF;}

                 #drap{color:green; background-color:yellow}
                  #go{color:red;background-color:white;
                ")

    )),
  #Titre du jeu

  titlePanel("Démineur"),

  sidebarLayout(

    sidebarPanel(

      sliderInput("ligne", "Nombre de lignes :", 5, min = 4, max = 30),

<<<<<<< HEAD
      sliderInput("colonne", "Nombre de colonnes :", 5, min = 4, max = 30),

      actionButton("reset", "Nouvelle partie"),

      hr(),

      numericInput("case", "Sélectionne une case :", 1, min = 1, max = 900),

      actionButton("go", "Creuser", icon = icon("trowel")),
      actionButton("drap", "🚩"),
=======
      sliderInput('colonne', "Nombre de colonnes :", 5, min = 4, max = 30),
#__________Boutton pour jouer
      actionButton("reset", "Nouvelle-partie"),

      hr(),
#_________________Boutton pour creuser
      numericInput('case', "Sélectionne une case :", 1, min = 1, max = 900),
      actionButton("go","Creuser", icon = icon("trowel")),
#___________________Drapeau
      actionButton("drap","🚩"),
>>>>>>> 6afaa377a9f486a1c2fed6bf97ab35809812b7fb

    ),

    mainPanel(
      textOutput("rslt"),
      textOutput("bombe"),
      hr(),
      tableOutput("board")
    )
  )
))
