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


