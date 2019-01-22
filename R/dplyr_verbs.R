#' Methods to support dplyr verbs.
#' @name dplyr-surveydata
#' @param .data surveydata object or tbl passed to dplyr verb
#' @param ... passed to dplyr verb
#' @keywords internal
#' 
#' @export
#' @importFrom stats setNames
#' @importFrom dplyr mutate
#' @details The surveydata exposes functionality to support some of the dplyr verbs, e.g. [dplyr::filter()]
#' @examples 
#' library(dplyr)
#' membersurvey %>% as.tbl() %>% filter(Q2 == 2009)
mutate.surveydata <- function(.data, ...){
  var_labels <- varlabels(.data)
  z <- NextMethod(.data)
  same <- intersect(names(z), names(var_labels))
  new_labels <- var_labels[same]
  diff <- setdiff(names(z), names(var_labels))
  if (length(diff) > 0) {
    new_labels[diff] <- setNames(diff, diff)
  }
  new_labels <- new_labels[names(z)]
  varlabels(z) <- new_labels
  z <- as.surveydata(z)
  # class(z) <- c("surveydata", class(z))
  z
}

#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr select
#' @importFrom dplyr as.tbl
as.tbl.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr select
select.surveydata <- mutate.surveydata


#' @method filter surveydata
#' @export
#' @rdname dplyr-surveydata
filter.surveydata <- mutate.surveydata

#' @importFrom dplyr filter
#' @export filter
#' @rdname dplyr-surveydata
#' @name filter
#' @keywords internal
#' @inheritParams mutate.surveydata
NULL

#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr arrange
arrange.surveydata <- mutate.surveydata


#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr summarise
summarise.surveydata <- mutate.surveydata

#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr summarize
summarize.surveydata <- mutate.surveydata



#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr slice
slice.surveydata <- mutate.surveydata
