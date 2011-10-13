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

rm.ca <- function(x){
  class(x) <- class(x)[!grepl("surveydata", class(x))]
  rm.attrs(x)
}

#------------------------------------------------------------------------------

context("which.q")

test_that("which.q returns correct question positions", {
      s <- as.surveydata(sdat)
      expect_that(which.q(s, c(1)), equals(1))
      expect_that(which.q(s, c(4)), equals(4))
      expect_that(which.q(s, c(-1)), equals(-1))
      expect_that(which.q(s, "Q1"), equals(2))
      expect_that(which.q(s, "Q10"), equals(6))
      expect_that(which.q(s, "Q4"), equals(3:5))
      expect_that(which.q(s, "Q2"), equals(integer(0)))
      
      expect_that(which.q(s, c("Q1", "Q4")), equals(c(2, 3:5)))
      expect_that(which.q(s, c("Q1", "crossbreak")), equals(c(2, 7)))
      expect_that(which.q(s, c("Q4", "crossbreak2")), equals(c(3:5, 8)))
      
      expect_that(which.q(s, c(3, "crossbreak2")), equals(c(3, 8)))
      
    })

#------------------------------------------------------------------------------

context("Surveydata $ simple extract")

test_that("`$<-` NULL removes column as well as varlabel", {
      s <- as.surveydata(sdat)
      s$id <- NULL
      expect_true(is.na(match("id", names(s))))
      expect_true(is.na(match("id", names(varlabels(s)))))
      expect_equal(names(s), names(sdat[-1]))
      expect_equal(names(varlabels(s)), names(sdat[-1]))
      expect_is(s, "surveydata")
    })

test_that("`$<-` existing_name maintains correct varlabels",{
      s <- as.surveydata(sdat)
      expect_equal(varlabels(sdat), varlabels(s))
      s$Q4_1 <- 1:4
      expect_equal(varlabels(sdat), varlabels(s))
    })

test_that("`$<-` newname inserts column and new varlabel", {
      s <- as.surveydata(sdat)
      s$newid <- 101:104
      expect_equal(s$newid, 101:104)
      expect_true(all(s$newid==101:104))
      expect_false(is.na(match("newid", names(varlabels(s)))))
      expect_is(s, "surveydata")
    })

#------------------------------------------------------------------------------

context("Surveydata `[` extract")

test_that("`[` simple extract works as expected", {
      s <- as.surveydata(sdat)

      expect_is(s[, 2], "surveydata")
      expect_is(s[1, ], "surveydata")
      expect_is(s[2, 2], "surveydata")
      expect_is(s[, "Q1"], "surveydata")
      expect_is(s[, "Q4"], "surveydata")
      
      
      expect_equal(rm.ca(s[2, ]), rm.ca(sdat[2, ]))
      expect_equal(rm.ca(s[, 2]), rm.ca(sdat[, 2]))
      expect_equal(rm.ca(s[, "Q1"]), rm.ca(sdat[, 2]))
      expect_equal(rm.ca(s[, "Q4"]), rm.ca(sdat[, 3:5]))
      expect_equal(rm.ca(s[2, "Q4"]), rm.ca(sdat[2, 3:5]))
      expect_equal(rm.ca(s[1:2, "Q10"]), rm.ca(sdat[1:2, 6]))
      expect_equal(rm.ca(s[, "weight"]), rm.ca(sdat[, "weight"]))

      
      expect_equal(varlabels(s[2, ]), sdat_labels)
      expect_equal(varlabels(s[, 2]), sdat_labels[2])
      expect_equal(varlabels(s[2:4, 5]), sdat_labels[5])
      expect_equal(varlabels(s[, "Q1"]), sdat_labels[2])
      expect_equal(varlabels(s[, "Q4"]), sdat_labels[3:5])
      expect_equal(varlabels(s[2, "Q4"]), sdat_labels[3:5])
      expect_equal(varlabels(s[2, "Q1"]), sdat_labels[2])
      
    })

#------------------------------------------------------------------------------
    
context("Surveydata $ complex extract")
test_that("`[` complex extract works as expected", {
      s <- as.surveydata(sdat)
      
      expect_equal(rm.ca(s[, c(1, 3)]), rm.ca(sdat[, c(1, 3)]))
      expect_equal(rm.ca(s[, -1]), rm.ca(sdat[, -1]))
      expect_equal(rm.ca(s[, c(1, "Q4")]), rm.ca(sdat[, c(1, 3:5)]))
      expect_equal(rm.ca(s[, c("Q1", "Q4")]), rm.ca(sdat[, c(2, 3:5)]))

      expect_equal(varlabels(s[, c(1, 3)]), sdat_labels[c(1, 3)])
      expect_equal(varlabels(s[, -1]), sdat_labels[-1])
      expect_equal(varlabels(s[, c(1, "Q4")]), sdat_labels[c(1, 3:5)])
      expect_equal(varlabels(s[, c("Q1", "Q4")]), sdat_labels[c(2, 3:5)])
      
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
      expect_is(sm, "surveydata")
      expect_equal(nrow(sm), 6)
      expect_equal(pattern(s1), pattern(sm))
    })