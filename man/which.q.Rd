\name{which.q}
\alias{questions}
\alias{which.q}
\title{Functions to identify columns corresponding to questions.}
\usage{
  which.q(x, Q, pat = pattern(x))

  questions(x, pattern = pattern(x))
}
\arguments{
  \item{Q}{Character string with question number, e.g.
  "Q2"}

  \item{x}{Object to coerce to surveydata}

  \item{pattern}{A character vector of length two,
  consisting of a prefix and suffix.  When subsetting based
  on question numbers, the prefix, question number and
  suffix forms a regex pattern that defines the pattern to
  extract valid question numbers.}
}
\description{
  Functions to identify columns corresponding to questions.
}
\keyword{tools}

