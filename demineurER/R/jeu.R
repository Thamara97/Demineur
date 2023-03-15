creuser <- function(plateau, grille, case){

  L <- nrow(plateau)
  C <- nrow(plateau)

  x <- which(plateau==case, arr.ind = TRUE)[1]
  y <- which(plateau==case, arr.ind = TRUE)[2]

  if (grille[case] != "bombe") {

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


drapeau <- function(plateau,case){
  if(plateau[case]==  paste0("flag(",case,")")){plateau[case] <- case}
  else{plateau[case] <- paste0("flag(",case,")")}
  return(plateau)
}
