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
  varlabels(x) <- labels
  as.surveydata(x, renameVarlabels=FALSE)
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
  name <- NULL
  mdrop <- missing(drop)
  Narg <- nargs() - (!mdrop) -1
  has.i <- !missing(i)
  has.j <- !missing(j)
  
  if(!has.i & !has.j) return(x)
  
  if(Narg >= 1L & has.j){ 
    name <- j
    if (is.character(j)) {
      w <- which.q(x, j) 
      if(length(w)!=0) {
        j <- name <- w
      }
    } else {
      name <- j
    }
  } else { #!has.j
    name <- seq_along(x)
  }
  
  if(Narg==1L & has.i) {
    name <- i
    if (is.character(i)) {
      w <- which.q(x, i)  
      if(length(w)!=0) {
        i <- name <- w
      } else {
        name <- i
      }
    } else { 
      name <- i
    } 
  } 
  #browser()
  
  ret <- NextMethod("[", drop=drop)
  #if(has.j) varlabels(ret) <- varlabels(xorig)[name]
  #if(exists("name")) varlabels(ret) <- varlabels(x)[name]
  varlabels(ret) <- varlabels(x)[name]
  as.surveydata(ret, ptn=pattern(x), renameVarlabels=FALSE)
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
    name <- j
  }
  
  xorig <- x
  
  labels <- varlabels(x)
  if(is.null(value)){
    labels <- labels[-name]
  }
  if(length(w)==0){
    labels[newname] <- newname
  }  
    
  ret <- NextMethod("[<-")
  if(has.j) varlabels(ret) <- varlabels(xorig)[j] else varlabels(ret) <- varlabels(xorig)
  varlabels(ret) <- labels
  as.surveydata(ret, ptn=pattern(xorig), renameVarlabels=FALSE)
}


