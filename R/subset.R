# TODO: Add comment
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

q_pattern <- function(Q, pat){
  paste(pat[1], Q, pat[2], sep="")
}


#' Functions to identify columns corresponding to questions.
#' 
#' @inheritParams as.surveydata
#' @aliases which.q questions
#' @param Q Character string with question number, e.g. "Q2"
which.q <- function(x, Q, pat=pattern(x)){
  grep(q_pattern(Q, pat), names(x))
}



#------------------------------------------------------------------------------

#' @rdname which.q
#' @inheritParams as.surveydata
#' @export 
#' @keywords tools
questions <- function(x, pattern=pattern(x)){
  unique(gsub(pattern, "", names(x)))
}

