# package documentation
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Tools, classes and methods to manipulate survey data.
#'
#' Surveydata objects have been designed to function with SPSS export data, i.e. the result of an SPSS import,  \code{read.spss()}.  This type of data is contained in a data.frame, with information about the questionnaire text in the \code{variable.labels} attribute.  Surveydata objects keep track of the variable labels, by offering methods for renaming, subsetting, etc.
#' 
#' Coercion functions:
#' \itemize{
#' \item \code{\link{as.surveydata}} 
#' \item \code{\link{is.surveydata}} 
#' \item \code{\link{as.data.frame.surveydata}} 
#' }
#' 
#' To access and modify attributes:
#' \itemize{
#' \item \code{\link{pattern}}
#' \item \code{\link{varlabels}}
#' }
#' 
#' To subset or merge surveydata objects:
#' \itemize{
#' \item \code{\link[surveydata]{merge}} 
#' \item \code{\link[surveydata]{extract}} 
#' }
#' 
#' To extract question text from varlabels:
#' \itemize{
#' \item \code{\link[surveydata]{qText}} 
#' \item \code{\link[surveydata]{qTextCommon}} 
#' \item \code{\link[surveydata]{qTextUnique}} 
#' }
#' 
#' Functions to fix common encoding problems:
#' \itemize{
#' \item \code{\link[surveydata]{entToInc}} 
#' \item \code{\link[surveydata]{incToEnt}} 
#' \item \code{\link[surveydata]{fixCommonEncodingProblems}}
#' }
#' 
#' Functions to clean data:
#' \itemize{
#' \item \code{\link[surveydata]{removeDK}} to remove "Don't know" responses 
#' \item \code{\link[surveydata]{removeAllDK}} to remove "Don't know" responses from all questions
#' \item \code{\link[surveydata]{fixLevels01}} to fix level formatting of all question with Yes/No type answers
#' }
#' 
#' 
#' @name surveydata-package
#' @aliases surveydata surveydata-package
#' @docType package
#' @import stringr
#' @title Tools, classes and methods to manipulate survey data.
#' @author Andrie de Vries \email{andrie@@pentalibra.com}
#' @keywords package
#' 
#' @example /inst/examples/example.R
NULL

#' Prints message on loading package.
#' 
#' @rdname onLoad
#' @keywords internal
.onLoad <- function(libname, pkgname){
    packageStartupMessage("The surveydata package is experimental: function syntax may change in future versions.\n")
}