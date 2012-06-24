# Defines varlabels methods
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Returns and updates variable.labels attribute of data.
#' 
#' \code{varlabels} returns the variable.labels attribute of data, and \code{varlabels(x) <- value} updates the attribute.
#' 
#' The \code{variable.labels} attribute is used by to store information about the original question text.  See \code{\link[foreign]{read.spss}} for details.
#' 
#' @param x surveydata object
#' @param value New value
#' @export  
#' @seealso \code{\link{surveydata-package}}
#' @family varlabels
varlabels <- function(x){
  attr(x, "variable.labels")
}

#' @rdname varlabels
#' @usage "varlabels(x) <- value"
#' @aliases varlabels<-
#' @export varlabels<-
#' @family varlabels
"varlabels<-" <- function(x, value){
  attr(x, "variable.labels") <- value
  x
}

#------------------------------------------------------------------------------


#' Returns and updates pattern attribute.
#' 
#' The pattern attribute defines a regular expression that identifies how column names are labelled.  It is not uncommon for survey software to use underscores to distinguish subquestions in a grid of questions, e.g. Q4_1, Q4_2, Q4_3, etc.
#' 
#' The pattern attribute consists of a vector of length two: a prefix and a suffix.  When extracting question text, the pattern is concatenated with the question id as {prefix+qid+suffix} to search for a matching pattern.
#' 
#' The default pattern consists of:
#' prefix: "^" Indicating the start of the string
#' suffix: "($|(_\\d+(_\\d+)*)$)" indicating either the end of string ($) or (underscore + digits followed by option underscore + digits)   
#' 
#' \code{pattern} returns the pattern attribute of data, and \code{pattern<-} updates the attribute.
#' 
#' @aliases pattern pattern<-
#' @param x surveydata object
#' @export pattern 
#' @seealso \code{\link{surveydata-package}}, \code{\link{which.q}}, \code{\link{regexp}}
pattern <- function(x){
  attr(x, "pattern")
}

#' @rdname pattern
#' @usage pattern(x) <- value
#' @param value New value
#' @export pattern<-
"pattern<-" <- function(x, value=c("^", "($|(_\\d+(_\\d+)*)$)")){
  attr(x, "pattern") <- value
  x
}


#' Removes pattern from attributes list.
#'
#' @param x Surveydata object
#' @keywords Internal
rm.pattern <- function(x){
  pattern(x) <- NULL
  x
}

#' Removes pattern and variable.labels from attributes list.
#'
#' @param x Surveydata object
#' @keywords Internal
rm.attrs <- function(x){
  attr(x, "pattern") <- NULL
  attr(x, "variable.labels") <- NULL
  x
}

