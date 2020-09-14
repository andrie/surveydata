# Unit tests for "surveydata" class
#
# Author: Andrie
if (interactive()) library(testthat)

tsv <- make_test_data()
tsv_labels <- varlabels(tsv)

sdat2 <- make_test_data_2()

rm.ca <- function(x) {
  class(x) <- class(x)[!grepl("surveydata", class(x))]
  rm.attrs(x)
}

#------------------------------------------------------------------------------



test_that("which.q returns correct question positions", {
  s <- as.surveydata(tsv, renameVarlabels = TRUE)
  expect_equal(which.q(s, c(1)), 1)
  expect_equal(which.q(s, c(4)), 4)
  expect_equal(which.q(s, c(-1)), -1)
  expect_equal(which.q(s, "Q1"), 2)
  expect_equal(which.q(s, "Q10"), 6)
  expect_equal(which.q(s, "Q4"), 3:5)
  expect_equal(which.q(s, "Q2"), integer(0))

  expect_equal(which.q(s, c("Q1", "Q4")), c(2, 3:5))
  expect_equal(which.q(s, c("Q1", "crossbreak")), c(2, 7))
  expect_equal(which.q(s, c("Q4", "crossbreak2")), c(3:5, 8))

  expect_equal(which.q(s, c(3, "crossbreak2")), c(3, 8))
})

#------------------------------------------------------------------------------

# context("which.q 2")

test_that("which.q returns correct question positions", {
  s2 <- as.surveydata(sdat2, ptn = list(sep = "__", exclude = "ignore"), renameVarlabels = TRUE)
  expect_equal(which.q(s2, c(1)), 1)
  expect_equal(which.q(s2, c(4)), 4)
  expect_equal(which.q(s2, c(-1)), -1)
  expect_equal(which.q(s2, "Q1"), 2)
  expect_equal(which.q(s2, "Q10"), 7)
  expect_equal(which.q(s2, "Q4"), 3:5)
  expect_equal(which.q(s2, "Q2"), integer(0))

  expect_equal(which.q(s2, c("Q1", "Q4")), c(2, 3:5))
  expect_equal(which.q(s2, c("Q1", "crossbreak")), c(2, 8))
  expect_equal(which.q(s2, c("Q4", "crossbreak2")), c(3:5, 9))

  expect_equal(which.q(s2, c(3, "crossbreak2")), c(3, 9))
})
