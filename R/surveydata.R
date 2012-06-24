# Creates surveydata class and provides methods
# 
# Author: Andrie
#------------------------------------------------------------------------------

#' Coercion from and to surveydata.
#' 
#' Methods for creating "surveydata" objects, testing for class, and coercion from other objects.
#' 
#' @param x Object to coerce to surveydata
#' @param sep Separator between question and subquestion names
#' @param exclude Excludes from pattern search
#' @param ptn A character vector of length two, consisting of a prefix and suffix.  When subsetting based on question numbers, the prefix, question number and suffix forms a regex pattern that defines the pattern to extract valid question numbers.  See \code{\link{pattern}} and \code{\link{which.q}} for more detail.
#' @param defaultPtn The default for ptn, if it does't exist in the object that is being coerced.
#' @param renameVarlabels If TRUE, turns variable.labels attribute into a named vector, using \code{names(x)} as names.
#' @export
#' @seealso \code{\link{surveydata-package}}, \code{\link{is.surveydata}}
as.surveydata <- function(x, sep="_", exclude="other", ptn=pattern(x),  
    defaultPtn=list(sep=sep, exclude=exclude), renameVarlabels=FALSE){
  #if(!is.list(ptn)) stop("ptn must be a list with elements sep and exclude")
  if(!is.list(defaultPtn)) stop("defaultPtn must be a list with elements sep and exclude")
  if(is.null(ptn)) ptn <- defaultPtn
  if(!inherits(x, "surveydata")) class(x) <- c("surveydata", class(x))
  if(renameVarlabels) names(varlabels(x)) <- names(x)
  pattern(x) <- ptn
  x
}
#as.surveydata <- function(x, ptn=pattern(x), defaultPtn=c("^", "($|(_\\d+(_\\d+)*)$)"), renameVarlabels=FALSE){
#  if(is.null(ptn)) ptn <- defaultPtn
#  if(!inherits(x, "surveydata")) class(x) <- c("surveydata", class(x))
#  if(renameVarlabels) names(varlabels(x)) <- names(x)
#  pattern(x) <- ptn
#  x
#}

#' Coerces surveydata object to data.frame.
#' 
#' Coerces surveydata object to data.frame
#' 
#' @method as.data.frame surveydata
#' @aliases as.data.frame.surveydata as.data.frame
#' @export 
#' @param x Surveydata object to coerce to class data.frame
#' @param ... ignored
#' @param rm.pattern If TRUE removes \code{\link{pattern}} attributes from x
#' @seealso \code{\link{surveydata-package}}
as.data.frame.surveydata <- function(x, ... , rm.pattern=FALSE){
  stopifnot(is.surveydata(x))
  if(rm.pattern) pattern(x) <- NULL
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

#------------------------------------------------------------------------------


#' Updates names and variable.labels attribute of surveydata.
#' 
#' @param value New names
#' @name names
#' @aliases names names<- 
#' @usage names(x) <- value
#' @param x surveydata object
#' @method `names<-` surveydata
#' @seealso \code{\link{surveydata-package}}, \code{\link{is.surveydata}}
`names<-.surveydata` <- function(x, value){
  xattr <- attributes(x)
  ret <- as.data.frame(x)
  names(ret) <- value
  ret <- as.surveydata(ret, ptn=pattern(x))
  names(attr(ret, "variable.labels")) <- value
  ret
}

#------------------------------------------------------------------------------

