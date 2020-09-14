

test_that("strCommonUnique works", {
  str_common <- function(x) strCommonUnique(x)$common
  str_unique <- function(x) strCommonUnique(x)$unique

  x <- "Q"
  expect_type(str_common(x), "character")
  expect_type(str_unique(x), "character")

  expect_equal(str_common(x), "Q")
  expect_equal(str_unique(x), "")

  x <- c("Q", "Q1")
  expect_equal(str_common(x), "Q")
  expect_equal(str_unique(x), c("", "1"))

  x <- c("Q1", "Q1")
  expect_equal(str_common(x), "Q1")
  expect_equal(str_unique(x), c("", ""))

  x <- c("Q1", "Q2")
  expect_equal(str_common(x), "Q")
  expect_equal(str_unique(x), c("1", "2"))

  x <- c("1", "2", "3")
  expect_equal(str_common(x), "")
  expect_equal(str_unique(x), c("1", "2", "3"))

  x <- c("Q_1", "Q_2", "Q_3")
  expect_equal(str_common(x), "Q_")
  expect_equal(str_unique(x), c("1", "2", "3"))

  x <- c("X_1", "Z_1", "Z_1")
  expect_equal(str_common(x), "")
  expect_equal(str_unique(x), c("X_1", "Z_1", "Z_1"))
})
