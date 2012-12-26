\name{questions}
\alias{questions}
\title{Returns a list of all the unique questions in the surveydata object.}
\usage{
  questions(x, ptn = pattern(x))
}
\arguments{
  \item{x}{Object to coerce to surveydata}

  \item{ptn}{A character vector of length two, consisting
  of a prefix and suffix.  When subsetting based on
  question numbers, the prefix, question number and suffix
  forms a regex pattern that defines the pattern to extract
  valid question numbers.  See \code{\link{pattern}} and
  \code{\link{which.q}} for more detail.}
}
\value{
  numeric vector
}
\description{
  In many survey systems, subquestions take the form Q1_a,
  Q1_b, with the main question and subquestion separated by
  an underscore. This function conveniently returns all of
  the main questions in a \code{\link{surveydata}} object.
  It does this by using the \code{\link{pattern}} attribute
  of the surveydata object.
}
\examples{
questions(membersurvey)
}
\seealso{
  which.q

  Other Question functions: \code{\link{qText}},
  \code{\link{qTextCommon}}, \code{\link{qTextUnique}},
  \code{\link{splitCommonUnique}}, \code{\link{which.q}}
}
\keyword{Questions}

