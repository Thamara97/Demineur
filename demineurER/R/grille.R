g <- function(L, C){

  # nombre de bombes
  nbombe <- L*C/4

  # positions des bombes
  positions <- cbind(sample(1:L, size = nbombe, replace = TRUE),
                     sample(1:C, size = nbombe, replace = TRUE))

  grille <- matrix(0, nrow = L, ncol = C)

  # positionnement des bombes dans la grille
  for (i in 1:nbombe) {
    grille[positions[i,1], positions[i,2]] <- -1
  }

  # positionnement des nombres dans l’intérieur de la grille
  for (i in 2:(L-1)) {
    for (j in 2:(C-1)) {
      if (grille[i,j] != -1) {
        grille[i,j] <- sum(grille[(i-1):(i+1),(j-1):(j+1)]==-1)
      }
    }
  }

  # positionnement des nombres sur les bords horizontaux
  for (j in 2:(C-1)) {
    if (grille[1,j] != -1) {grille[1,j] <- sum(grille[1:2,(j-1):(j+1)]==-1)}
    if (grille[L,j] != -1) {grille[L,j] <- sum(grille[(L-1):L,(j-1):(j+1)]==-1)}
  }

  # positionnement des nombres sur les bords verticaux
  for (i in 2:(L-1)) {
    if (grille[i,1] != -1) {grille[i,1] <- sum(grille[(i-1):(i+1),1:2]==-1)}
    if (grille[i,C] != -1) {grille[i,C] <- sum(grille[(i-1):(i+1),(C-1):C]==-1)}
  }

  # positionnement des nombres aux coins
  if (grille[1,1] != -1) {grille[1,1] <- sum(grille[1:2,1:2]==-1)}
  if (grille[L,C] != -1) {grille[L,C] <- sum(grille[(L-1):L,(C-1):C]==-1)}
  if (grille[1,C] != -1) {grille[1,C] <- sum(grille[1:2,(C-1):C]==-1)}
  if (grille[L,1] != -1) {grille[L,1] <- sum(grille[(L-1):L,1:2]==-1)}

  return(grille)
}


