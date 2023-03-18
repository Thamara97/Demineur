#' Créér une grille du jeu démineur
#'
#' @param L le nombre de ligne
#' @param C le nombre de colonne
#' @return Une matrice à L lignes, C colonnes
#' @example
#' grille(5,6)
#' @export


grille <- function(L, C) {

  nbr_bombe <- L * C / 5

  # positions des bombes
  positions <- cbind(sample(1:L, size = nbr_bombe, replace = TRUE),
                     sample(1:C, size = nbr_bombe, replace = TRUE))

  g <- matrix(0, nrow = L, ncol = C)

  # positionnement des bombes dans la grille
  for (i in 1:nbr_bombe) {
    g[positions[i, 1], positions[i, 2]] <-"💣"
  }

  # positionnement des nombres dans l'intérieure de la grille
  for (i in 1:(L)) {
    l1 <- max(c(i - 1, 1))
    l2 <- min(c(i + 1, L))
    for (j in 1:(C)) {
      c1 <- max(c(j-1, 1))
      c2 <- min(c(j + 1, C))
      if (g[i, j] != "💣") {
        g[i, j] <- sum(g[l1:l2, c1:c2] == "💣")
      }
    }
  }

  return(g)
}

#' Compte le nombre de bombe dans une grille de démineur
#'
#' @param grille Une grille de démineur
#' @return Le nombre de bombe dans la grille de démineur et leur position
#' @examples
#' Grille <- grille(5,5)
#' nbr_bombe(Grille)
#' @export

nbr_bombe <- function(grille) {
  return(sum(grille == "💣"))
}
