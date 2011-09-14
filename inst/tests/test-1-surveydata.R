# Unit tests for "surveydata" class
# 
# Author: Andrie
#------------------------------------------------------------------------------


{
  sdat <- data.frame(
      id   = 1:4,
      Q1   = c("Yes", "No", "Yes", "Yes"),
      Q4_1 = c(1, 2, 1, 2), 
      Q4_2 = c(3, 4, 4, 3), 
      Q4_3 = c(5, 5, 6, 6), 
      Q10 = factor(c("Male", "Female", "Female", "Male")),
      crossbreak  = c("A", "A", "B", "B"), 
      crossbreak2 = c("D", "E", "D", "E"),
      weight      = c(0.9, 1.1, 0.8, 1.2)
  )
  
  sdat_labels <- c(
      "RespID",
      "Question 1", 
      "Question 4: red", "Question 4: green", "Question 4: blue", 
      "Question 10",
      "crossbreak",
      "crossbreak2",
      "weight")
  names(sdat_labels) <- names(sdat)
  attributes(sdat)$variable.labels <- sdat_labels
}

#s <- as.surveydata(sdat)
#is.surveydata(s)
#varlabels(s)
#identical(varlabels(s), sdat_labels)

#------------------------------------------------------------------------------

context("Surveydata class functions")
test_that("as.surveydata and is.surveydata works as expected", {
      s <- as.surveydata(sdat)
      expected_pattern <- c("^", "(_[[:digit:]])*(_.*)?$")
      expect_that(s, is_a("surveydata"))
      expect_that(s, is_a("data.frame"))
      expect_that(is.surveydata(s), is_true())
      expect_that(is.surveydata(sdat), is_false())
      expect_that(pattern(s), equals(expected_pattern))
      
      new_pattern <- c("", "new_pattern$")
      s <- as.surveydata(sdat, ptn=new_pattern)
      expect_that(s, is_a("surveydata"))
      expect_that(is.surveydata(s), is_true())
      expect_that(pattern(s), equals(new_pattern))
    })

#------------------------------------------------------------------------------

#context("Varlabel functions")
test_that("Varlabel functions work as expected", {
      s <- as.surveydata(sdat)
      expect_that(varlabels(s), equals(sdat_labels))
      varlabels(s) <- 1:8
      expect_that(varlabels(s), equals(1:8))
      varlabels(s)[3] <- 20
      expect_that(varlabels(s), equals(c(1:2, 20, 4:8)))
    })


#context("Pattern functions")
test_that("Pattern functions work as expected", {
      pattern <- "-pattern-"
      s <- as.surveydata(sdat)
      attr(s, "pattern") <- pattern
      expect_that(pattern(s), equals(pattern))
      
      attr(s, "pattern") <- NULL
      expect_that(is.null(pattern(s)), is_true())
      pattern(s) <- pattern
      expect_that(attr(s, "pattern"), equals(pattern))
    })

#context("Remove attributes")
test_that("Removing attributes work as expected", {
      s <- as.surveydata(sdat)
      
      t <- rm.attrs(s)      
      expect_equal(varlabels(t), NULL)
      expect_equal(pattern(t), NULL)
      
      t <- as.data.frame(s, rm.pattern=TRUE)
      expect_equal(t, sdat)

    })

#------------------------------------------------------------------------------

#context("Rename columns")

test_that("Name_replace works as expected", {
      s <- as.surveydata(sdat)
      names(s) <- gsub("id", "RespID", names(s))
      expect_that(names(s)[1], equals("RespID"))
      expect_that(names(varlabels(s))[1], equals("RespID"))
    })

#------------------------------------------------------------------------------

context("$ Subsetting")

test_that("`$<-` NULL removes column as well as varlabel", {
      s <- as.surveydata(sdat)
      s$id <- NULL
      expect_that(is.na(match("id", names(s))), is_true())
      expect_that(is.na(match("id", names(varlabels(s)))), is_true())
      expect_that(names(s), equals(names(sdat[-1])))
      expect_that(names(varlabels(s)), equals(names(sdat[-1])))
    })

test_that("`$<-` newname inserts column and new varlabel", {
      s <- as.surveydata(sdat)
      s$newid <- 101:104
      expect_that(s$newid, equals(101:104))
      expect_that(all(s$newid==101:104), is_true())
      expect_that(is.na(match("newid", names(varlabels(s)))), is_false())
    })

context("`[` Subsetting")

test_that("which.q returns correct question positions", {
      s <- as.surveydata(sdat)
      expect_that(which.q(s, "Q1"), equals(2))
      expect_that(which.q(s, "Q10"), equals(6))
      expect_that(which.q(s, "Q4"), equals(3:5))
      expect_that(which.q(s, "Q2"), equals(integer(0)))
    })

test_that("`[` subsetting works as expected", {
      s <- as.surveydata(sdat)
      expect_equal(rm.pattern(s[2, ]), sdat[2, ])
      expect_that(s[, 2], equals(sdat[, 2]))
      expect_that(s[, "Q1"], equals(sdat[, 2]))
      expect_that(s[, "Q4"], equals(sdat[, 3:5]))
      expect_that(s[2, "Q4"], equals(sdat[2, 3:5]))
      expect_that(s[1:2, "Q10"], equals(sdat[1:2, 6]))
      expect_that(s[, "weight"], equals(sdat[, "weight"]))
    })


#------------------------------------------------------------------------------

context("Merge surveydata objects")

test_that("Merge of surveyordata objects work as expected",{
      sdat2 <- data.frame(
          id   = 5:6,
          Q1   = c("Yes", "No"),
          Q4_1 = c(5, 6), 
          Q4_2 = c(7, 8), 
          Q4_3 = c(9, 10), 
          crossbreak  = c("U", "V"), 
          crossbreak2 = c("X", "Y"),
          weight      = c(0.95, 1.05)
      )
      varlabels(sdat2) <- sdat_labels
      
      s1 <- as.surveydata(sdat)
      s2 <- as.surveydata(sdat2, ptn=c("^", "$"))
      expect_that(
          sm <- merge(s1, s2, all=TRUE),
          gives_warning("In merge of surveydata objects, patterns of objects differ")
      )
      #sm <- merge(s1, s2, all=TRUE)
      expect_that(sm, is_a("surveydata"))
      expect_equal(nrow(sm), 6)
      expect_equal(pattern(s1), pattern(sm))
    })