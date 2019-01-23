# Question handling in surveydata objects

#
#  surveydata/R/questions.R by Andrie de Vries  Copyright (C) 2011-2017
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


qPattern <- function(Q, ptn) {
  paste0(ptn[1], Q, ptn[2])
}


#' Identifies the columns indices corresponding to a specific question.
#'
#' In many survey systems, sub-questions take the form "Q1_a", "Q1_b", with the main question and sub-question separated by an underscore. This function conveniently returns column index of matches found for a question id in a [surveydata] object. It does this by using the [pattern] attribute of the `surveydata` object.
#'
#' @inheritParams as.surveydata
#' @param Q Character string with question number, e.g. "Q2"
#' @seealso [questions()] to return all questions matching the [pattern()]
#' @family Question functions
#' @keywords Questions
#' @export
#' @example /inst/examples/example-questions.R
which.q <- function(x, Q, ptn = pattern(x)) {
  if (!is.list(ptn)) stop("ptn must be a list of two elements")
  num <- !is.na(suppressWarnings(as.numeric(Q)))
  chr <- !num
  whichQone <- function(qx) {
    prefix <- "^"
    postfix <- sprintf("($|(%s.+$))", ptn$sep)
    pattern <- paste0(prefix, qx, postfix)
    w <- grep(pattern, names(x))
    w[names(x)[w] != paste0(qx, ptn[["sep"]], ptn[["exclude"]])]
  }
  if (any(num)) {
    x1 <- as.numeric(Q[which(num)])
  } else {
    x1 <- NULL
  }
  if (any(chr)) {
    if (length(which(chr)) == 1L) {
      ret <- whichQone(Q[chr])
    } else {
      ret <- unname(sapply(Q[chr], whichQone))
    }
    if (is.list(ret)) {
      x2 <- do.call(c, ret)
    } else {
      x2 <- ret
    }
  } else {
    x2 <- NULL
  }
  c(x1, x2)
}



#' Returns a list of all the unique questions in the surveydata object.
#'
#' In many survey systems, sub-questions take the form Q1_a, Q1_b, with the main question and sub-question separated by an underscore. This function conveniently returns all of the main questions in a [surveydata()] object. It does this by using the [pattern()] attribute of the surveydata object.
#'
#' @inheritParams as.surveydata
#' @inheritParams which.q
#' @seealso which.q
#' @family Question functions
#' @keywords Questions
#' @export
#' @return numeric vector
#' @example /inst/examples/example-questions.R
questions <- function(x, ptn = pattern(x)) {
  n <- names(x)
  ptn1 <- sprintf(".*%s%s$", ptn[1], ptn[2])
  other <- grepl(ptn1, n)
  ptn2 <- sprintf("^(.*)(%s.*)+", ptn[1])
  n[!other] <- gsub(ptn2, "\\1", n[!other])
  unique(n)
}



#' Returns question text.
#'
#' Given a question id, e.g. "Q4", returns question text for this question. Note that this returns. The functions [question_text_unique()] and [question_text_common()] returns the unique and common components of the question text.
#'
#' @param x A surveydata object
#' @param Q The question id, e.g. "Q4". If not supplied, returns the text for all questions.
#'
#' @family Question functions
#' @keywords Questions
#' @export
#' @return character vector
#' @example /inst/examples/example-questions.R
question_text <- function(x, Q) {
  do_one <- function(q) {
    w <- which.q(x, q)
    as.character(varlabels(x)[w])
  }
  if (missing(Q) || is.null(Q)) {
    sapply(questions(x), do_one)
  } else {
    do_one(Q)
  }
}

#' @export
#' @rdname surveydata-deprecated
qText <- function(...) {
  .Deprecated("question_text")
  question_text(...)
}


#' Returns unique elements of question text.
#'
#' Given a question id, e.g. "Q4", finds all sub-questions, e.g. Q4_1, Q4_2, etc,
#' and returns the question text that is unique to each
#'
#' @inheritParams question_text
#' @family Question functions
#' @keywords Questions
#' @export
#' @return character vector
#' @example /inst/examples/example-questions.R
question_text_unique <- function(x, Q) {
  text <- question_text(x, Q)
  split_common_unique(text)$unique
}


#' @export
#' @rdname surveydata-deprecated
qTextUnique <- function(...) {
  .Deprecated("question_text_unique")
  question_text_unique(...)
}


#' Returns common element of question text.
#'
#' Given a question id, e.g. "Q4", finds all sub-questions, e.g. "Q4_1", "Q4_2", etc,
#' and returns the question text that is common to each.
#'
#' @inheritParams question_text
#' @family Question functions
#' @keywords Questions
#' @export
#' @return character vector
#' @example /inst/examples/example-questions.R
question_text_common <- function(x, Q) {
  text <- question_text(x, Q)
  split_common_unique(text)$common
}


#' @export
#' @rdname surveydata-deprecated
qTextCommon <- function(...) {
  .Deprecated("question_text_common")
  question_text_common(...)
}


#' Get common and unique text in question based on regex pattern identification
#'
#' @param x A character vector
#' @family Question functions
#' @keywords Questions
#' @importFrom dplyr mutate arrange slice
#' @param ptn A [regex()] pattern that defines how the string should be split into common and unique elements
split_common_unique <- function(x, ptn = NULL) {
  if (is.null(ptn)) {
    ptn <- c(
      # Find "Please tell us" in "Email (Please tell us)"
      "^(.+)\\s*\\((.+?)\\)$",
      # Find "Please tell (foo) us" in "Email (Please tell (foo) us)"
      "^(.+?)\\((.+)\\)$",
      # Find "What is your choice?" in "What is your choice?: Email"
      "^(.+)\\s*:\\s*(.+)$",
      # Find "Q3" in "Q3(001)Email" or "Q03[01] Email"
      "^(.+\\d+)\\s*[[(]\\d+[])]\\s?(.+)$",
      # Find "What is your choice?" in "[Email]What is your choice?"
      "^\\[(.+)\\]\\s*(.+)$",
      # Find "What is your choice?" in "What is your choice? [Email]"
      "^(.+?)\\s*\\[(.+)\\]$",
      "^(.+?_)(\\d+)"
    )
  }
  length_pattern <- function(ptn, x) {
    do_one <- function(n) length(unique(gsub(ptn, paste0("\\", n), x)))
    tibble(
      ptn = ptn,
      n = sum(grepl(ptn, x)),
      left = do_one(1),
      right = do_one(2)
    )
  }

  identify_pattern <- function(ptn, x) {
    left <- right <- n <- common <- NULL # R CMD check trick
    purrr::map_df(ptn, length_pattern, x) %>%
      mutate(
        common = pmin(left, right),
        unique = pmax(left, right),
        grep_c = if_else(left < right, "\\1", "\\2"),
        grep_u = if_else(left < right, "\\2", "\\1")
      ) %>%
      arrange(-n, common) %>%
      slice(1)
  }

  bp <- identify_pattern(ptn, x) # best pattern
  z <- list(
    common = gsub(bp$ptn, bp$grep_c, x)[1] %>% str_trim(),
    unique = gsub(bp$ptn, bp$grep_u, x) %>% str_trim()
  )
  nNa <- sum(is.na(z$unique))
  if (nNa > 0) z$unique[is.na(z$unique)] <- paste("NA_", seq_len(nNa), sep = "")
  z
}
