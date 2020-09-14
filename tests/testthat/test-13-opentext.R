if (interactive()) library(testthat)


test_that("converts free text to DT object", {
  p <- as_opentext_datatable(membersurvey, "Q33")
  expect_s3_class(p, "datatables")
  expect_s3_class(p, "htmlwidget")

  p <- print_opentext(membersurvey, "Q33", cat = FALSE)
  expect_type(p, "character")
})
