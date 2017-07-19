if(interactive()) library(testthat)
context("Encoding")

test_that("encoding functions work",{
  expect_equal(encToInt("\\xfa"), c(92L, 120L, 102L, 97L))
  expect_equal(intToEnc(8212), "-")
  expect_equal(intToEnc(encToInt("\\xfa")), "\\xfa")
  expect_equal(encToInt(intToEnc(8212, encoding = "UTF-8"), encoding = "UTF-8"), 8212)
  
  test <- paste0(intToEnc(194), intToEnc(128), intToEnc(226), intToEnc(147), collapse = "")
  expect_equal(fixCommonEncodingProblems(test), "-")
})

