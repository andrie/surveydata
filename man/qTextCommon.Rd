\name{qTextCommon}
\alias{qTextCommon}
\title{Returns common element of question text.}
\usage{
  qTextCommon(x, Q)
}
\arguments{
  \item{x}{A surveydata object}

  \item{Q}{The question id, e.g. Q4}
}
\description{
  Given a question id, e.g. Q4, finds all subquestions,
  e.g. Q4_1, Q4_2, etc, and returns the question text that
  is common to each
}
\seealso{
  Other Questions: \code{\link{qText}},
  \code{\link{qTextUnique}}, \code{\link{questions}},
  \code{\link{splitCommonUnique}}, \code{\link{which.q}}
}
\keyword{Questions}

