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
#'
creuser <- function(plateau, grille, case){

  L <- nrow(plateau)
  C <- nrow(plateau)

  x <- which(plateau==case, arr.ind = TRUE)[1]
  y <- which(plateau==case, arr.ind = TRUE)[2]

  nombre <- c("0️⃣","1️⃣","2️⃣","3️⃣","4️⃣"," 5️⃣", "6️⃣", "7️⃣","8️⃣")

  if (grille[case] != "💣") {

    plateau[case] <- nombre[(as.integer(grille[case])+1)]

    if (grille[case] == "0") {

      taille <- c(max(1,x-1), min(L,x+1), max(1,y-1), min(C, y+1))

      g <- grille[taille[1]:taille[2],taille[3]:taille[4]]
      p <- plateau[taille[1]:taille[2],taille[3]:taille[4]]

      L1 <- nrow(g)
      C1 <- ncol(g)

      for (i in 1:(C1 * L1)
           ) {if (g[i]=="0") {p[i] <- "0️⃣"}}

      plateau[taille[1]:taille[2] , taille[3]:taille[4]] <- p

    }

    return(plateau)

  }else {return(grille)}

}

#' Déposer ou enlever un drapeau dans une grille de démineur pour le mettre à la place des bombes
#'
#' @param plateau Un plateau de jeu
#' @param case Identifiant de la case où poser ou enlever le drapeau
#' @return Le plateau de jeu avec un drapeau sur la case sélectionner s'il n'y en avait pas au préalable et sans drapeau sinon.
#' @export
#'
drapeau <- function(plateau,case) {
  if(plateau[case] ==  paste0("🚩(",case,")")){plateau[case] <- case}
  else{plateau[case] <- paste0("🚩(",case,")")}

  return(plateau)
}



#' Liste des case sans bombes dans une grille de démineur
#'
#' @param grille Une grille de démineur
#' @return Un vecteur constitué l'identifiant des cases contenant des bombes dans la grille
#' @export
#'
a_creuser <- function(grille) {
  n <- 0
  position <- c()
  L <- nrow(grille)
  C <- ncol(grille)
  for (x in 1:(L*C)) {
    if (grille[x] != "💣") {
      n <- n+1
      position[n] <- x
    }
  }
  return(position)
}


#' Etat de la partie de démineur
#'
#' @param creuse Identifiant des cases creusées.
#' @param acreuser Identifiant des cases à creuser pour gagner la partie.
#' @return Une chaîne de caractère indiquant si la partie est gagnée, perdue ou toujours en cours.
#' @export
#'
gagne <- function(creuse, acreuser) {

  decouvert <- sapply(acreuser, function(x) {
    if (x %in% creuse) {TRUE}
    else {FALSE}})

  for (x in creuse) {if (!(x %in% acreuser)) {return("GAME OVER !")}}

  if (!(FALSE %in% decouvert)) {return("PARTIE GAGNEE ! Encore une ?")}

  else {return("A toi de jouer !")}
}
