#' @title Creuser une grille de démineur
#' @description  Cette fonction creuse une case d'une grille de démineur
#'
#' @param plateau Un plateau de jeu de la même taille que la grille
#' @param grille Une grille de démineur
#' @param case L'identifiant de la case à creuser
#' @return Le plateau de jeu creusé à la case indiqué si ce n'est pas une bombe.
#' La grille de jeu si la case creusée contient une bombe.
#' @examples
#' Grille <- grille(5,5)
#' Plateau <- matrix(1:(5*5), nrow = 5, ncol = 5)
#' creuser(Plateau, Grille, 4)
#' creuser(Plateau, Grille, 16)
#' @export
#'
creuser <- function(plateau, grille, case) {

  L <- nrow(plateau)
  C <- nrow(plateau)

  if (case %% L == 0) {
    x <- L
    y <- case %/% L
  } else {
    x <- case %% L
    y <- case %/% L + 1
  }
  # x <- which(plateau == case, arr.ind = TRUE)[1]
  # y <- which(plateau == case, arr.ind = TRUE)[2]

  nombre <- c("0️⃣", "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣")

  if (grille[case] != "💣") {

    plateau[case] <- nombre[(as.integer(grille[case]) + 1)]

    if (grille[case] == "0") {

      grille1 <- grille[max(1, x - 1):min(L, x + 1),
                        max(1, y - 1):min(C, y + 1)]
      plateau1 <- plateau[max(1, x - 1):min(L, x + 1),
                          max(1, y - 1):min(C, y + 1)]

      L1 <- nrow(grille1)
      C1 <- ncol(grille1)

      for (i in 1:(C1 * L1)) {
        if (grille1[i] != "💣" && !(grepl("🚩", plateau1[i], fixed = TRUE))) {
        plateau1[i] <- nombre[(as.integer(grille1[i]) + 1)]
        }
      }

      plateau[max(1, x - 1):min(L, x + 1),
              max(1, y - 1):min(C, y + 1)] <- plateau1

    }

    return(plateau)

  } else {
    return(grille)
    }

}

#' @title Poser/enlever un drapeau
#' @description Cette fonction permet de déposer ou d'enlever un drapeau dans
#' une grille de démineur.
#'
#' @param plateau Plateau de jeu (un matrice de même dimension que la grille
#' de démineur)
#' @param case Identifiant de la case où poser ou enlever le drapeau
#' @return Le plateau de jeu avec un drapeau sur la case sélectionner
#' s'il n'y en avait pas au préalable et sans drapeau sinon.
#' @export
#'
drapeau <- function(plateau, case) {

  if (plateau[case] ==  paste0("🚩(", case, ")")) {
    plateau[case] <- case
    } else {
    plateau[case] <- paste0("🚩(", case, ")")
    }

  return(plateau)
}



#' @title Case à creuser dans une grille démineur
#' @description Liste des identifiants de toutes les cases sans bombes dans une grille de
#' démineur.
#'
#' @param grille Grille de démineur (matrice contenant des bombes)
#' @return Un vecteur constitué l'identifiant des cases contenant des bombes
#' dans la grille
#' @examples
#' g1 <- grille(4,6)
#' a_creuser(g1)
#' g2 <- grille(10,10)
#' a_creuser(g2)
#' @export
#'
a_creuser <- function(grille) {

  n <- 0
  position <- c()
  L <- nrow(grille)
  C <- ncol(grille)

  for (x in 1:(L * C)) {
    if (grille[x] != "💣") {
      n <- n + 1
      position[n] <- x
    }
  }

  return(position)
}


#' @title Afficher la victoire ou l'échec
#' @description Cette fonction indique si la partie est gagnée ou perdue.
#'
#' @param creuse Identifiant des cases déjà creusées.
#' @param acreuser Identifiant de toutes les cases sans bombes.
#' @return Une chaîne de caractère indiquant si la partie est gagnée,
#' ou perdue.
#' @examples
#' G <- grille(8,9)
#' acreuser <- a_creuser(G)
#' creuse <- c(4,2,15,6,9,20)
#' gagne(creuse, acreuser)
#' @export
#'
gagne <- function(creuse, acreuser, plateau) {

  nombre <- c("0️⃣", "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣")

  decouvert <- c()

  for (x in acreuser) {
    if (plateau[x] %in% nombre) {
    decouvert <- c(decouvert, TRUE)
    } else {
      decouvert <- c(decouvert, FALSE)
    }
  }

  if (!(FALSE %in% decouvert)) {
    return("EXCELLENT 🎉  . Tu veux encore jouer?")
  }

  for (x in creuse) {
    if (!(x %in% acreuser)) {
      return("GAME OVER !")
    }
  }

}

