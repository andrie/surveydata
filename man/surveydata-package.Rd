\docType{package}
\name{surveydata-package}
\alias{"surveydata-package"}
\alias{surveydata}
\alias{surveydata-package}
\title{Tools, classes and methods to manipulate survey data.}
\description{
  Tools, classes and methods to manipulate survey data.
}
\details{
  Surveydata objects have been designed to function with
  SPSS export data, i.e. the result of an SPSS import,
  \code{read.spss()}.  This type of data is contained in a
  data.frame, with information about the questionnaire text
  in the \code{variable.labels} attribute.  Surveydata
  objects keep track of the variable labels, by offering
  methods for renaming, subsetting, etc.

  Coercion functions: \itemize{ \item
  \code{\link{as.surveydata}} \item
  \code{\link{is.surveydata}} \item
  \code{\link{as.data.frame.surveydata}} }

  To access and modify the variable.labels attribute:
  \code{\link{varlabels}}

  To subset or merge surveydata objects: \itemize{ \item
  \code{\link{merge}} \item \code{\link{extract}} }
}
\author{
  Andrie de Vries \email{andrie.de.vries@pentalibra.com}
}
\keyword{package}

