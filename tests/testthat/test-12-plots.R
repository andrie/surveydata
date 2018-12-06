if (interactive()) library(testthat)
context("Plots")

test_that("plotting functions return plot objects",{

  p <- survey_plot_question(membersurvey, "Q2")
  expect_is(p, "ggplot")
  
  p <- survey_plot_yes_no(membersurvey, "Q2")
  expect_is(p, "ggplot")
  
  p <- survey_plot_satisfaction(membersurvey, "Q14")
  expect_is(p, "ggplot")
  
  
})

