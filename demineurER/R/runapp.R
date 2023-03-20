#' @title Lancement de l'application
#' @description Cette fonction permet de lancer l'application shiny du package
#' "demineurER".
#' @return Application shiny "Démineur"
#' @examples
#' runapp()
#' @export

runapp <- function() {

  appDir <- system.file("shiny-app", "myapp", package = "demineurER")

  if (appDir == "") {
    stop("Impossible d'insérer l'application.Essayez d'installer 'demineurER'.",
         call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
