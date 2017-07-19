
context("survey")



# Extract specific questions

# Query attributes

# Find unique questions


# Find question text



test_that("Basic functionality", {
  res <- test_survey[, "Q1"]
  expect_is(res, "surveydata")
  expect_is(res, "data.frame")
  expect_equal(ncol(res), 1)
  expect_equal(nrow(res), 4)
  
  res <- test_survey[, "Q4"]
  expect_is(res, "surveydata")
  expect_is(res, "data.frame")
  expect_equal(ncol(res), 3)
  expect_equal(nrow(res), 4)
  
  vl <- varlabels(test_survey)
  expect_is(vl, "character")
  expect_equal(length(vl), ncol(test_survey))
  expect_equal(names(vl), names(test_survey))
  
  ptn <- pattern(test_survey)
  expect_is(ptn, "list")
  expect_equal(length(ptn), 2)
  expect_equal(ptn, list(sep = "_", exclude = "other"))
  
  ms <- membersurvey
  ms <- rm.pattern(ms)
  expect_null(pattern(ms))
  
  q <- questions(test_survey)
  expect_is(q, "character")
  expect_equal(q, c("id", "Q1", "Q4", "Q10", "crossbreak", "weight"))

  res <- which.q(test_survey, "Q1")
  expect_equal(res, 2L)
  
  res <- which.q(test_survey, "Q4")
  expect_equal(res, 3:5)
  
  expect_equal(qText(test_survey, "Q1"), "Question 1")
  expect_equal(qText(test_survey, "Q4"), paste("Question 4:", c("red", "green", "blue")))
  
  expect_equal(qTextCommon(test_survey, "Q4"), "Question 4")
  expect_equal(qTextUnique(test_survey, "Q4"), c("red", "green", "blue"))
    
})

