creuser <- function(plateau, grille, case){

  L <- nrow(plateau)
  C <- nrow(plateau)

  if (grille[case] != "bombe") {
    plateau[case] <- paste(grille[case], "bombe", sep="")
    if (grille[case] == "0") {plateau <-  astuce(plateau, grille, case)}
    return(plateau)
  }

  else {
    return(grille)
  }

}

astuce <- function(plateau, grille, case) {

  L <- nrow(plateau)
  C <- ncol(plateau)

  if (case-1 > 0) {if (grille[case-1]=="0") {plateau[case-1] <- "0bombe"}}
  if (case+1 < L*C+1) {if (grille[case+1]=="0") {plateau[case+1] <- "0bombe"}}
  if (case-L > 0) {if (grille[case-L]=="0") {plateau[case-L] <- "0bombe"}}
  if (case+L < L*C+1) {if (grille[case+L]=="0") {plateau[case+L] <- "0bombe"}}
  if (case+L+1 < L*C+1) {if (grille[case+L+1]=="0") {plateau[case+L+1] <- "0bombe"}}
  if (case+L-1 < L*C+1) {if (grille[case+L-1]=="0") {plateau[case+L-1] <- "0bombe"}}
  if (case-L+1 > 0) {if (grille[case-L+1]=="0") {plateau[case-L+1] <- "0bombe"}}
  if (case-L-1 > 0) {if (grille[case-L-1]=="0") {plateau[case-L-1] <- "0bombe"}}

  return(plateau)
}
