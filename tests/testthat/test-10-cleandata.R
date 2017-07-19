if(interactive()) library(testthat)
context("clean data")

test_that("cleandata functions work",{
  expect_false(any(sapply(membersurvey, hasDK)))
  expect_equal(membersurvey$Q2, removeDK(membersurvey$Q2))
  expect_equal(membersurvey, removeAllDK(membersurvey))
  expect_equal(
    levels(removeDK(membersurvey$Q2, dk = "Before 2002")),
    as.character(2003:2011))
  expect_false(leveltestR(membersurvey))
  expect_is(fixLevels01(membersurvey), "surveydata")
})

