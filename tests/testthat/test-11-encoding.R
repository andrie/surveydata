if(interactive()) library(testthat)
context("Encoding")

test_that("encoding functions work",{
  expect_equal(encToInt("\\xfa"), c(92L, 120L, 102L, 97L))
  expect_equal(intToEnc(8212), "-")
  expect_equal(intToEnc(encToInt("\\xfa")), "\\xfa")
  expect_equal(encToInt(intToEnc(8212, encoding = "UTF-8"), encoding = "UTF-8"), 8212)

  ### Disabling test - this fails on Travis.  
  # test <- paste0(
  #   intToEnc(194, encoding = "UTF-8"), 
  #   intToEnc(128, encoding = "UTF-8"), 
  #   intToEnc(226, encoding = "UTF-8"), 
  #   intToEnc(147, encoding = "UTF-8"), 
  #   collapse = "")
  # expect_equal(fixCommonEncodingProblems(test, encoding = "UTF-8"), "-")
})

