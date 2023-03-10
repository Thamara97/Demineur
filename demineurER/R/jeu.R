creuser <- function(plateau, grille, case){
  L <- nrow(plateau)
  C <- nrow(plateau)
  if (grille[case] != "bombe") {
    plateau[case] <- paste(grille[case], "bombe", sep="")
    return(plateau)
  }
  else {
    return(grille)
  }
}
