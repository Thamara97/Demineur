#' @title Grille de démineur
#' @description Cette fonction créé une matrice d'un nombre de lignes et de
#' colonnes données contenant des bombes et le nombre de bombes autour de
#' chaque case vide.
#' @param L (Entier) Le nombre de lignes.
#' @param C (Entier) Le nombre de colonnes.
#' @return Une matrice à L lignes, C colonnes
#' @examples
#' grille(5,6)
#' grille(9,7)
#' @export

grille <- function(L, C) {

  nbr_bombe <- L * C / 5

  positions <- cbind(sample(1:L, size = nbr_bombe, replace = TRUE),
                     sample(1:C, size = nbr_bombe, replace = TRUE))

  g <- matrix(0, nrow = L, ncol = C)

  for (i in 1:nbr_bombe) {
    g[positions[i, 1], positions[i, 2]] <- "💣"
  }

  for (i in 1:(L)) {

    l1 <- max(c(i - 1, 1))
    l2 <- min(c(i + 1, L))

    for (j in 1:(C)) {

      c1 <- max(c(j - 1, 1))
      c2 <- min(c(j + 1, C))

      if (g[i, j] != "💣") {
        g[i, j] <- sum(g[l1:l2, c1:c2] == "💣")
      }
    }
  }

  return(g)
}

#' @title Nombre de bombe
#' @description Cette fonction compte le nombre de bombe dans une grille de
#' démineur créée avec la fonction grille.
#' @param grille (Matrice) Une grille de démineur
#' @return Le nombre de bombe dans la grille de démineur.
#' @examples
#' Grille <- grille(5,5)
#' nbr_bombe(Grille)
#' @export

nbr_bombe <- function(grille) {

  return(sum(grille == "💣", na.rm = TRUE))

}
