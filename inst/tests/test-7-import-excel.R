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

context("Import-excel")

test_that("Import of single sheet works", {
      # Create export file
      xlFile <- tempfile(fileext=".xlsx")
      writeQuestionExcel(ss, c("Q1", "Q2"), file=xlFile)
      expect_true(file.exists(xlFile))
      
      # Read file
      
      xlwb <- loadWorkbook(xlFile)
      zz1 <- readWorksheet(xlwb, 1, startRow=5, endCol=3)
      zz2 <- readWorksheet(xlwb, 2, startRow=5, endCol=3)
      
      zz1 <- readOneQuestionExcel(xlwb, sheetname=1)
      zz2 <- readOneQuestionExcel(xlwb, sheetname=2)
      
      rest1 <- structure(list(
              Qid = c("Q1", "Q1", "Q1", "Q1"), 
              Id = c("1", "2", "3", "4"), 
              Text = c("Yes", "No", "Yes", "Yes"), 
              Modified = c("", "", "", "")), 
          .Names = c("Qid", "Id", "Text", "Modified"), 
          row.names = c(NA, 4L), class = "data.frame")
      
      rest2 <- structure(list(
              Qid = c("Q2", "Q2", "Q2", "Q2"), 
              Id = c("1", "2", "3", "4"), 
              Text = c("Per", "Aspera", "Ad", "Astra"), 
              Modified = c("", "", "", "")), 
          .Names = c("Qid", "Id", "Text", "Modified"), 
          row.names = c(NA, 4L), class = "data.frame")
      
      expect_equal(zz1, rest1)
      expect_equal(zz2, rest2)
      unlink(xlFile)
      
    })
      
test_that("Import of all sheet in single workbook works", {
      # Create export file
      xlFile <- tempfile(fileext=".xlsx")
      writeQuestionExcel(ss, c("Q1", "Q2"), file=xlFile)
      expect_true(file.exists(xlFile))
      
      # Read file
      
      zz <- readAllSheets(file=xlFile, .progress="none")
      
      rest <- structure(list(
              Qid = c("Q1", "Q1", "Q1", "Q1", "Q2", "Q2", "Q2", "Q2"), 
              Id = c("1", "2", "3", "4", "1", "2", "3", "4"), 
              Text = c("Yes", "No", "Yes", "Yes", "Per", "Aspera", "Ad", "Astra"), 
              Modified = c("", "", "", "", "", "", "", "")), 
          .Names = c("Qid", "Id", "Text", "Modified"), class = "data.frame", row.names = c(NA, -8L))
      
      expect_equal(zz, rest)
      
      # Now write new data to file and check it reads correctly
      
      xlwb <- loadWorkbook(xlFile)
      writeWorksheet(xlwb, data.frame(Modified=8:5), sheet=1, startRow=5, startCol=3)
      writeWorksheet(xlwb, data.frame(Modified=4:1), sheet=2, startRow=5, startCol=3)
      saveWorkbook(xlwb)
      zz2 <- readAllSheets(file=xlFile, .progress="none")
      
      rest2 <- structure(list(
              Qid = c("Q1", "Q1", "Q1", "Q1", "Q2", "Q2", "Q2", "Q2"), 
              Id = c("1", "2", "3", "4", "1", "2", "3", "4"), 
              Text = c("Yes", "No", "Yes", "Yes", "Per", "Aspera", "Ad", "Astra"), 
              Modified = c(8, 7, 6, 5, 4, 3, 2, 1)), 
          .Names = c("Qid", "Id", "Text", "Modified"), class = "data.frame", row.names = c(NA, -8L))
      
      expect_equal(zz2, rest2)
      
      
      xlwb <- loadWorkbook(xlFile)
      writeWorksheet(xlwb, data.frame(Modified=letters[1:4]), sheet=2, startRow=5, startCol=3)
      writeWorksheet(xlwb, data.frame(Modified=LETTERS[5:8]), sheet=1, startRow=5, startCol=3)
      saveWorkbook(xlwb)
      
      zz3 <- readAllSheets(file=xlFile, .progress="none")
      zz3
      
      rest3 <- structure(list(
              Qid = c("Q1", "Q1", "Q1", "Q1", "Q2", "Q2", "Q2", "Q2"), 
              Id = c("1", "2", "3", "4", "1", "2", "3", "4"), 
              Text = c("Yes", "No", "Yes", "Yes", "Per", "Aspera", "Ad", "Astra"), 
              Modified = c("E", "F", "G", "H", "a", "b", "c", "d")), 
          .Names = c("Qid", "Id", "Text", "Modified"), class = "data.frame", row.names = c(NA, -8L))
      
      expect_equal(zz3, rest3)
      
      
      unlink(xlFile)
    })

      
    
