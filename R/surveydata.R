# Creates surveydata class and provides methods
# 
# Author: Andrie
#------------------------------------------------------------------------------

#' Coercion from and to surveydata.
#' 
#' Methods for creating "surveydata" objects, testing for class, and coercion from other objects.
#' 
#' @param x Object to coerce to surveydata
#' @param pattern A regex pattern that defines the suffix of a question number
#' @export
#' @seealso \code{\link{surveydata-package}}, \code{\link{is.surveydata}}
as.surveydata <- function(x, pattern="(_[[:digit:]])*(_other)?$"){
  class(x) <- "surveydata"
  pattern(x) <- pattern
  x
}

#' Coerces surveydata object to data.frame
#' 
#' Coerces surveydata object to data.frame
#' 
#' @method as.data.frame surveydata
#' @param x Surveydata object to coerce to class data.frame
#' @seealso \code{\link{surveydata-package}}
as.data.frame.surveydata <- function(x){
  class(x) <- "data.frame"
  x
}

#' Tests whether an object is of class surveydata.
#' 
#' Tests whether an object is of class surveydata.
#' 
#' @param x Object to check for being of class surveydata
#' @seealso \code{\link{surveydata-package}}
#' @export 
is.surveydata <- function(x){
  inherits(x, "surveydata")
}

#------------------------------------------------------------------------------


#' Updates names and variable.labels attribute of surveydata.
#' 
#' @param x surveydata object
#' @param value New names
#' @name names
#' @aliases names names<- 
#' @usage "names(x) <- value"
#' @method "names<-" surveydata
#' @seealso \code{\link{surveydata-package}}, \code{\link{is.surveydata}}
"names<-.surveydata" <- function(x, value){
  xattr <- attributes(x)
  x <- as.data.frame(x)
  names(x) <- value
  x <- as.surveydata(x)
  names(attr(x, "variable.labels")) <- value
  x
}

#------------------------------------------------------------------------------

