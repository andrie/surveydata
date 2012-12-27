\name{which.q}
\alias{which.q}
\title{Identifies the columns indices corresponding to a specific question.}
\usage{
  which.q(x, Q, ptn = pattern(x))
}
\arguments{
  \item{Q}{Character string with question number, e.g.
  "Q2"}

  \item{x}{Object to coerce to surveydata}

  \item{ptn}{A list with two elements, \code{sep} and
  \code{exclude}.  See \code{\link{pattern}} and
  \code{\link{which.q}} for more detail. By default}
}
\description{
  In many survey systems, subquestions take the form Q1_a,
  Q1_b, with the main question and subquestion separated by
  an underscore. This function conveniently returns column
  index of matches found for a question id in a
  \code{\link{surveydata}} object. It does this by using
  the \code{\link{pattern}} attribute of the surveydata
  object.
}
\examples{
# Basic operations on a surveydata object, illustrated with the example dataset membersurvey

class(membersurvey)

questions(membersurvey)

which.q(membersurvey, "Q1")
which.q(membersurvey, "Q3")
which.q(membersurvey, c("Q1", "Q3"))

qText(membersurvey, "Q3")
qTextUnique(membersurvey, "Q3")
qTextCommon(membersurvey, "Q3")

# Extracting columns from a surveydata object

head(membersurvey[, "Q1"])
head(membersurvey["Q1"])
head(membersurvey[, "Q3"])
head(membersurvey[, c("Q1", "Q3")])

# Note that the result is always a surveydata object, even if only one column is extracted

head(membersurvey[, "id"])
str(membersurvey[, "id"])

}
\seealso{
  \code{\link{questions}} to return all questions matching
  the \code{\link{pattern}}

  Other Question functions: \code{\link{qText}},
  \code{\link{qTextCommon}}, \code{\link{qTextUnique}},
  \code{\link{questions}}, \code{\link{splitCommonUnique}}
}
\keyword{Questions}

