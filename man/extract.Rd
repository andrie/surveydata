\name{Extract}
\alias{$<-}
\alias{$<-.surveydata}
\alias{Extract}
\alias{[}
\alias{[.surveydata}
\alias{[<-.surveydata}
\title{Extract or replace subsets of surveydata, ensuring that the varlabels stay in synch.}
\usage{
  \method{[}{surveydata} (x, i, j, drop = FALSE)

  \method{[}{surveydata}(x, i, j) <- value

  \method{$}{surveydata}(x, name) <- value
}
\arguments{
  \item{i}{row index}

  \item{j}{column index}

  \item{drop}{logical. Passed to
  \code{\link{[.data.frame}}. Note that the default is
  FALSE.}

  \item{...}{Other arguments passed to \code{[.data.frame}}

  \item{x}{surveydata object}

  \item{name}{Names of columns}

  \item{value}{New value}
}
\description{
  The surveydata package makes it easy to extract specific
  questions from a surveydata object. Because survey data
  typically has question names like Q1_a, Q1_b, Q1_c the
  extract method for a surveydata object makes it easy to
  extract all columns by simply specifing "Q1" as the
  argument to the column index.
}
\details{
  Extraction is similar to data frames, with three
  important exceptions: \itemize{ \item{The column argument
  j is evaluated using \code{\link{which.q}} and will
  return all columns where the column names match the
  \code{\link{pattern}}.} \item{The drop argument is FALSE.
  Thus the result will always be a surveydata object, even
  if only a single column is returned.} \item{All
  extraction methods retain the \code{\link{pattern}} and
  \code{\link{varlabels}} arguments.} }
}
\examples{

names(membersurvey)
head(membersurvey["Q1"])
head(membersurvey[c("Q1", "Q2")])
head(membersurvey[membersurvey$Q2=="2009", c("Q1", "Q2")])

# The pattern is used to extract columns

pattern(membersurvey)

grep("Q20", names(membersurvey), value=TRUE)
head(membersurvey["Q20"])
head(membersurvey["Q20_other"])

}
\seealso{
  \code{\link{surveydata-package}}, \code{\link{varlabels}}
}

