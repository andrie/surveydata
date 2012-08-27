# 
# Author: andrie
###############################################################################

#' Calculates at which questions repondents drop out.
#' 
#' The number of respondents for each question is calculated as the length of the vector, after omitting NA values.
#' 
#' @param x surveydata object, list or data.frame
#' @param summary If TRUE, returns a shortened vector that contains only the points where respondents drop out. Otherwise, returns the number of respondents for each question.
#' @return Named numeric vector of respondent counts
#' @export 
#' @examples
#' dropout(membersurvey[-(127:128)])
dropout <- function(x, summary=TRUE){
  len <- sapply(x, function(xx)length(na.omit(xx)))
  ll <- rev(cummax(rev(len)))
  len[c(1, 1+which(diff(ll) != 0))]
}

