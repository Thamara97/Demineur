test_that("nbr_bombe", {
  Grille <- matrix(nrow = 6, ncol = 7)
  bombes <- c(1, 7, 8, 10, 19, 28, 33)
  for (x in bombes) {
    Grille[x] <- "💣"
  }
  expect_equal(nbr_bombe(Grille), length(bombes))
})
