if (interactive()) library(testthat)


test_that("encoding functions work", {
  skip_on_os(c("mac", "linux", "solaris"))

  expect_equal(encToInt("\\xfa", encoding = "ISO8859-1"), c(92L, 120L, 102L, 97L))
  expect_equal(intToEnc(8212, "ISO8859-1"), "-")
  expect_equal(intToEnc(encToInt("\\xfa", encoding = "ISO8859-1"), encoding = "ISO8859-1"), "\\xfa")
  expect_equal(encToInt(intToEnc(8212, encoding = "UTF-8"), encoding = "UTF-8"), 8212)

  test <- paste0(
    intToEnc(194, encoding = "UTF-8"),
    intToEnc(128, encoding = "UTF-8"),
    intToEnc(226, encoding = "UTF-8"),
    intToEnc(147, encoding = "UTF-8"),
    collapse = ""
  )
  expect_equal(fix_common_encoding_problems(test, encoding = "UTF-8"), "-")
})
