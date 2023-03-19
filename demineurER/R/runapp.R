#'@title Afficher le jeu
#' Lancer l'application shiny "demineurER"
#'
#'
#' @return Application shiny
#' @export
#' @examples
#' runapp()

<<<<<<< HEAD
runapp <- function() {

  appDir <- system.file("shiny-app", "myapp", package = "demineurER")

  if (appDir == "") {
=======
runapp <- function(){
  appDir <- system.file("shiny-app","myapp",package = "demineurER")
  if (appDir == "")
    {
>>>>>>> 6afaa377a9f486a1c2fed6bf97ab35809812b7fb
    stop("Impossible d'insérer l'application.Essayez d'installer 'demineurER'.",
         call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
