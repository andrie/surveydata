# Creates surveydata class and provides methods
# 
# Author: Andrie
###############################################################################

#' Coercion from and to surveydata.
#' 
#' Methods for creating "surveydata" objects, testing for class, and coercion from other objects.
#' 
#' @param x Object to coerce to surveydata
#' @export
#' @seealso \code{\link{package-surveydata}}, \code{\link{is.surveydata}}
as.surveydata <- function(x){
  class(x) <- "surveydata"
  x
}

#' Coerces surveydata object to data.frame
#' 
#' Coerces surveydata object to data.frame
#' 
#' @method as.data.frame surveydata
#' @param x Surveydata object to coerce to class data.frame
#' @seealso \code{\link{package-surveydata}}
as.data.frame.surveydata <- function(x){
  class(x) <- "data.frame"
  x
}

#' Tests whether an object is of class surveydata.
#' 
#' Tests whether an object is of class surveydata.
#' 
#' @param x Object to check for being of class surveydata
#' @method is surveydata
#' @seealso \code{\link{package-surveydata}}
#' @export 
is.surveydata <- function(x){
  inherits(x, "surveydata")
}

#' Returns variable.labels attribute of data.
#' 
#' Returns variable.labels attribute of data.
#' 
#' @param x surveydata object
#' @export
#' @seealso \code{\link{package-surveydata}}
varlabels <- function(x){
  attr(x, "variable.labels")
}

#' Updates variable.labels attribute of surveyordata.
#' 
#' Updates variable.labels attribute of surveyordata.
#' 
#' @name varlabels_replace
#' @usage varlabels(x) <- value
#' @param x surveydata object
#' @param value New value
#' @export "varlabels<-"
#' @aliases varlabels<- varlabels_replace
#' @seealso \code{\link{package-surveydata}}
"varlabels<-" <- function(x, value){
  attr(x, "variable.labels") <- value
  x
}


#' Extract or replace subsets of surveyordata.
#' 
#' Extract or replace subsets of surveyordata, ensuring that the varlabels stay in synch.
#' 
#' @param x surveydata object
#' @param name Names of columns
#' @param value New value
#' @usage x$name <- value
#' @name surveydata_replace
#' @aliases $<- surveydata_replace
#' @method "$<-" surveydata
#' @export "$<-"
#' @seealso \code{\link{package-surveydata}}
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



#' Updates names and variable.labels attribute of surveydata.
#' 
#' @param x surveydata object
#' @param value New names
#' @name names_replace
#' @usage names(x) <- value
#' @aliases names<- names_replace
#' @method "names<-" surveydata
#' @export "names<-"
#' @seealso \code{\link{package-surveydata}}, \code{\link{is.surveydata}}
"names<-.surveydata" <- function(x, value){
  xattr <- attributes(x)
  x <- as.data.frame(x)
  names(x) <- value
  x <- as.surveydata(x)
  names(attr(x, "variable.labels")) <- value
  x
}

#' Merges variable.labels attribute from two surveydata objects
#' 
#' Merges variable labels from two data objects.  The labels from dat1 takes precedence.
#' 
#' @param dat1 surveydata object
#' @param dat2 surveydata object
#' @param new_names A vector with names of the merged varlabels.  Defaults to the union of names of dat1 and dat2
#' @keywords internal
.merge_varlabels <- function(dat1, dat2, new_names=union(names(dat1), names(dat2))){
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
#' @param x Data frame
#' @param y Data frame
#' @param ... Other parameters passed to \code{\link{merge}}
#' @method merge surveydata
merge.surveydata <- function(x, y, ...){
  tmp <- merge(as.data.frame(x), as.data.frame(y), ...)
  newlabels <- .merge_varlabels(x, y, new_names=names(tmp))
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


##' Create list of questions in survey
##'
##' @param surveyor Surveyor object
##' @export 
##' @keywords tools
#question_list <- function(surveyor){
#  unique(gsub("_[[:digit:]]*(_other)?$", "", names(surveyor$q_data)))
#}
