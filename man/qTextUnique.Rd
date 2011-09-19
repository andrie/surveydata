\name{qTextUnique}
\alias{qTextUnique}
\title{Returns unique elements of question text.}
\usage{
  qTextUnique(x, Q)
}
\arguments{
  \item{x}{A surveydata object}

  \item{Q}{The question id, e.g. Q4}
}
\description{
  Given a question id, e.g. Q4, finds all subquestions,
  e.g. Q4_1, Q4_2, etc, and returns the question text that
  is unique to each
}
\seealso{
  Other Questions: \code{\link{qText}},
  \code{\link{qTextCommon}}, \code{\link{questions}},
  \code{\link{splitCommonUnique}}, \code{\link{which.q}}
}

