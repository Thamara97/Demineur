creuser <- function(plateau, grille, case){
  L <- nrow(plateau)
  C <- nrow(plateau)
  x <- case[1]
  y <- case[2]
  if (grille[x,y] != "bombe") {
    plateau[x, y] <- paste(grille[x,y], "bombe", sep="")
    return(plateau)
  }
  else {
    print('Partie perdue')
    return(grille)
  }
}
