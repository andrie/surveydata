\name{extract}
\alias{$<-}
\alias{$<-.surveydata}
\alias{[}
\alias{[.surveydata}
\alias{[<-.surveydata}
\alias{extract}
\title{Extract or replace subsets of surveydata.}
\usage{
  \\method{$}{surveydata}(x, name) <- value

  \method{[}{surveydata} (x, i, j, drop = FALSE)

  \\method{[}{surveydata}(x, i, j) <- value
}
\arguments{
  \item{x}{surveydata object}

  \item{name}{Names of columns}

  \item{value}{New value}

  \item{i}{row index}

  \item{j}{column index}

  \item{drop}{logical. Passed to
  \code{\link{[.data.frame}}. Note that the default is
  FALSE.}

  \item{...}{Other arguments passed to \code{[.data.frame}}
}
\description{
  Extract or replace subsets of surveydata, ensuring that
  the varlabels stay in synch.

  Extract a subset of surveydata.

  Extract or replace subsets of surveydata, ensuring that
  the varlabels stay in synch.
}
\seealso{
  \code{\link{surveydata-package}}, \code{\link{varlabels}}

  \code{\link{surveydata-package}}, \code{\link{varlabels}}
}

