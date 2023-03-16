#' Creuse une case d'une grille de démineur
#'
#' @param plateau Un plateau de jeu de la même taille que la grille
#' @param grille Une grille de démineur
#' @param case L'identifiant de la case à creuser
#' @return Le plateau de jeu creusé à la case indiqué si ce n'est pas une bombe. La grille de jeu si la case creusée contient une bombe.
#' @examples
#' Grille <- grille(5,5)
#' Plateau <- matrix(1:(5*5), nrow = 5, ncol = 5)
#' creuser(Plateau, Grille, 4)
#' creuser(Plateau, Grille, 16)
#' @export

creuser <- function(plateau, grille, case){

  L <- nrow(plateau)
  C <- nrow(plateau)

  x <- which(plateau==case, arr.ind = TRUE)[1]
  y <- which(plateau==case, arr.ind = TRUE)[2]

  if (grille[case] != "💣") {

    plateau[case] <- paste0(grille[case],"b")

    if (grille[case] == "0") {

      taille <- c(max(1, x-1), min(L, x+1), max(1, y-1), min(C, y+1))

      g <- grille[taille[1]:taille[2] , taille[3]:taille[4]]
      p <- plateau[taille[1]:taille[2] , taille[3]:taille[4]]

      L1 <- nrow(g)
      C1 <- ncol(g)

      for (i in 1:(C1*L1)) {if (g[i]=="0") {p[i] <- paste0(g[i], "b")}}

      plateau[taille[1]:taille[2] , taille[3]:taille[4]] <- p

    }

    return(plateau)

  }

  else {return(grille)}

}

#' Déposer ou enlever un drapeau dans une grille de démineur
#'
#' @param plateau Un plateau de jeu
#' @param case Identifiant de la case où poser ou enlever le drapeau
#' @return Le plateau de jeu avec un drapeau sur la case sélectionner s'il n'y en avait pas au préalable et sans drapeau sinon.
#' @export

drapeau <- function(plateau,case){
  if(plateau[case]==  paste0("🏳(",case,")")){plateau[case] <- case}
  else{plateau[case] <- paste0("🏳(",case,")")}
  return(plateau)
}
