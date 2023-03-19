test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

G <- grille(4,9)
P <- matrix(1:(4*9), nrow = 4, ncol = 9)
P <- creuser(P, G, 4)
creuse <- sample(1:(4*9), 16)
for (x in creuse) {
  P <- creuser(P, G, x)
}
P
