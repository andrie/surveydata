# TODO: Add comment
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Extract or replace subsets of surveyordata.
#' 
#' Extract or replace subsets of surveyordata, ensuring that the varlabels stay in synch.
#' 
#' @name extract
#' @aliases  extract replace $<-.surveydata 
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

`[.surveydata` <- function(x, i, j, ...){
  has.j <- !missing(j)
  if(has.j && is.character(j)){
    j <- grep(paste(j, pattern(x), sep=""), names(x)) 
  }
  class(x) <- "data.frame"
  `[`(x, i, j, ...)
}

#whichq <- function(x, Q, pat=pattern(x)){
#  grep(paste(Q, pat, sep=""), names(x))
#}


#------------------------------------------------------------------------------

#' Create list of questions in survey
#'
#' @inheritParams as.surveydata
#' @export 
#' @keywords tools
question_list <- function(x, pattern=pattern(x)){
  unique(gsub(pattern, "", names(x)))
}

