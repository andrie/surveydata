# Defines merge method
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Merges variable.labels attribute from two surveydata objects
#' 
#' Merges variable labels from two data objects.  The labels from dat1 takes precedence.
#' 
#' @param dat1 surveydata object
#' @param dat2 surveydata object
#' @param new_names A vector with names of the merged varlabels.  Defaults to the union of names of dat1 and dat2
#' @keywords internal
merge_varlabels <- function(dat1, dat2, new_names=union(names(dat1), names(dat2))){
  labels1 <- varlabels(dat1)
  labels2 <- varlabels(dat2)
  names(labels1) <- names(dat1)
  names(labels2) <- names(dat2)
  #merge(labels1, labels2)
  ret <- new_names
  names(ret) <- ret
  ret[names(labels2)] <- labels2
  ret[names(labels1)] <- labels1
  ret
}


#' Merge surveydata objects.
#' 
#' The base R merge will merge data but not all of the attributes.  This function also merges the variable.labels attribute.
#'
#' @name merge
#' @aliases merge merge.surveydata
#' @param x Data frame
#' @param y Data frame
#' @param ... Other parameters passed to \code{\link{merge}}
#' @method merge surveydata
merge.surveydata <- function(x, y, ...){
  tmp <- merge(as.data.frame(x), as.data.frame(y), ...)
  newlabels <- merge_varlabels(x, y, new_names=names(tmp))
  varlabels(tmp) <- newlabels
  as.surveydata(tmp)
}


##' Extract block of questions from surveyor object.
##'
##' @param surveyor Surveyor object
##' @param  extract Character vector of question names to extract
##' @export 
##' @keywords tools
#surveyor_extract <- function(surveyor, extract){
#  require(surveyor)
#  data <- surveyor$q_data
#  Qs   <- surveyor$q_text
#  qnames <- unlist(sapply(extract, 
#          function(qid){
#            tmp <- surveyor::get_q_text_unique(data, qid, Qs)
#            ifelse(tmp=="", Qs[qid], tmp)
#          }
#      )
#  )
#  cluster_pattern <- paste(paste("^", extract, "(_\\d*)*$", sep=""), collapse="|")
#  names(qnames) <- grep(cluster_pattern, names(data), value=TRUE) 
#  cdata <- data[, grep(cluster_pattern, names(data))]
#  attributes(cdata)$qtext <- qnames
#  names(cdata) <- names(qnames)
#  cdata
#}

