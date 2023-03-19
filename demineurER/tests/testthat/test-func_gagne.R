test_that("Victoire", {
  G <- grille(5,5)
  acreuser <- a_creuser(G)
  expect_equal(gagne(acreuser, acreuser), "BRAVO TU A GAGNEE. Tu veux encore jouer?")
})

test_that("Défaite", {
  G <- grille(5,5)
  acreuser <- a_creuser(G)
  expect_equal(gagne(c(1,2,26), acreuser), "GAME OVER !")
})

test_that("Partie en cours", {
  G <- grille(5,5)
  acreuser <- a_creuser(G)
  expect_equal(gagne(acreuser[1], acreuser), "A toi de jouer !")
})
