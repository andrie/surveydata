
if (interactive()) library(testthat)

tsv <- make_test_survey()

context("survey")

test_that("Basic functionality", {
  res <- tsv[, "Q1"]
  expect_is(res, "surveydata")
  expect_is(res, "data.frame")
  expect_equal(ncol(res), 1)
  expect_equal(nrow(res), 4)

  res <- tsv[, "Q4"]
  expect_is(res, "surveydata")
  expect_is(res, "data.frame")
  expect_equal(ncol(res), 3)
  expect_equal(nrow(res), 4)

  vl <- varlabels(tsv)
  expect_is(vl, "character")
  expect_equal(length(vl), ncol(tsv))
  expect_equal(names(vl), names(tsv))

  ptn <- pattern(tsv)
  expect_is(ptn, "list")
  expect_equal(length(ptn), 2)
  expect_equal(ptn, list(sep = "_", exclude = "other"))

  ms <- membersurvey
  ms <- rm.pattern(ms)
  expect_null(pattern(ms))

  q <- questions(tsv)
  expect_is(q, "character")
  expect_equal(q, c("id", "Q1", "Q4", "Q10", "crossbreak", "weight"))

  res <- which.q(tsv, "Q1")
  expect_equal(res, 2L)

  res <- which.q(tsv, "Q4")
  expect_equal(res, 3:5)

  expect_equal(question_text(tsv, "Q1"), "Question 1")
  expect_equal(question_text(tsv, "Q4"), paste("Question 4:", c("red", "green", "blue")))

  expect_equal(question_text_common(tsv, "Q4"), "Question 4")
  expect_equal(question_text_unique(tsv, "Q4"), c("red", "green", "blue"))
})
