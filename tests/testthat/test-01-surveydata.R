# Unit tests for "surveydata" class
#
# Author: Andrie

if (interactive()) library(testthat)

tsv <- make_test_data()
tsv_labels <- varlabels(tsv)

context("Surveydata")

test_that("as.surveydata and is.surveydata works as expected", {
  s <- as.surveydata(tsv)
  # expected_pattern <- c("^", "(_[[:digit:]])*(_.*)?$")
  expected_pattern <- list(sep = "_", exclude = "other")
  expect_is(s, "surveydata")
  expect_is(s, "data.frame")
  expect_true(is.surveydata(s))
  expect_false(is.surveydata(tsv))
  expect_equal(pattern(s), expected_pattern)

  # new_pattern <- c("", "new_pattern$")
  new_pattern <- list(sep = ":", exclude = "last")
  s <- as.surveydata(tsv, ptn = new_pattern)
  expect_is(s, "surveydata")
  expect_true(is.surveydata(s))
  expect_equal(pattern(s), new_pattern)
})

test_that("Varlabel names are allocated correctly", {
  tdat <- tsv
  attributes(tdat)$variable.labels <- unname(attributes(tdat)$variable.labels)
  t <- as.surveydata(tsv)
  expect_equal(names(t), names(varlabels(t)))
})

#------------------------------------------------------------------------------

test_that("Varlabel functions work as expected", {
  s <- as.surveydata(tsv)
  expect_equal(varlabels(s), tsv_labels)

  varlabels(s) <- 1:8
  expect_equal(varlabels(s), 1:8)

  varlabels(s)[3] <- 20
  expect_equal(varlabels(s), c(1:2, 20, 4:8))

  s <- as.surveydata(tsv)
  varlabels(s)["crossbreak"] <- "New crossbreak"
  retn <- tsv_labels
  retn["crossbreak"] <- "New crossbreak"
  expect_equal(varlabels(s), retn)
})

#------------------------------------------------------------------------------

test_that("Pattern functions work as expected", {
  pattern <- "-pattern-"
  s <- as.surveydata(tsv)
  attr(s, "pattern") <- pattern
  expect_equal(pattern(s), pattern)

  attr(s, "pattern") <- NULL
  expect_true(is.null(pattern(s)))
  pattern(s) <- pattern
  expect_equal(attr(s, "pattern"), pattern)
})

test_that("Removing attributes work as expected", {
  s <- as.surveydata(tsv)

  t <- rm.attrs(s)
  expect_equal(varlabels(t), NULL)
  expect_equal(pattern(t), NULL)

  t <- as.data.frame(s, rm.pattern = TRUE)
  expect_equal(t, tsv)
})

#------------------------------------------------------------------------------

test_that("Name_replace works as expected", {
  s <- as.surveydata(tsv)
  spat <- pattern(s)

  names(s) <- gsub("id", "RespID", names(s))
  expect_equal(names(s)[1], "RespID")
  expect_equal(names(varlabels(s))[1], "RespID")
  expect_equal(pattern(s), spat)

  newpat <- c("X", "Y")
  s <- as.surveydata(tsv, ptn = newpat)

  names(s) <- gsub("id", "RespID", names(s))
  expect_equal(names(s), c("RespID", names(s)[-1]))
  expect_equal(names(varlabels(s)), c("RespID", names(s)[-1]))
  expect_equal(pattern(s), newpat)
})

#------------------------------------------------------------------------------

test_that("warnings are issued when names and varlabels mismatch", {
  s2 <- as.surveydata(tsv)
  varlabels(s2) <- varlabels(s2)[-1]
  expect_warning(is.surveydata(s2), "names and varlabel names must match")
})
