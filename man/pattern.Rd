\name{pattern}
\alias{pattern}
\alias{pattern<-}
\title{Returns and updates pattern attribute.}
\usage{
  pattern(x)

  pattern(x) <- value
}
\arguments{
  \item{x}{surveydata object}

  \item{value}{New value}
}
\description{
  The pattern attribute defines a regular expression that
  identifies how column names are labelled.  It is not
  uncommon for survey software to use underscores to
  distinguish subquestions in a grid of questions, e.g.
  Q4_1, Q4_2, Q4_3, etc.
}
\details{
  The pattern attribute consists of a vector of length two:
  a prefix and a suffix.  When extracting question text,
  the pattern is concatenated with the question id as
  {prefix+qid+suffix} to search for a matching pattern.

  The default pattern consists of: prefix: "^" Indicating
  the start of the string suffix: "($|(_\\d+(_\\d+)*)$)"
  indicating either the end of string ($) or (underscore +
  digits followed by option underscore + digits)

  \code{pattern} returns the pattern attribute of data, and
  \code{pattern<-} updates the attribute.
}
\seealso{
  \code{\link{surveydata-package}}, \code{\link{which.q}},
  \code{\link{regexp}}
}

