\name{varlabels}
\alias{"varlabels<-"}
\alias{varlabels}
\alias{varlabels<-}
\title{Returns and updates variable.labels attribute of data.}
\usage{
  varlabels(x)
}
\arguments{
  \item{x}{surveydata object}
}
\description{
  \code{varlabels} returns the variable.labels attribute of
  data, and \code{varlabels(x) <- value} updates the
  attribute.
}
\details{
  The \code{variable.labels} attribute is used by to store
  information about the original question text.  See
  \code{\link[foreign]{read.spss}} for details.
}
\seealso{
  \code{\link{surveydata-package}}
}

