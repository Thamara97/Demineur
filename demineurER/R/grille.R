grille <- function(L, C){

  # nombre de bombes
  nbombe <- L*C/4

  # positions des bombes
  positions <- cbind(sample(1:L, size = nbombe, replace = TRUE),
                     sample(1:C, size = nbombe, replace = TRUE))

  g <- matrix(0, nrow = L, ncol = C)

  # positionnement des bombes dans la g
  for (i in 1:nbombe) {
    g[positions[i,1], positions[i,2]] <-"bombe"
  }

  # positionnement des nombres dans l’intérieur de la g
  for (i in 2:(L-1)) {
    for (j in 2:(C-1)) {
      if (g[i,j] !="bombe") {
        g[i,j] <- sum(g[(i-1):(i+1),(j-1):(j+1)]=="bombe")
      }
    }
  }

  # positionnement des nombres sur les bords horizontaux
  for (j in 2:(C-1)) {
    if (g[1,j] !="bombe") {g[1,j] <- sum(g[1:2,(j-1):(j+1)]=="bombe")}
    if (g[L,j] !="bombe") {g[L,j] <- sum(g[(L-1):L,(j-1):(j+1)]=="bombe")}
  }

  # positionnement des nombres sur les bords verticaux
  for (i in 2:(L-1)) {
    if (g[i,1] !="bombe") {g[i,1] <- sum(g[(i-1):(i+1),1:2]=="bombe")}
    if (g[i,C] !="bombe") {g[i,C] <- sum(g[(i-1):(i+1),(C-1):C]=="bombe")}
  }

  # positionnement des nombres aux coins
  if (g[1,1] !="bombe") {g[1,1] <- sum(g[1:2,1:2]=="bombe")}
  if (g[L,C] !="bombe") {g[L,C] <- sum(g[(L-1):L,(C-1):C]=="bombe")}
  if (g[1,C] !="bombe") {g[1,C] <- sum(g[1:2,(C-1):C]=="bombe")}
  if (g[L,1] !="bombe") {g[L,1] <- sum(g[(L-1):L,1:2]=="bombe")}

  return(g)
}

plateau <- function(L, C){
  p <- matrix(".",nrow = L, ncol = C)
}