test_that("Import of all sheets in single workbook works", {
      # Create export file
      xlFile <- tempfile(fileext=".xlsx")
      writeQuestionExcel(ss, c("Q1", "Q2"), file=xlFile)
      expect_true(file.exists(xlFile))
      
      xlwb <- loadWorkbook(xlFile)
      writeWorksheet(xlwb, data.frame(Modified=letters[1:4]), sheet=2, startRow=5, startCol=3)
      writeWorksheet(xlwb, data.frame(Modified=LETTERS[5:8]), sheet=1, startRow=5, startCol=3)
      saveWorkbook(xlwb)
      
      newData <- readAllSheets(file=xlFile, .progress="none")
      
      load_all("surveydata")
      zz1 <- updateQuestion(ss, new=newData)
      
      rest1 <- structure(list(
              id = 1:4, 
              Q1 = structure(1:4, .Label = c("E", "F", "G", "H"), class = "factor"), 
              Q2 = structure(1:4, .Label = c("a", "b", "c", "d"), class = "factor"), 
              crossbreak = structure(c(1L, 1L, 2L, 2L), .Label = c("A", "B"), class = "factor"), 
              weight = c(0.9, 1.1, 0.8, 1.2)), 
          .Names = c("id", "Q1", "Q2", "crossbreak", "weight"), 
          row.names = c(NA, -4L), 
          variable.labels = structure(c("RespID", "Question 2", "Question 1", "crossbreak", "weight"), 
              .Names = c("id", "Q1", "Q2", "crossbreak", "weight")), 
          pattern = structure(list(sep = "_", exclude = "other"), 
              .Names = c("sep", "exclude")), class = c("surveydata", "data.frame"))

      expect_equal(zz1, rest1)
      
      
      xlwb <- loadWorkbook(xlFile)
      writeWorksheet(xlwb, data.frame(Modified=c("a", NA, "b", NA)), sheet=1, startRow=5, startCol=3)
      writeWorksheet(xlwb, data.frame(Modified=c(NA, NA, "C", "D")), sheet=2, startRow=5, startCol=3)
      saveWorkbook(xlwb)
      
      newData <- readAllSheets(file=xlFile, .progress="none")
      
      load_all("surveydata")
      zz2 <- updateQuestion(ss, new=newData)
      
      rest2 <- structure(list(
              id = 1:4, 
              Q1 = structure(c(1L, 3L, 2L, 4L), .Label = c("a","b", "No", "Yes"), class = "factor"), 
              Q2 = structure(c(4L, 1L, 2L, 3L), .Label = c("Aspera", "C", "D", "Per"), class = "factor"), 
              crossbreak = structure(c(1L, 1L, 2L, 2L), .Label = c("A", "B"), class = "factor"), 
              weight = c(0.9, 1.1, 0.8, 1.2)), 
          .Names = c("id", "Q1", "Q2", "crossbreak", "weight"), 
          row.names = c(NA, -4L), 
          variable.labels = structure(c("RespID", "Question 2", "Question 1", "crossbreak", "weight"), 
              .Names = c("id", "Q1", "Q2", "crossbreak", "weight")), 
          pattern = structure(list(sep = "_", exclude = "other"), 
              .Names = c("sep", "exclude")), class = c("surveydata", "data.frame"))
      
      expect_equal(zz2, rest2)
      
      zz3 <- updateQuestion(ss, file=xlFile)
      expect_equal(zz3, rest2)
#      print(zz2)
#      print(rest2)
#      print(dput(zz2))
      
      
    })
          
      
#      zz <- readQuestionExcel(files=xlFile, .progress="none")
#      traceback()
#      
#      zz
      
