if (interactive()) library(testthat)


test_that("dplyr verbs retain surveydata class", {
  skip_if_not_installed("dplyr")
  require(dplyr)

  expect_warning(membersurvey %>% as.tbl.surveydata(), "deprecated")
  
  expect_s3_class(membersurvey %>% as_tibble(), "surveydata")
  expect_s3_class(membersurvey %>% as_tibble() %>% mutate(id = 1), "surveydata")
  expect_s3_class(membersurvey %>% as_tibble() %>% filter(Q2 == 2009), "surveydata")
  expect_s3_class(membersurvey %>% as_tibble() %>% slice(1), "surveydata")
  expect_s3_class(membersurvey %>% as_tibble() %>% arrange(Q2), "surveydata")
  expect_s3_class(membersurvey %>% as_tibble() %>% select(Q2), "surveydata")
  expect_s3_class(membersurvey %>% as_tibble() %>% summarise(n = n()), "surveydata")
  expect_s3_class(membersurvey %>% as_tibble() %>% summarize(n = n()), "surveydata")
  
  
  })
