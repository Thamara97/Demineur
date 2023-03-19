test_that("Jeu fonctionne", {
  G <- grille(4,9)
  P <- matrix(1:(4*9), nrow = 4, ncol = 9)
  x <- sample(1:(4*9), 1)
  creuse <- x
  acreuser <- a_creuser(G)
  resultat <- c("BRAVO TU A GAGNEE. Tu veux encore jouer?", "GAME OVER !")
  while ((gagne(creuse, acreuser, P) %in% resultat) == FALSE) {
    P <- creuser(P, G, x)
    x <- sample(1:(4*9), 1)
  }
  if (gagne(creuse, acreuser, P) == resultat[1]) {
    P
    resultat[1]
  } else {
    G
    resultat[2]
  }
})
