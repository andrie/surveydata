\name{merge}
\alias{merge}
\alias{merge.surveydata}
\title{Merge surveydata objects.}
\usage{
  \method{merge}{surveydata} (x, y, ...)
}
\arguments{
  \item{x}{surveydata object}

  \item{y}{surveydata object}

  \item{...}{Other parameters passed to
  \code{\link{merge}}}
}
\description{
  The base R merge will merge data but not all of the
  attributes.  This function also merges the
  variable.labels attribute.
}

