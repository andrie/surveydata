if (interactive()) library(testthat)
context("open text")

test_that("converts free text to DT object", {
  p <- as_opentext_datatable(membersurvey, "Q33")
  expect_is(p, "datatables")
  expect_is(p, "htmlwidget")

  p <- print_opentext(membersurvey, "Q33", cat = FALSE)
  expect_is(p, "character")
})
