# Defines varlabels methods
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Returns and updates variable.labels attribute of data.
#' 
#' \code{varlabels} returns the variable.labels attribute of data, and \code{varlabels(x) <- value} updates the attribute.
#' 
#' @param x surveydata object
#' @export  
#' @seealso \code{\link{surveydata-package}}
#' @family varlabels
varlabels <- function(x){
  attr(x, "variable.labels")
}

#' @rdname varlabels
#' @aliases varlabels<-
#' @export 
#' @family varlabels
"varlabels<-" <- function(x, value){
  attr(x, "variable.labels") <- value
  x
}

#------------------------------------------------------------------------------


#' Returns and updates pattern attribute.
#' 
#' \code{pattern} returns the pattern attribute of data, and \code{pattern<-} updates the attribute.
#' 
#' @aliases pattern pattern<-
#' @param x surveydata object
#' @export pattern 
#' @seealso \code{\link{surveydata-package}}
pattern <- function(x){
  attr(x, "pattern")
}

#' @rdname pattern
#' @usage pattern(x) <- value
#' @param value New value
#' @export pattern<-
"pattern<-" <- function(x, value){
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

