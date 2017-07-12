# @export
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


# @export
select.surveydata <- mutate.surveydata
select_.surveydata <- mutate.surveydata

# @export
filter.surveydata <- mutate.surveydata
filter_.surveydata <- mutate.surveydata

# @export
arrange.surveydata <- mutate.surveydata
arrange_.surveydata <- mutate.surveydata

# @export
summarize.surveydata <- mutate.surveydata
summarize_.surveydata <- mutate.surveydata
