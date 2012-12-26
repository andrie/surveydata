# Question handling in surveydata objects

#
#  surveydata/R/questions.R by Andrie de Vries  Copyright (C) 2011-2012
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 or 3 of the License
#  (at your option).
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/
#


qPattern <- function(Q, ptn){
  paste0(ptn[1], Q, ptn[2])
}


#' Functions to identify columns corresponding to questions.
#' 
#' \code{which.q} returns the column indices that match a pattern.
#' \code{questions} returns a list of all the unique questions in the surveydata object.
#' 
#' Both functions utilise the \code{\link{pattern}} attribute of the surveydata object.
#' 
#' @inheritParams as.surveydata
#' @param ptn A character vector of length two, consisting of a prefix and suffix.  When subsetting based on question numbers, the combination of prefix, question number and suffix forms a \code{\link{regex}} pattern that defines the pattern to extract valid question numbers.
#' @aliases which.q questions
#' @family Questions
#' @keywords Questions
#' @export
#' @param Q Character string with question number, e.g. "Q2"
which.q <- function(x, Q, ptn=pattern(x)){
  if(!is.list(ptn))stop("ptn must be a list of two elements")
  num <- !is.na(suppressWarnings(as.numeric(Q)))
  chr <- !num
  whichQone <- function(qx){
    #grep(qPattern(qx, ptn), names(x))
#    browser()
    prefix <- "^"
    postfix <- sprintf("($|(%s.+$))", ptn$sep)
    pattern <- paste0(prefix, qx, postfix)
    w <- grep(pattern, names(x))
    w[names(x)[w] != paste0(qx, ptn[["sep"]], ptn[["exclude"]])]
  }
  if(any(num)) 
    x1 <- as.numeric(Q[which(num)])
  else
    x1 <- NULL
  if(any(chr)) {
    if(length(which(chr)) == 1L)
      ret <- whichQone(Q[chr])
    else 
      ret <- unname(sapply(Q[chr], whichQone))
    if(is.list(ret))
      x2 <- do.call(c, ret)
    else 
      x2 <- ret
  } else
    x2 <- NULL
  c(x1, x2)
}



#------------------------------------------------------------------------------

#' @rdname which.q
#' @inheritParams as.surveydata
#' @export 
#' @family Questions
#' @keywords Questions
questions <- function(x, ptn=pattern(x)){
  #unique(gsub(qPattern("(.*?)", ptn), "\\1", names(x)))
  
  n <- names(x)
  ptn1 <- sprintf(".*%s%s$", ptn[1], ptn[2])
  other <- grepl(ptn1, n)
  ptn2 <- sprintf("^(.*)(%s.*)+", ptn[1])
  n[!other] <- gsub(ptn2, "\\1", n[!other]) 
  unique(n)
}


#qs2 <- function(x, ptn=pattern(x)){
#  n <- names(x)
#  other <- grepl(".*_other$", n)
#  sep <- ptn[[1]]
#  ptn <- sprintf("^(.*)(%s.*)+", sep)
#  n[!other] <- gsub(ptn, "\\1", n[!other]) 
#  unique(n)
#}

#------------------------------------------------------------------------------

#' Returns question text.
#' 
#' Given a question id, e.g. "Q4", returns question text 
#'
#' @param x A surveydata object
#' @param Q The question id, e.g. Q4
#' @family Questions
#' @keywords Questions
#' @export 
qText <- function(x, Q){
  w <- which.q(x, Q)
  as.character(varlabels(x)[w])
}


#' Returns unique elements of question text.
#' 
#' Given a question id, e.g. Q4, finds all subquestions, e.g. Q4_1, Q4_2, etc, 
#' and returns the question text that is unique to each 
#'
#' @inheritParams qText
#' @keywords Questions
#' @export 
qTextUnique <- function(x, Q){
  text <- qText(x, Q)
  splitCommonUnique(text)$unique
}

#' Returns common element of question text.
#' 
#' Given a question id, e.g. Q4, finds all subquestions, e.g. Q4_1, Q4_2, etc, 
#' and returns the question text that is common to each 
#'
#' @inheritParams qText
#' @family Questions
#' @keywords Questions
#' @export 
qTextCommon <- function(x, Q){
  text <- qText(x, Q)
  splitCommonUnique(text)$common
}


#' Get common and unique text in question based on regex pattern identification
#' 
#' @param x A character vector
#' @family Questions
#' @keywords Questions
#' @param ptn A \code{\link{regex}} pattern that defines how the string should be split into common and unique elements
splitCommonUnique <- function(x, ptn=NULL){
  if(is.null(ptn)){
    ptn <- c(
        "^(.*)\\((.*)\\)$",                  # Find "Please tell us" in "Email (Please tell us)"
        "^(.*):\\s?(.*)$",                   # Find "What is your choice?" in "What is your choice?: Email"
        "^(.\\d*)[[(]\\d+[])]\\s?(.*)$",     # Find "Q3" in "Q3(001)Email" or "Q03[01] Email"
        "^\\[(.*)\\]\\s*(.*)$"               # Find "What is your choice?" in "[Email]What is your choice?"
            )
  }
  mostCommon <- function(x){
    r <- vapply(x, function(xt)sum(grepl(xt, x, fixed=TRUE)), 1)
    sort(r, decreasing=TRUE)[1]
  }
  pattern_sum <- vapply(ptn, function(p)sum(grepl(p, x)), 0, USE.NAMES=FALSE)
  if(max(pattern_sum) >= 1){
    which_patterns <- order(pattern_sum, decreasing=TRUE)[1]
    test_pattern <- ptn[which_patterns]
    xt <- str_match(x, test_pattern)
    r1 <- mostCommon(xt[, 2])
    r2 <- mostCommon(xt[, 3])
    
    if(unname(r1) > unname(r2)){
      t <- list(common=names(r1)[1], unique=str_trim(xt[, 3]))
    } else {  
      t <- list(common=names(r2)[1], unique=str_trim(xt[, 2]))
    }
    nNa <- sum(is.na(t$unique))  
    if(nNa > 0) t$unique[is.na(t$unique)] <- paste("NA_", seq_len(nNa), sep="")
  } else {
    t <- strCommonUnique(x)
  }  
  t
}