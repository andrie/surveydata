# Creates surveydata class and provides methods
# 
# Author: Andrie
#------------------------------------------------------------------------------

#' Coercion from and to surveydata.
#' 
#' Methods for creating "surveydata" objects, testing for class, and coercion from other objects.
#' 
#' @param x Object to coerce to surveydata
#' @export
#' @seealso \code{\link{surveydata-package}}, \code{\link{is.surveydata}}
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



##' Create list of questions in survey
##'
##' @param surveyor Surveyor object
##' @export 
##' @keywords tools
#question_list <- function(surveyor){
#  unique(gsub("_[[:digit:]]*(_other)?$", "", names(surveyor$q_data)))
#}
