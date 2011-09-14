################################################################################
###  String functions                                                        ###
################################################################################


#' Finds the common and unique elements in a character vector
#' 
#' Function takes a character string as input and find the common and
#' unique elements.  Assumes that the common element is at start of string
#' 
#' @param x Character vector
#' @return list of common and unique strings 
#' @keywords string
#' @export 
#' @examples
#' q_string <- c("Q_1", "Q_2", "Q_3") 
#' str_common_unique(q_string)$common
#' str_common_unique(q_string)$unique
str_common_unique <- function(x){
	x <- as.character(x)
	y <- x
	
	## Handles case with a single string element
	if (length(x) <= 1){
		return(list(common=x[1], unique=""))
	} 

	## Handles case where all elements are identical
	all_identical <- all(as.logical(lapply(x, function(f)x[1]==f)))
	if (all_identical){
		return(list(common=x[1], unique=rep("", length(x))))			
	}

	## Handles case where shortest element has length 0
	if (min(nchar(x))==0){
		return(list(common="", unique=x))
	}
	
	## Handles case where shortest element has length 1
	if (min(nchar(x))==1){
		x1 <- sapply(x, function(f){unlist(strsplit(f, NULL))[1]})
		all_identical <- all(as.logical(lapply(x1, function(f)x1[1]==f)))
		if (all_identical){
			return(
					list(common=substr(x[1], 1, 1), unique=substr(x, 2, nchar(x)))
			)			
		} else {
			return(
					list(common="", unique=x)
			)
		}	
	}
	
	
	# Make all strings the same length as shortest string
	x1 <- substr(x, 1, min(nchar(x)))
	# Create matrix of characters
	split <- lapply(x1, function(f){unlist(strsplit(f, NULL))})
	# Test which characters are identical
	identical <- sapply(split, function(f){f==split[[1]]}) ### aaply
	common <- apply(identical, 2, function(f){which(f==FALSE)[1]})  ### aaply
	mincommon <- min(common, na.rm=TRUE)-1
  #browser()
  if (mincommon <1){
		return(list(common="", unique=x))
	} else {
		return(list(
						common=substr(x[1], 1, mincommon),
						unique=substr(x, mincommon+1, nchar(x))
				))
	}
}


#' Wraps a string into separate lengths by inserting line breaks at word boundaries.
#'
#' @param x Character vector
#' @param len Length of new strings
#' @export
#' @keywords string
#' @examples
#' str_wrap("the quick brown fox jumps over the lazy dog", 10)  
str_wrap <- function(x, len=30)
{
	if (is.factor(x)){
		levels(x) <- vapply(
				levels(x),
				function(x) paste(strwrap(x ,width=len), collapse="\n"),
				"x", 
				USE.NAMES=FALSE
		)
		x
	} else {
		l <- vapply(
				unique(x),
				function(x) paste(strwrap(x ,width=len), collapse="\n"),
				"x",
				USE.NAMES=TRUE
		)
		unname(l[x])		
	}
}


#' Returns a string in reverse order
#'
#' @param x Character vector
#' @export
#' @keywords string
#' @examples
#' str_reverse("the quick brown fox jumps over the lazy dog")  
str_reverse <- function(x) {
	as.character(
			vapply(x, function(x){
				paste(rev(substring(x, 1:nchar(x), 1:nchar(x))), collapse="")
			}, "x")
	)
}


