common_verb <- function(z, var_labels) {
  same <- intersect(names(z), names(var_labels))
  new_labels <- var_labels[same]
  diff <- setdiff(names(z), names(var_labels))
  if (length(diff) > 0) {
    new_labels[diff] <- setNames(diff, diff)
  }
  nz <- names(z)
  new_labels <- new_labels[nz]
  varlabels(z) <- new_labels
  as.surveydata(z)
  
}

verb.surveydata <- function(.data, ...) {
  var_labels <- varlabels(.data)
  z <- NextMethod(.data)
  common_verb(z, var_labels)
}




#' Methods to support dplyr verbs.
#'
#' The `surveydata` package exposes functionality to support some of the `dplyr` verbs, e.g. [dplyr::filter()].  The computation is performed by `dplyr`, and the resulting object is of class `surveydata` (as well as the `dplyr` result).
#'
#' @name dplyr-surveydata
#' @param .data `surveydata` object or `tbl` passed to `dplyr` verb
#' @param ... passed to dplyr verb
#' @keywords internal
#'
#' @importFrom stats setNames
#' @example inst/examples/example-dplyr-verbs.R
NULL

#' @export
#' @rdname dplyr-surveydata
mutate.surveydata <- verb.surveydata


#' @export
#' @rdname dplyr-surveydata
as_tibble.surveydata <- function(x, ..., .name_repair, rownames) {
  var_labels <- varlabels(.data)
  z <- NextMethod(.data)
  common_verb(z, var_labels)
}
# as_tibble.surveydata <- verb.surveydata

#' @export
#' @rdname dplyr-surveydata
as.tbl.surveydata <- function(x, ...) {
  .Deprecated("as_tibble")
  as_tibble(x)
}


#' @export
#' @rdname dplyr-surveydata
select.surveydata <- verb.surveydata


#' @method filter surveydata
#' @export
filter.surveydata <- verb.surveydata

#' @importFrom dplyr filter
#' @export filter
#' @rdname dplyr-surveydata
#' @name filter
#' @keywords internal
NULL

#' @export
#' @rdname dplyr-surveydata
arrange.surveydata <- verb.surveydata


#' @export
#' @rdname dplyr-surveydata
summarise.surveydata <- verb.surveydata

#' @export
#' @rdname dplyr-surveydata
summarize.surveydata <- verb.surveydata



#' @export
#' @rdname dplyr-surveydata
slice.surveydata <- verb.surveydata
