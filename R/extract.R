# Subsetting code for surveydata objects
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Extract or replace subsets of surveydata.
#' 
#' Extract or replace subsets of surveydata, ensuring that the varlabels stay in synch.
#' 
#' @name extract
#' @aliases  extract replace $<-.surveydata $<-
##' @usage x$name <- value 
#' @param x surveydata object
#' @param name Names of columns
#' @param value New value
#' @method $<- surveydata
#' @export 
#' @seealso \code{\link{surveydata-package}}
`$<-.surveydata` <- function(x, name, value){
  labels <- varlabels(x)
  x <- as.data.frame(x)
  x <- `$<-.data.frame`(x, name, value)
  x <- as.surveydata(x, renameVarlabels=FALSE)
  if(is.null(value)){
    labels <- labels[names(labels)!=name]
  } else {
    labels[name] <- name
  }  
  varlabels(x) <- labels
  x
}

#' Extract or replace subsets of surveydata.
#' 
#' Extract or replace subsets of surveydata, ensuring that the varlabels stay in synch.
#' 
#' rdname extract
#' @usage x[i, j, ...]
#' @param i row index
#' @param j column index
#' @param ... Other arguments passed to code{[.data.frame}
#' @export 
#' @aliases [.surveydata
#' @method [ surveydata
`[.surveydata` <- function(x, i, j, ...){
  has.j <- !missing(j)
  if(has.j && is.character(j)) j <- which.q(x, j) 
  xorig <- x
  #class(ret) <- "data.frame"
  ret <- NextMethod("[") ###`[`(ret, i, j, ...)
  if(has.j)varlabels(ret) <- varlabels(xorig)[j] else varlabels(ret) <- varlabels(xorig)
  as.surveydata(ret, ptn=pattern(xorig), renameVarlabels=FALSE)
}


