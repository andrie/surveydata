# Subsetting code for surveydata objects
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Extract or replace subsets of surveyordata.
#' 
#' Extract or replace subsets of surveyordata, ensuring that the varlabels stay in synch.
#' 
#' @name extract
#' @aliases  extract replace $<-.surveydata subset [.surveydata
#' @param x surveydata object
#' @param name Names of columns
#' @param value New value
#' @usage "x$name <- value"
#' @name surveydata_replace
#' @method "$<-" surveydata
#' @seealso \code{\link{surveydata-package}}
`$<-.surveydata` <- function(x, name, value){
  labels <- varlabels(x)
  x <- as.data.frame(x)
  x <- `$<-.data.frame`(x, name, value)
  x <- as.surveydata(x)
  if(is.null(value)){
    labels <- labels[names(labels)!=name]
  } else {
    labels[name] <- name
  }  
  varlabels(x) <- labels
  x
}

#' @rdname extract
#' @export [.surveydata
#' @usage `x[i, j, ...]`
`[.surveydata` <- function(x, i, j, ...){
  has.j <- !missing(j)
  if(has.j && is.character(j)) j <- which.q(x, j) 
  class(x) <- "data.frame"
  `[`(x, i, j, ...)
}


