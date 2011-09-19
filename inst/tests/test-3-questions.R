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
 
context("Questions")
test_that("qText, qTextCommon and qTextUnique work as expected", {
  s <- as.surveydata(sdat)
  expect_equal(qText(s, "Q1"), "Question 1")
  expect_equal(qText(s, "Q4"), c("Question 4: red", "Question 4: green", "Question 4: blue"))
  expect_equal(qText(s, "Q10"), "Question 10")
  expect_equal(qText(s, "Q99"), character(0))
  
  expect_equal(qTextCommon(s, "Q4"), "Question 4")
  expect_equal(qTextUnique(s, "Q4"), c("red", "green", "blue"))
  
  expect_equal(questions(s), c(
      "id",
      "Q1", 
      "Q4", 
      "Q10",
      "crossbreak",
      "crossbreak2",
      "weight")
  )  
  
})

#------------------------------------------------------------------------------

test_that("splitCommonUnique works as expected", {
      test <- c("Email (Please tell us)", "Phone (Please tell us)")
      exp  <- list(common="Please tell us", unique=c("Email", "Phone"))
      expect_equal(splitCommonUnique(test), exp)
      
      test <- c("What is your choice?: Email", "What is your choice?: Phone")
      exp  <- list(common="What is your choice?", unique=c("Email", "Phone"))
      expect_equal(splitCommonUnique(test), exp)
    
      test <- c("What is your choice?:Email", "What is your choice?:Phone")
      exp  <- list(common="What is your choice?", unique=c("Email", "Phone"))
      expect_equal(splitCommonUnique(test), exp)
      
      test <- c("Q3(001)Email", "Q3(001)Phone")
      exp  <- list(common="Q3", unique=c("Email", "Phone"))
      expect_equal(splitCommonUnique(test), exp)
    
      test <- c("Q3(001) Email", "Q3(001) Phone")
      exp  <- list(common="Q3", unique=c("Email", "Phone"))
      expect_equal(splitCommonUnique(test), exp)
      
      test <- c("Q3[001] Email", "Q3[001] Phone")
      exp  <- list(common="Q3", unique=c("Email", "Phone"))
      expect_equal(splitCommonUnique(test), exp)
      
      test <- c("Q3[01]Email", "Q3[01]Phone")
      exp  <- list(common="Q3", unique=c("Email", "Phone"))
      expect_equal(splitCommonUnique(test), exp)
      
      test <- c("[Email]What is your choice?", "[Phone]What is your choice?")
      exp  <- list(common="What is your choice?", unique=c("Email", "Phone"))
      expect_equal(splitCommonUnique(test), exp)
      
      test <- c("Q_1", "Q_2")
      exp  <- list(common="Q_", unique=c("1", "2"))
      expect_equal(splitCommonUnique(test), exp)
      })



