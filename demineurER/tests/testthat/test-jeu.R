test_that("Fonction creuser", {
  G <- grille(6, 9)
  P <- matrix(1:(6 * 9), nrow = 6, ncol = 9)
  P <- creuser(P, G, 5)
  expect_true(P[5] %in% c("0️⃣", "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣",
                          "7️⃣", "8️⃣", "💣"))
})


test_that("Fonction a_creuser", {
  G <- matrix("💣", nrow = 6, ncol = 7)
  sans_bombes <- c(1, 7, 8, 10, 19, 28, 33)
  for (x in sans_bombes) {
    G[x] <- "."
  }
  expect_equal(a_creuser(G), sans_bombes)
})


test_that("Poser drapeau", {
            P <- matrix(1:18, nrow = 9)
            P <- drapeau(P, 7)
            expect_equal(P[7], paste0("🚩(", 7, ")"))
          })


test_that("Enlever drapeau", {
  P <- matrix(1:18, nrow = 9)
  P <- drapeau(drapeau(P, 7), 7)
  expect_equal(P[7], "7")
})


test_that("Annonce victoire", {
  acreuser <- 1:8
  plateau <- matrix(1:10, 5)
  for (i in 1:8) {
    plateau[i] <- "0️⃣"
  }
  print(gagne(acreuser, acreuser, plateau))
  expect_equal(gagne(acreuser, acreuser, plateau), "EXCELLENT 🥳  . Tu veux encore jouer?")
})


test_that("Annonce défaite", {
  acreuser <- 1:8
  creuse <- 1:9
  plateau <- matrix(1:10, 5)
  for (i in 1:8) {
    P[i] <- "0️⃣"
  }
  expect_equal(gagne(c(1, 2, 26), acreuser, plateau), "GAME OVER 😕 !")
})
