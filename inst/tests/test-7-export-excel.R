# Unit tests for "surveydata" class
# 
# Author: Andrie
#------------------------------------------------------------------------------

{
  sdat <- data.frame(
      id   = 1:4,
      Q1   = c("Yes", "No", "Yes", "Yes"),
      Q2   = c("Per", "Aspera", "Ad", "Astra"),
      crossbreak  = c("A", "A", "B", "B"), 
      weight      = c(0.9, 1.1, 0.8, 1.2)
  )
  
  sdat_labels <- c(
      "RespID",
      "Question 2",
      "Question 1", 
      "crossbreak",
      "weight"
  )
  names(sdat_labels) <- names(sdat)
  varlabels(sdat) <- sdat_labels
  ss <- as.surveydata(sdat, renameVarlabels=TRUE)

  require("XLConnect")
  
}


#------------------------------------------------------------------------------

context("Export-excel")

test_that("Export generates Excel file", {
      xlFile <- tempfile(fileext=".xlsx")
      xlwb <- loadWorkbook(xlFile, create = TRUE)
      writeOneQuestionExcel(ss, "Q2", xlwb)
      saveWorkbook(xlwb)
      
      expect_true(file.exists(xlFile))
      
      xlwb <- loadWorkbook(xlFile, create = FALSE)
      zz <- readWorksheet(xlwb, sheet=1, startRow=5, endCol=3)
      zz <- na.omit(zz)
      
      rest <- structure(list(
              Id = c("1", "2", "3", "4"), 
              Text = c("Per", "Aspera", "Ad", "Astra"),
              Modified = c("", "", "", "")), 
          .Names = c("Id", "Text", "Modified"), 
          row.names = c(NA, 4L), class = "data.frame")
      expect_identical(zz, rest)
      file.remove(xlFile)
    })

test_that("Export uses correct colnames", {
      xlFile <- tempfile(fileext=".xlsx")
      xlwb <- loadWorkbook(xlFile, create = TRUE)
      writeOneQuestionExcel(ss, "Q2", xlwb, colnames=c("Id", "Original", "English Translation"))
      saveWorkbook(xlwb)
      
      expect_true(file.exists(xlFile))
      
      xlwb <- loadWorkbook(xlFile, create = FALSE)
      zz <- readWorksheet(xlwb, sheet=1, startRow=5, endCol=3)
      zz <- na.omit(zz)
      
      rest <- structure(list(
              Id = c("1", "2", "3", "4"), 
              Text = c("Per", "Aspera", "Ad", "Astra"), 
              Modified = c("", "", "", "")), 
          .Names = c("Id", "Original", "English.Translation"), 
          row.names = c(NA, 4L), 
          class = "data.frame")
      expect_identical(zz, rest)
      file.remove(xlFile)
    })


test_that("Export uses correct subset", {
      xlFile <- tempfile(fileext=".xlsx")
      xlwb <- loadWorkbook(xlFile, create = TRUE)
      writeOneQuestionExcel(ss, "Q2", xlwb, subset=crossbreak=="A")
      saveWorkbook(xlwb)
      
      expect_true(file.exists(xlFile))
      
      xlwb <- loadWorkbook(xlFile, create = FALSE)
      zz <- na.omit(readWorksheet(xlwb, sheet=1, startRow=5, endCol=3))
      attr(zz, "na.action") <- NULL
      
      rest <- structure(list(
              Id = c("1", "2"), 
              Text = c("Per", "Aspera"), 
              Modified = c("", "")), 
              .Names = c("Id", "Text", "Modified"), 
              row.names = c(NA, 2L), 
          class = "data.frame")
      
      expect_equal(zz, rest)
      file.remove(xlFile)
    })


test_that("Exports multiple questions correctly", {
      xlFile <- tempfile(fileext=".xlsx")
      writeQuestionExcel(ss, c("Q1", "Q2"), file=xlFile)
      
      expect_true(file.exists(xlFile))
      
      xlwb <- loadWorkbook(xlFile, create = FALSE)
      zz1 <- na.omit(readWorksheet(xlwb, sheet=1, startRow=5, endCol=3))
      zz2 <- na.omit(readWorksheet(xlwb, sheet=2, startRow=5, endCol=3))
      
      rest1 <- structure(list(
              Id = c("1", "2", "3", "4"), 
              Text = c("Yes", "No", "Yes", "Yes"), 
              Modified = c("", "", "", "")), 
          .Names = c("Id", "Text", "Modified"), 
          row.names = c(NA, 4L), 
          class = "data.frame")
      
      rest2 <- structure(list(
              Id = c("1", "2", "3", "4"), 
              Text = c("Per", "Aspera", "Ad", "Astra"), 
              Modified = c("", "", "", "")), 
          .Names = c("Id", "Text", "Modified"), 
          row.names = c(NA, 4L), 
          class = "data.frame")
      
      expect_identical(zz1, rest1)
      expect_identical(zz2, rest2)
      file.remove(xlFile)
    })


test_that("Exports multiple questions with subset", {
      xlFile <- tempfile(fileext=".xlsx")
      writeQuestionExcel(ss, c("Q1", "Q2"), file=xlFile, subset=crossbreak=="B")
      
      expect_true(file.exists(xlFile))
      
      xlwb <- loadWorkbook(xlFile, create = FALSE)
      zz1 <- na.omit(readWorksheet(xlwb, sheet=1, startRow=5, endCol=3))
      zz2 <- na.omit(readWorksheet(xlwb, sheet=2, startRow=5, endCol=3))
      attr(zz1, "na.action") <- NULL
      attr(zz2, "na.action") <- NULL
      
      
      rest1 <- structure(list(
              Id = c("3", "4"), 
              Text = c("Yes", "Yes"), 
              Modified = c("", "")), 
          .Names = c("Id", "Text", "Modified"), 
          row.names = c(NA, 2L), 
          class = "data.frame")
      
      rest2 <- structure(list(
              Id = c("3", "4"), 
              Text = c("Ad", "Astra"), 
              Modified = c("", "")), 
          .Names = c("Id", "Text", "Modified"), 
          row.names = c(NA, 2L), 
          class = "data.frame")
      
      expect_identical(zz1, rest1)
      expect_identical(zz2, rest2)
      file.remove(xlFile)
    })

