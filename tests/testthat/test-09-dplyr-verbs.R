if(interactive()) library(testthat)
context("dplyr verbs")

test_that("dplyr verbs retain surveydata class",{
  skip_if_not_installed("dplyr")
  require(dplyr)

  expect_is(membersurvey %>% as.tbl(), "surveydata")
  expect_is(membersurvey %>% as.tbl() %>% mutate(id = 1), "surveydata")
  expect_is(membersurvey %>% as.tbl() %>% filter(Q2 == 2009), "surveydata")
  expect_is(membersurvey %>% as.tbl() %>% slice(1), "surveydata")
  expect_is(membersurvey %>% as.tbl() %>% arrange(Q2), "surveydata")
  expect_is(membersurvey %>% as.tbl() %>% select(Q2), "surveydata")
  expect_is(membersurvey %>% as.tbl() %>% summarise(n = n()), "surveydata")
  expect_is(membersurvey %>% as.tbl() %>% summarize(n = n()), "surveydata")
})

