#'@title Afficher le jeu
#' @description Cette fonction permet de lancer l'application shiny du package
#' "demineurER".
#'
#'
#' @return Application shiny "Démineur"
#' @export
#' @examples
#' runapp()

runapp <- function() {

  appDir <- system.file("shiny-app", "myapp", package = "demineurER")

  if (appDir == "") {
    stop("Impossible d'insérer l'application.Essayez d'installer 'demineurER'.",
         call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
