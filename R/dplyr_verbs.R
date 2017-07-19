#' Methods to support dplyr verbs.
#' @name dplyr-surveydata
#' @param .data surveydata object or tbl passed to dplyr verb
#' @param ... passed to dplyr verb
#' @keywords internal
#' 
#' @export
#' @importFrom stats setNames
#' @importFrom dplyr mutate
#' @examples 
#' library(dplyr)
#' membersurvey %>% as.tbl() %>% filter(Q2 == 2009)
mutate_.surveydata <- function(.data, ...){
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


#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr select_
select_.surveydata <- mutate_.surveydata


#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr filter_
filter_.surveydata <- mutate_.surveydata


#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr arrange_
arrange_.surveydata <- mutate_.surveydata


#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr summarize_
summarize_.surveydata <- mutate_.surveydata


#' @export
#' @rdname dplyr-surveydata
#' @importFrom dplyr slice_
slice_.surveydata <- mutate_.surveydata
