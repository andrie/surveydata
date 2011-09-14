\name{as.surveydata}
\alias{as.surveydata}
\title{Coercion from and to surveydata.}
\usage{
  as.surveydata(x, ptn = c("^", "(_[[:digit:]])*(_.*)?$"))
}
\arguments{
  \item{x}{Object to coerce to surveydata}

  \item{ptn}{A character vector of length two, consisting
  of a prefix and suffix.  When subsetting based on
  question numbers, the prefix, question number and suffix
  forms a regex pattern that defines the pattern to extract
  valid question numbers.}
}
\description{
  Methods for creating "surveydata" objects, testing for
  class, and coercion from other objects.
}
\seealso{
  \code{\link{surveydata-package}},
  \code{\link{is.surveydata}}
}

