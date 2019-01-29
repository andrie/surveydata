

#' @importFrom purrr map_chr
str_wrap_to_width <- function(x, width = 30) {
  map_chr(x, ~ paste(strwrap(., width = width), collapse = "\n"))
}

utils::globalVariables(c(".key", ".value"))
order_key_by_value <- function(data) {
  if (!is.factor(data$.key)) {
    data %>%
      arrange(.value) %>%
      mutate(.key = factor(.key, .key))
  } else {
    data
  }
}




#' Construct plot title from the question text, wrapping at the desired width.
#'
#' This creates a plot title using `[ggplot2::ggtitle()]`. The main title is string wrapped, and the subtitle is the number of observations in the data.
#'
#' @param data surveydata object
#' @param q Question
#' @param width Passed to [strwrap()]
#'
#' @export
survey_plot_title <- function(data, q, width = 50) {
  ggtitle(
    label = paste0(
      q, ": ",
      question_text_common(data, q)
    ) %>% str_wrap_to_width(50),
    subtitle = paste(
      "n =",
      data[, q] %>% filter(complete.cases(.)) %>% nrow()
    )
  )
}

utils::globalVariables(c("."))

#' Plot data in yes/no format.
#'
#' @inheritParams survey_plot_title
#'
#' @export
#' @family survey plotting functions
#' @example inst/examples/example-plots.R
survey_plot_yes_no <- function(data, q) {
  dat <- data[, q]
  single <- ncol(dat) == 1
  if (single) {
    sdat <- dat %>%
      mutate(.key = .[[1]]) %>%
      filter(!is.na(.key)) %>%
      group_by(.key) %>%
      summarise(.value = n()) %>%
      mutate(.value = .value / sum(.value))
  } else {
    sdat <- dat %>%
      map_df(function(x) sum(na.omit(x) == "Yes") / length(na.omit(x)))
    names(sdat) <- question_text_unique(data, q) %>% str_wrap_to_width(30)
    sdat <- gather(sdat) %>%
      arrange(.value) %>%
      mutate(.key = factor(.key, .key))
  }
  ggplot(sdat, aes(x = .key, y = .value)) +
    geom_point(colour = "blue") +
    scale_y_continuous(labels = scales::percent, limits = c(0, NA)) +
    coord_flip() +
    survey_plot_title(data, q) +
    xlab(NULL) +
    ylab(NULL)
}


#' Plots single and  as multi-response questions.
#'
#' @inheritParams survey_plot_title
#'
#' @export
#' @family survey plotting functions
#' @example inst/examples/example-plots.R
survey_plot_question <- function(data, q) {
  dat <- data[, q]
  dat %>%
    mutate(.key = .[[1]]) %>%
    select(.key) %>%
    filter(!is.na(.key)) %>%
    group_by(.key) %>%
    summarize(.value = n()) %>%
    mutate(.value = .value / sum(.value)) %>%
    order_key_by_value() %>%
    ggplot(aes(x = .key, y = .value)) +
    geom_point(colour = "blue") +
    coord_flip() +
    survey_plot_title(data, q) +
    scale_y_continuous(labels = scales::percent, limits = c(0, NA)) +
    xlab(NULL) +
    ylab(NULL)
}



# fun = function(x){
#   (sum(x %in% sats_levels[5:7]) - sum(x %in% sats_levels[1:3])) /
#     # (length(x) - sum(x %in% sats_levels[4]))
#     length(x)
# }, title = "Net satisfaction")
#
# plot_sats(resp, "Q18", fun = function(x){
#   sum(x %in% sats_levels[6:7]) / length(x)
# }, title = "Percentage in top 3 box")
#
# plot_sats(resp, "Q18", fun = function(x){
#   sum(x %in% sats_levels[6:7]) / length(x)
# }, title = "Percentage in top 2 box")


utils::globalVariables(c("sats", "aspect"))

#' Plot satisfaction questions.
#'
#' @inheritParams survey_plot_title
#' @param fun Aggregation function, one of `net` (compute net satisfaction score), `top3` (compute top 3 box score) and `top2` (compute top 2 box score)
#'
#' @export
#' @family survey plotting functions
#' @example inst/examples/example-plots.R
survey_plot_satisfaction <- function(data, q, fun = c("net", "top3", "top2")) {
  fun <- match.arg(fun)
  sats_levels <- levels(data[, q][[1]])
  fun <- switch(
    fun,
    net = function(x) {
      (sum(x %in% tail(sats_levels, 3)) - sum(x %in% head(sats_levels, 3))) / length(x)
    },
    top3 = function(x) sum(x %in% tail(sats_levels, 3)) / length(x),
    top2 = function(x) sum(x %in% sats_levels[6:7]) / length(x)
  )
  data.frame(
    sats = map_dbl(data[, q], fun),
    aspect = question_text_unique(data, q)
  ) %>%
    arrange(-sats) %>%
    mutate(aspect = factor(aspect, aspect)) %>%
    ggplot(aes(x = aspect, y = sats)) +
    geom_point(colour = "blue") +
    scale_y_continuous(
      breaks = seq(0, 1, by = 0.5),
      minor_breaks = seq(0, 1, by = 0.1),
      limits = c(0, 1)
    ) +
    coord_flip() +
    survey_plot_title(data, q) +
    xlab(NULL) +
    ylab(NULL)
}
