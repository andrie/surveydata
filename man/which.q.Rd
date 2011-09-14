\name{which.q}
\alias{questions}
\alias{which.q}
\title{Functions to identify columns corresponding to questions.}
\usage{
  which.q(x, Q, ptn = pattern(x))

  questions(x, ptn = pattern(x))
}
\arguments{
  \item{ptn}{A character vector of length two, consisting
  of a prefix and suffix.  When subsetting based on
  question numbers, the combination of prefix, question
  number and suffix forms a \code{\link{regex}} pattern
  that defines the pattern to extract valid question
  numbers.}

  \item{Q}{Character string with question number, e.g.
  "Q2"}

  \item{x}{Object to coerce to surveydata}
}
\description{
  Functions to identify columns corresponding to questions.
}
\seealso{
  Other Questions: \code{\link{qText}},
  \code{\link{qTextCommon}}, \code{\link{qTextUnique}}
}
\keyword{tools}

