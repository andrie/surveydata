## ----options, echo=FALSE-------------------------------------------------
# from https://stackoverflow.com/questions/23114654/knitr-output-hook-with-an-output-lines-option-that-works-like-echo-26
library(knitr)
hook_output <- knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
   lines <- options$output.lines
   if (is.null(lines)) {
     return(hook_output(x, options))  # pass to default hook
   }
   x <- unlist(strsplit(x, "\n"))
   more <- "..."
   if (length(lines)==1) {        # first n lines
     if (length(x) > lines) {
       # truncate the output, but add ....
       x <- c(head(x, lines), more)
     }
   } else {
     x <- c(if (abs(lines[1])>1) more else NULL, 
            x[lines], 
            if (length(x)>lines[abs(length(lines))]) more else NULL
           )
   }
   # paste these lines together
   x <- paste(c(x, ""), collapse = "\n")
   hook_output(x, options)
 })

## ----load, message=FALSE-------------------------------------------------
library(surveydata)
library(dplyr)

## ----motivation, output.lines = 14---------------------------------------
sv <- membersurvey %>% as_tbl()
sv

## ----motivation-q2-------------------------------------------------------
sv[, "Q2"]

## ----motivation-q1-------------------------------------------------------
sv[, "Q2"]

## ----Setup---------------------------------------------------------------
library(surveydata)

## ----sample-data---------------------------------------------------------

sdat <- data.frame(
   id   = 1:4,
   Q1   = c("Yes", "No", "Yes", "Yes"),
   Q4_1 = c(1, 2, 1, 2), 
   Q4_2 = c(3, 4, 4, 3), 
   Q4_3 = c(5, 5, 6, 6), 
   Q10 = factor(c("Male", "Female", "Female", "Male")),
   crossbreak  = c("A", "A", "B", "B"), 
   weight      = c(0.9, 1.1, 0.8, 1.2)
)


## ----varlabels-----------------------------------------------------------

varlabels(sdat) <- c(
   "RespID",
   "Question 1", 
   "Question 4: red", "Question 4: green", "Question 4: blue", 
   "Question 10",
   "crossbreak",
   "weight"
)

## ----init----------------------------------------------------------------
sv <- as.surveydata(sdat, renameVarlabels = TRUE)

## ----extract-------------------------------------------------------------
sv[, "Q1"]
sv[, "Q4"]

## ----attributes----------------------------------------------------------

varlabels(sv)
pattern(sv)

## ----questions-----------------------------------------------------------
questions(sv)
which.q(sv, "Q1")
which.q(sv, "Q4")

## ----question_text-------------------------------------------------------
question_text(sv, "Q1")
question_text(sv, "Q4")

## ----qTextCommon---------------------------------------------------------
question_text_common(sv, "Q4")

## ----qTextUnique---------------------------------------------------------
question_text_unique(sv, "Q4")

