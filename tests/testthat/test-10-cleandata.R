if (interactive()) library(testthat)


test_that("cleandata functions work", {
  expect_false(
    any(sapply(membersurvey, has_dont_know))
  )
  expect_equal(
    membersurvey$Q2,
    remove_dont_know(membersurvey$Q2)
  )
  expect_equal(
    membersurvey,
    remove_all_dont_know(membersurvey)
  )
  expect_equal(
    levels(remove_dont_know(membersurvey$Q2, dk = "Before 2002")),
    as.character(2003:2011)
  )
  expect_false(
    leveltest_r(membersurvey)
  )
  expect_s3_class(fix_levels_01(membersurvey), "surveydata")
})


test_that("deprecated functions return warnings", {
  expect_warning(hasDK(membersurvey["id"]))
  
  expect_warning(removeAllDK(membersurvey, message = FALSE))
  expect_warning(removeDK(membersurvey$Q2, dk = "Before 2002"))
  expect_warning(leveltestR(membersurvey))
  expect_warning(fixLevels01(membersurvey))
})
