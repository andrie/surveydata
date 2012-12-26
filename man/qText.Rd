\name{qText}
\alias{qText}
\title{Returns question text.}
\usage{
  qText(x, Q)
}
\arguments{
  \item{x}{A surveydata object}

  \item{Q}{The question id, e.g. "Q4"}
}
\value{
  character vector
}
\description{
  Given a question id, e.g. "Q4", returns question text for
  this question. Note that this returns. The functions
  \code{\link{qTextUnique}} and \code{\link{qTextCommon}}
  returns the unique and common components of the question
  text.
}
\examples{
questions(membersurvey)
qText(membersurvey, "Q1")
qText(membersurvey, "Q3")
qTextUnique(membersurvey, "Q3")
qTextCommon(membersurvey, "Q3")
}
\seealso{
  Other Question functions: \code{\link{qTextCommon}},
  \code{\link{qTextUnique}}, \code{\link{questions}},
  \code{\link{splitCommonUnique}}, \code{\link{which.q}}
}
\keyword{Questions}

