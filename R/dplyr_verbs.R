#' Methods to support dplyr verbs.
#' @rdname dplyr_verbs
#' @param .data surveydata object or tbl passed to dplyr verb
#' @param ... passed to dplyr verb
#' @export
#' @importFrom stats setNames
mutate.surveydata <- function(.data, ...){
  var_labels <- varlabels(.data)
  z <- NextMethod(.data)
  same <- intersect(names(z), names(var_labels))
  new_labels <- var_labels[same]
  diff <- setdiff(names(z), names(var_labels))
  if(length(diff) > 0){
    new_labels[diff] <- setNames(diff, diff)
  }
  new_labels <- new_labels[names(z)]
  varlabels(z) <- new_labels
  as.surveydata(z)
}

mutate_.surveydata <- mutate.surveydata


#' @export
#' @rdname dplyr_verbs
select.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr_verbs
select_.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr_verbs
filter.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr_verbs
filter_.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr_verbs
arrange.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr_verbs
arrange_.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr_verbs
summarize.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr_verbs
summarize_.surveydata <- mutate.surveydata
