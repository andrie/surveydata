# 
# Author: andrie
###############################################################################

context("tools")

test_that("dropout calculation is correct", {
      
      rest <- setNames(c(215, 213, 82), c("id", "Q35", "Q37"))
      expect_equal(dropout(membersurvey[-(127:128)]), rest)
    })

