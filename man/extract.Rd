\name{extract}
\alias{"$<-"}
\alias{"$<-.surveydata"}
\alias{"[.surveydata"}
\alias{[.surveydata}
\alias{extract}
\alias{replace}
\title{Extract or replace subsets of surveydata.}
\usage{
  x$name <- value

  x[i, j, ...]
}
\arguments{
  \item{x}{surveydata object}

  \item{name}{Names of columns}

  \item{value}{New value}

  \item{i}{row index}

  \item{j}{column index}

  \item{...}{Other arguments passed to code{[.data.frame}}
}
\description{
  Extract or replace subsets of surveydata, ensuring that
  the varlabels stay in synch.

  Extract or replace subsets of surveydata, ensuring that
  the varlabels stay in synch.
}
\seealso{
  \code{\link{surveydata-package}}
}

