#' Deprecated functions.
#'
#' @description
#' These functions have all been superseded with functions using `snake_case` function names.
#'
#' * `hasDK`: [has_dont_know()]
#' * `removeDK`: [remove_dont_know()]
#' * `removeAllDK`: [remove_all_dont_know()]
#' * `leveltestSPSS`: [leveltest_spss()]
#' * `leveltestR`: [leveltest_r()]
#' * `fixLevels01SPSS`: [fix_levels_01_spss()]
#' * `fixLevels01R`: [fix_levels_01_r()]
#' * `fixLevels01`: [fix_levels_01()]
#' * `qOrder`: [question_order()]
#' * `lapplyNames`: [lapply_names()]
#' * `fixCommonEncodingProblems`: [fix_common_encoding_problems()]
#'
#' @param ... passed to replacement function
#'
#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
hasDK <- function(...) {
  .Deprecated("has_dont_know")
  has_dont_know(...)
}

#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
removeDK <- function(...) {
  .Deprecated("remove_dont_know")
  remove_dont_know(...)
}

#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
removeAllDK <- function(...) {
  .Deprecated("remove_all_dont_know")
  remove_all_dont_know(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
leveltestSPSS <- function(...) {
  .Deprecated("leveltest_spss")
  leveltest_spss(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
leveltestR <- function(...) {
  .Deprecated("leveltest_r")
  leveltest_r(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
fixLevels01SPSS <- function(...) {
  .Deprecated("fix_levels_01_spss")
  fix_levels_01_spss(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
fixLevels01R <- function(...) {
  .Deprecated("fix_levels_01_r")
  fix_levels_01_r(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
fixLevels01 <- function(...) {
  .Deprecated("fix_levels_01")
  fix_levels_01(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
qOrder <- function(...) {
  .Deprecated("question_order")
  question_order(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
lapplyNames <- function(...) {
  .Deprecated("lapply_names")
  lapply_names(...)
}

#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
fixCommonEncodingProblems <- function(...) {
  .Deprecated(fix_common_encoding_problems)
  fix_common_encoding_problems(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
qText <- function(...) {
  .Deprecated("question_text")
  question_text(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
qTextUnique <- function(...) {
  .Deprecated("question_text_unique")
  question_text_unique(...)
}


#' @export
#' @keywords internal
#' @rdname surveydata-deprecated
qTextCommon <- function(...) {
  .Deprecated("question_text_common")
  question_text_common(...)
}


