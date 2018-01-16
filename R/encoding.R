#
#  surveydata/R/encoding.R by Andrie de Vries  Copyright (C) 2011-2017
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


#' Converts a character vector to an integer vector
#' 
#' Conversion of character vector to integer vector.  The encoding of the character vector can be specified but defaults to the current locale.  
#' 
#' @param x Character vector 
#' @param encoding A character string describing the encoding of x.  Defaults to the current locale.  See also [iconvlist()]
#' @return An integer vector
#' @seealso [iconv()]
#' @examples
#' encToInt("\\xfa")
#' @export 
#' @family Functions to clean data
#' @keywords encoding
encToInt <- function(x, encoding = localeToCharset()){
	utf8ToInt(iconv(x, from = encoding[1], to = "UTF-8"))
}

#' Converts an integer vector to a character vector.
#' 
#' Conversion of integer vector to character vector.  The encoding of the character vector can be specified but defaults to the current locale.  
#' 
#' @param x Integer vector
#' @inheritParams encToInt 
#' @return A character vector
#' @seealso [iconv()]
#' @examples
#' intToEnc(8212)
#' @export 
#' @family Functions to clean data
#' @keywords encoding
intToEnc <- function(x, encoding = localeToCharset()){
	iconv(intToUtf8(x), from = "UTF-8", to = encoding[1])
}

#' Fix common encoding problems when working with web imported data.
#' 
#' This function tries to resolve typical encoding problems when importing web data on Windows.
#' Typical problems occur with pound and emdash (-), especially when these originated in MS-Word.
#' 
#' @param x A character vector
#' @inheritParams encToInt 
#' @export
#' @family Functions to clean data
#' @keywords encoding
fix_common_encoding_problems <- function(x, encoding = localeToCharset()){
  # Define character constants that need to be replaced

  ps <- list(
    c(intToEnc(194, encoding = encoding), ""),
    c(intToEnc(128, encoding = encoding), ""),
    c(intToEnc(226, encoding = encoding), "-"),
    c(intToEnc(147, encoding = encoding), ""),
    c("^Missing$", "NA")
  )
  # Now perform the actual processing
  for(pt in ps){
    x <- gsub(pt[1], pt[2], x, useBytes = TRUE)
  }
  x 
}

