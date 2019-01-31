# Functions to perform data cleanup


#
#  surveydata/R/cleandata.R by Andrie de Vries  Copyright (C) 2011-2017
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


# quickdf function modified from `plyr`
quickdf <- function(list) {
  rows <- unique(unlist(lapply(list, NROW)))
  stopifnot(length(rows) == 1)
  class(list) <- "data.frame"
  attr(list, "row.names") <- c(NA_integer_, -rows)
  list
}


# don't know --------------------------------------------------------------


#' Tests whether levels contain "Don't know".
#'
#' Returns TRUE if x contains any instances of dk
#'
#' @param x Character vector or factor
#' @param dk Character vector, containing search terms, e.g. `c("Don't know", "Don't Know")`
#' @return TRUE or FALSE
#' @export
#' @family Functions to clean data
#' @keywords "clean data"
has_dont_know <- function(x, dk = "Don't Know") {
  l <- if (is.factor(x)) levels(x) else unique(x)
  any(l %in% dk)
}


#' Removes "Don't know" from levels and replaces with NA.
#'
#' Tests the levels of x contain any instances of "Don't know".  If so, replaces these levels with `NA`
#'
#' @inherit has_dont_know
#' @return A factor with "Dont know" removed
#' @export
#' @family Functions to clean data
#' @keywords "clean data"
remove_dont_know <- function(x, dk = "Don't Know") {
  if (has_dont_know(x, dk)) {
    if (is.factor(x)) {
      l <- levels(x)
      l[which(levels(x) %in% dk)] <- NA
      x <- factor(x, levels = l)
    } else {
      pattern <- paste("^(", paste(dk, collapse = "|"), ").?$", sep = "")
      x <- gsub(pattern, "", x)
    }
  }
  x
}



#' Removes "Do not know" and other similar words from factor levels in data frame.
#'
#' Removes "Do not know" and other similar words from factor levels in data frame
#'
#' @param x List or data frame
#' @param dk Character vector, containing search terms, e.g. `c("Do not know", "DK")`.  These terms will be replaced by `NA`. If `NULL`, defaults to `c("I don't know", "Don't Know", "Don't know", "Dont know" , "DK")`
#' @param message If TRUE, displays message with the number of instances that were removed.
#'
#' @seealso [hasDK()] and [removeDK()]
#' @return A data frame
#' @export
#' @family Functions to clean data
#' @keywords "clean data"
remove_all_dont_know <- function(x, dk = NULL, message = TRUE) {
  if (is.null(dk)) {
    dk <- c("I don't know", "Don't Know", "Don't know", "Dont know", "DK")
  }
  newx <- lapply(x, remove_dont_know, dk)
  n1 <- sum(as.numeric(lapply(x, has_dont_know, dk)))
  n2 <- sum(as.numeric(lapply(newx, has_dont_know, dk)))
  dk <- paste(dk, collapse = ", ")
  if (message) {
    message(paste("Removed", n1 - n2, "instances of levels that equal [", dk, "]"))
  }
  ret <- quickdf(newx)
  attributes(ret) <- attributes(x)
  class(ret) <- class(x)
  ret
}



# leveltest ---------------------------------------------------------------


#' Fix level formatting of all question with Yes/No type answers.
#'
#' @param x surveydata object
#' @export
#' @family Functions to clean data
#' @keywords "clean data"
#' @name leveltest
leveltest_spss <- function(x) {
  ret <- FALSE
  if (inherits(x, "numeric")) {
    if (!is.null(attributes(x)$value.labels)) {
      if (all(attributes(x)$value.labels == c(1, 0))) {
        ret <- TRUE
      }
    }
  }
  ret
}


#' @export
#' @rdname leveltest
leveltest_r <- function(x) {
  ret <- FALSE
  if (inherits(x, "factor")) {
    if (length(levels(x)) == 2) {
      if (all(levels(x) == c("Yes", "Not selected"))) {
        ret <- TRUE
      }
    }
  }
  ret
}



# fix levels --------------------------------------------------------------


#' Fix level formatting of all question with Yes/No type answers.
#'
#' @param dat surveydata object
#' @export
#' @family Functions to clean data
#' @keywords "clean data"
#' @rdname fix_levels_01
fix_levels_01_spss <- function(dat) {
  ret <- lapply(dat, function(x) {
    if (leveltest_spss(x)) {
      x <- factor(x)
      levels(x) <- c("No", "Yes")
      x
    } else {
      x
    }
  })
  ret <- quickdf(ret)
  attributes(ret)$variable.labels <- varlabels(dat)
  ret
}


#' @export
#' @rdname fix_levels_01
fix_levels_01_r <- function(dat) {
  stopifnot(is.surveydata(dat))
  ret <- lapply(dat, function(x) {
    if (leveltest_r(x)) {
      levels(x) <- c("Yes", "No")
      x
    } else {
      x
    }
  })
  ret <- (ret)
  pattern(ret) <- pattern(dat)
  varlabels(ret) <- varlabels(dat)
  as.surveydata(ret)
}



#' @param origin Either `R` or `SPSS`
#' @export
fix_levels_01 <- function(dat, origin = c("R", "SPSS")) {
  origin <- match.arg(origin)
  switch(origin,
    "R" = fix_levels_01_r(dat),
    "SPSS" = fix_levels_01_spss(dat)
  )
}



# other -------------------------------------------------------------------


#' Changes vector to ordered factor, adding NA levels if applicable.
#'
#' @param x character vector
#' @export
#' @family Tools
question_order <- function(x) {
  # factor(x, level=levels(x), labels=levels(x), ordered=TRUE)
  if (any(is.na(x))) {
    addNA(ordered(x))
  } else {
    ordered(x)
  }
}


#' Applies function only to named elements of a list.
#'
#' This is useful to clean only some columns in a list (or `data.frame` or `surveydata` object). This is a simple wrapper around [lapply()] where only the named elements are changed.
#' @param x list
#' @param names character vector identifying which elements of the list to apply FUN
#' @param FUN function to apply.
#' @param ... additional arguments passed to `FUN`
#' @export
#' @family Tools
lapply_names <- function(x, names, FUN, ...) {
  oldClass <- class(x)
  index <- match(names, names(x))
  if (any(is.na(index))) {
    stop(paste("Names not found:", paste(names[is.na(index)], collapse = ", ")))
  }
  x <- unclass(x)
  x[index] <- lapply(x[index], FUN, ...)
  class(x) <- oldClass
  x
}
