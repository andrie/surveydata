# Subsetting code for surveydata objects
# 
# Author: Andrie
#------------------------------------------------------------------------------


#' Extract or replace subsets of surveydata.
#' 
#' Extract or replace subsets of surveydata, ensuring that the varlabels stay in synch.
#'
#' @name extract 
#' @aliases $<- $<-.surveydata
#' @param x surveydata object
#' @param name Names of columns
#' @param value New value
#' @method $<- surveydata
#' @usage \\method{$}{surveydata}(x, name) <- value
#' @export 
#' @seealso \code{\link{surveydata-package}}, \code{\link{varlabels}}
"$<-.surveydata" <- function(x, name, value){
  labels <- varlabels(x)
  if(is.null(value)){
    labels <- labels[names(labels)!=name]
  }
  if(length(grep(name, names(x)))==0){
    labels[name] <- name
  }  
  x <- as.data.frame(x)
  #x <- `$<-.data.frame`(x, name, value)
  x <- NextMethod("$<-")
  x <- as.surveydata(x, renameVarlabels=FALSE)
  varlabels(x) <- labels
  x
}

#' Extract a subset of surveydata.
#' 
#' @rdname extract
#' @param i row index
#' @param j column index
#' @param drop logical. Passed to \code{\link{[.data.frame}}. Note that the default is FALSE.
#' @param ... Other arguments passed to \code{[.data.frame}
#' @export 
#' @aliases [ [.surveydata
#' @method [ surveydata
"[.surveydata" <- function(x, i, j, drop=FALSE){
  has.i <- !missing(i)
  has.j <- !missing(j)
  
  if(!has.i & !has.j) return(x)
  
  #if(has.j && is.character(j)) j <- which.q(x, j) 
  if(has.j){ # && is.character(j)) {
    newname <- j
    if (is.character(j)) w <- which.q(x, j) else w <- j
    if(length(w)!=0) {
      j <- w
      name <- j
    } else {
      name <- newname
    }
    
  } else {
    newname <- i
    if (!is.character(i)) {
      w <- i
      name <- i
    } else { 
      w <- which.q(x, i)  
      if(length(w)!=0) {
        i <- w
        name <- i
      } else {
        name <- newname
      }
    }
  }
  xorig <- x
  #ret <- NextMethod("[") 
  ret <- NextMethod("[", drop=drop)
  #if(has.j) varlabels(ret) <- varlabels(xorig)[j] else varlabels(ret) <- varlabels(xorig)
  #if(has.j | has.i) varlabels(ret) <- varlabels(xorig)[name] else varlabels(ret) <- varlabels(xorig)
  varlabels(ret) <- varlabels(xorig)[name]
  as.surveydata(ret, ptn=pattern(xorig), renameVarlabels=FALSE)
}

#' Extract or replace subsets of surveydata.
#' 
#' Extract or replace subsets of surveydata, ensuring that the varlabels stay in synch.
#'
#' @rdname extract 
# @aliases $<- $<-.surveydata
#' @method [<- surveydata
#' @usage \\method{[}{surveydata}(x, i, j) <- value
#' @export 
#' @seealso \code{\link{surveydata-package}}, \code{\link{varlabels}}
"[<-.surveydata" <- function(x, i, j, value){
  
  has.i <- !missing(i)
  has.j <- !missing(j)
  if(has.j && is.character(j)) {
    newname <- j
    w <- which.q(x, j)
    if(length(w)!=0) {
      j <- w
      name <- j
    } else {
      name <- newname
    }
    
  } else {
    newname <- i
    w <- which.q(x, i)
    if(length(w)!=0) {
      i <- w
      name <- i
    } else {
      name <- newname
    }
  }
  
  xorig <- x
  
  labels <- varlabels(x)
  if(is.null(value)){
    #labels <- labels[names(labels)!=name]
    labels <- labels[-name]
  }
  #if(length(grep(name, names(x)))==0){
  if(length(w)==0){
    #labels <- c(labels, newname)
    labels[newname] <- newname
  }  
    
  #ret <- NextMethod("[") 
  ret <- NextMethod("[<-")
  if(has.j | has.i) varlabels(ret) <- varlabels(xorig)[j] else varlabels(ret) <- varlabels(xorig)
  x <- as.surveydata(ret, ptn=pattern(xorig), renameVarlabels=FALSE)
  varlabels(x) <- labels
  x
}


