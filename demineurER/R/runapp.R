#'@title Afficher le jeu
#' Lancer l'application shiny "demineurER"
#'
#'
#' @return Application shiny
#' @export
#' @examples
#' runapp()

runapp <- function(){

  appDir <- system.file("shiny-app","myapp",package = "demineurER")

  if (appDir == "") {
    stop("Impossible d'insérer l'application.Essayez d'installer 'demineurER'.",
         call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
