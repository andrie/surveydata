#' Print open text questions.
#'
#' @param data data
#' @param q Question number
#' @param cat If TRUE, prints results using `cat()`
#'
#' @family open text functions
#' @export
#' @examples
#' print_opentext(membersurvey, "Q33")
print_opentext <- function(data, q, cat = TRUE) {
  assert_that(is.surveydata(data))
  Q_number <- enquo(q)
  assert_that(is.character(q))

  r <- data %>%
    un_surveydata() %>%
    select(!!Q_number) %>%
    rename(txt = !!Q_number) %>%
    mutate(txt = as.character(txt)) %>%
    filter(!is.na(txt)) %>%
    mutate(
      txt = sQuote(txt)
    ) %>%
    distinct() %>%
    .[[1]]
  if (cat) {
    cat(r)
    invisible(r)
  } else {
    r
  }
}


utils::globalVariables(c("startlanguage", "txt"))

#' Converts free format question text to datatable using the `DT` package.
#'
#' @param data surveydata object
#' @param q Question
#'
#' @importFrom DT datatable
#'
#' @examples
#' as_opentext_datatable(membersurvey, "Q33")
#' @family open text functions
#' @export
as_opentext_datatable <- function(data, q) {
  assert_that(is.surveydata(data))
  Q_number <- enquo(q)
  assert_that(is.character(q))

  data %>%
    un_surveydata() %>%
    select(!!Q_number) %>%
    rename(txt = !!Q_number) %>%
    mutate(txt = as.character(txt)) %>%
    filter(!is.na(txt)) %>%
    mutate(
      txt = sQuote(txt)
    ) %>%
    distinct() %>%
    DT::datatable()
}

# as_opentext_datatable <- function(.data, Q_number){
#   Q_number <- enquo(Q_number)
#   .data %>%
#     un_surveydata() %>%
#     select(!!Q_number, startlanguage) %>%
#     rename(txt = !!Q_number, lang = startlanguage) %>%
#     filter(!is.na(txt) & nchar(txt) > 3) %>%
#     mutate(
#       nchar = nchar(txt),
#       # txt = gsub("\\.\n+", ". ", txt) %>% gsub("\n+", " ", .),
#       txt = sQuote(txt)
#     ) %>%
#     distinct() %>%
#     arrange(lang, -nchar) %>%
#     DT::datatable()
# }
