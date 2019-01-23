# Creates surveydata class and provides methods

#
#  surveydata/R/surveydata.R by Andrie de Vries  Copyright (C) 2011-2017
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


#' Coercion from and to surveydata.
#'
#' Methods for creating `surveydata` objects, testing for class, and coercion from other objects.
#'
#' The function`un_surveydata()` removes the `surveydata` class from the object, leaving intact the other classes, e.g. `data.frame` or `tibble`
#'
#' @param x Object to coerce to surveydata
#' @param sep Separator between question and subquestion names
#' @param exclude Excludes from pattern search
#' @param ptn A list with two elements, `sep` and `exclude`.  See [pattern()] and [which.q()] for more detail.
#' @param defaultPtn The default for `ptn`, if it doesn't exist in the object that is being coerced.
#' @param renameVarlabels If TRUE, turns variable.labels attribute into a named vector, using `names(x)` as names.
#' @export
#' @seealso [surveydata-package], [is.surveydata()]
#' @example /inst/examples/example-asSurveydata.R
#' @example /inst/examples/example-questions.R
as.surveydata <- function(x, sep = "_", exclude = "other", ptn = pattern(x),
                          defaultPtn = list(sep = sep, exclude = exclude), renameVarlabels = FALSE) {
  if (!is.list(defaultPtn)) stop("defaultPtn must be a list with elements sep and exclude")

  if (is.null(ptn)) ptn <- defaultPtn
  if (!inherits(x, "surveydata")) class(x) <- c("surveydata", class(x))
  if (renameVarlabels) names(varlabels(x)) <- names(x)
  if (length(x) != length(varlabels(x))) {
    warning("surveydata: varlabels must have same length as object")
  }
  if (!isTRUE(all.equal(names(x), names(varlabels(x))))) {
    warning("surveydata: names and varlabel names must match")
  }
  pattern(x) <- ptn
  x
}

#' @export
#' @rdname as.surveydata
un_surveydata <- function(x) {
  class(x) <- setdiff(class(x), "surveydata")
  x
}



#' Coerces surveydata object to data.frame.
#'
#' @method as.data.frame surveydata
#' @aliases as.data.frame.surveydata as.data.frame
#' @export
#' @param x Surveydata object to coerce to class data.frame
#' @param ... ignored
#' @param rm.pattern If TRUE removes [pattern()] attributes from x
#' @seealso [surveydata-package]
as.data.frame.surveydata <- function(x, ..., rm.pattern = FALSE) {
  stopifnot(is.surveydata(x))
  if (rm.pattern) pattern(x) <- NULL
  class(x) <- "data.frame"
  x
}

#' Tests whether an object is of class surveydata.
#'
#' @param x Object to check for being of class surveydata
#' @seealso [surveydata-package]
#' @export
is.surveydata <- function(x) {
  if (length(x) != length(varlabels(x))) {
    warning("surveydata: varlabels must have same length as object")
  }
  if (!isTRUE(all.equal(names(x), names(varlabels(x))))) {
    warning("surveydata: names and varlabel names must match")
  }
  inherits(x, "surveydata")
}



#' Updates names and variable.labels attribute of surveydata.
#'
#' @rdname names
#' @aliases names<- names<-.surveydata
#' @param x surveydata object
#' @param value New names
#' @export
#' @seealso [surveydata-package()], [is.surveydata()]
`names<-.surveydata` <- function(x, value) {
  xattr <- attributes(x)
  ret <- as.data.frame(x)
  names(ret) <- value
  names(attr(ret, "variable.labels")) <- value
  as.surveydata(ret, ptn = pattern(x))
}
