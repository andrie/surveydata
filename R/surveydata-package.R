# package documentation
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Tools, classes and methods to manipulate survey data.
#'
#' Surveydata objects have been designed to function with SPSS export data, i.e. the result of an SPSS import,  [foreign::read.spss()].  This type of data is contained in a data.frame, with information about the questionnaire text in the `variable.labels` attribute.  Surveydata objects keep track of the variable labels, by offering methods for renaming, subsetting, etc.
#' 
#' Coercion functions:
#' * [as.surveydata()]
#' * [is.surveydata()]
#' * [as.data.frame.surveydata()]
#' 
#' To access and modify attributes:
#' * [pattern()]
#' * [varlabels()]
#' 
#' To subset or merge surveydata objects:
#' * [surveydata::merge()]
#' * [surveydata::Extract()] 
#' * [cbind.surveydata()]
#' 
#' To extract question text from varlabels:
#' * [qText()] 
#' * [qTextCommon()]
#' * [qTextUnique()] 
#' 
#' To fix common encoding problems:
#' * [encToInt()]
#' * [intToEnc()]
#' * [fixCommonEncodingProblems()]
#' 
#' To clean data:
#' * [removeDK()] to remove "Don't know" responses 
#' * [removeAllDK()] to remove "Don't know" responses from all questions
#' * [fixLevels01()] to fix level formatting of all question with Yes/No type answers
#' 
#' Miscellaneous tools:
#' * [dropout()] to determine questions where respondents drop out
#' 
#' 
#' @name surveydata-package
#' @aliases surveydata surveydata-package
#' @docType package
#' @importFrom plyr quickdf
#' @importFrom stringr str_trim
#' @importFrom stats na.omit
#' @importFrom utils localeToCharset
#' @title Tools, classes and methods to manipulate survey data.
#' @author Andrie de Vries \email{apdevries@@gmail.com}
#' @keywords package
#' 
#' @example /inst/examples/example-asSurveydata.R
#' @example /inst/examples/example-questions.R
NULL


#' Data frame with survey data of member satisfaction survey.
#' 
#' @docType data
#' @keywords datasets
#' @name membersurvey
#' @usage membersurvey
#' @format data frame
NULL

