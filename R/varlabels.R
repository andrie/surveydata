# Defines varlabels methods
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Returns and updates variable.labels attribute of data.
#' 
#' \code{varlabels} returns the variable.labels attribute of data, and \code{varlabels<-} updates the attribute.
#' 
#' @usage varlabels(x)
#' @aliases varlabels varlabels<-
#' @param x surveydata object
#' @export varlabels 
#' @seealso \code{\link{surveydata-package}}
varlabels <- function(x){
  attr(x, "variable.labels")
}

#' @rdname varlabels
#' @usage varlabels(x) <- value
#' @param value New value
#' @export "varlabels<-"
"varlabels<-" <- function(x, value){
  attr(x, "variable.labels") <- value
  x
}

#------------------------------------------------------------------------------


#' Returns and updates pattern attribute.
#' 
#' \code{pattern} returns the pattern attribute of data, and \code{pattern<-} updates the attribute.
#' 
#' @usage pattern(x)
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
#' @export "pattern<-"
"pattern<-" <- function(x, value){
  attr(x, "pattern") <- value
  x
}

rm.pattern <- function(x){
  pattern(x) <- NULL
  x
}

rm.attrs <- function(x){
  pattern(x) <- NULL
  varlabels(x) <- NULL
}

