library(shiny)

shinyUI(fluidPage(
  tags$head(
    tags$style(HTML("
  body {background-color:#FFCCFF;}
                 #reset{color: white;
                 background-color: #0000FF;}

                 #drap{color:green; background-color:yellow}
                  #go{color:red;background-color:white;
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

    ),

    mainPanel(
      textOutput("rslt"),
      textOutput("bombe"),
      hr(),
      tableOutput("board")
    )
  )
))
