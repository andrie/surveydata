\name{as.surveydata}
\alias{as.surveydata}
\title{Coercion from and to surveydata.}
\usage{
  as.surveydata(x, pattern = "(_[[:digit:]])*(_other)?$")
}
\arguments{
  \item{x}{Object to coerce to surveydata}

  \item{pattern}{A regex pattern that defines the suffix of
  a question number}
}
\description{
  Methods for creating "surveydata" objects, testing for
  class, and coercion from other objects.
}
\seealso{
  \code{\link{surveydata-package}},
  \code{\link{is.surveydata}}
}

