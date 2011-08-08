# unit test for "surveydata" class
# 
# Author: Andrie
###############################################################################


sdat <- data.frame(
    id   = 1:4,
    Q1   = c("Yes", "No", "Yes", "Yes"),
    Q4_1 = c(1, 2, 1, 2), 
    Q4_2 = c(3, 4, 4, 3), 
    Q4_3 = c(5, 5, 6, 6), 
    crossbreak  = c("A", "A", "B", "B"), 
    crossbreak2 = c("D", "E", "D", "E"),
    weight      = c(0.9, 1.1, 0.8, 1.2)
)

sdat_labels <- c(
    "RespID",
    "Question 1", 
    "Question 4: red", "Question 4: green", "Question 4: blue", 
    "crossbreak",
    "crossbreak2",
    "weight")
names(sdat_labels) <- names(sdat)
attributes(sdat)$variable.labels <- sdat_labels 

#s <- as.surveydata(sdat)
#is.surveydata(s)
#varlabels(s)
#identical(varlabels(s), sdat_labels)

###############################################################################

context("Surveydata class functions")
test_that("as.surveydata and is.surveydata works as expected", {
      s <- as.surveydata(sdat)
      expect_that(s, is_a("surveydata"))
      expect_that(is.surveydata(s), is_true())
      expect_that(is.surveydata(sdat), is_false())
    })

###############################################################################

context("Varlabel functions")
test_that("Varlabel functions work as expected", {
      s <- as.surveydata(sdat)
      expect_that(varlabels(s), equals(sdat_labels))
      varlabels(s) <- 1:8
      expect_that(varlabels(s), equals(1:8))
      varlabels(s)[3] <- 20
      expect_that(varlabels(s), equals(c(1:2, 20, 4:8)))
    })

###############################################################################

context("Rename columns")

test_that("Name_replace works as expected", {
      s <- as.surveydata(sdat)
      names(s) <- gsub("id", "RespID", names(s))
      expect_that(names(s)[1], equals("RespID"))
      expect_that(names(varlabels(s))[1], equals("RespID"))
    })

###############################################################################

context("Subsetting")

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



###############################################################################

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
      s2 <- as.surveydata(sdat2)
      sm <- merge(s1, s2)
      expect_that(sm, is_a("surveydata"))
    })