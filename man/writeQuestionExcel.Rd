\name{writeQuestionExcel}
\alias{writeQuestionExcel}
\title{Writes surveydata questions to Excel file.}
\usage{
  writeQuestionExcel(s, Q, file = NULL, delete = TRUE, ...)
}
\arguments{
  \item{file}{File name}

  \item{delete}{Logical. If TRUE, deletes file}

  \item{...}{Other arguments passed to
  writeOneQuestionExcel}

  \item{s}{surveydata object}

  \item{Q}{question id}
}
\description{
  Writes surveydata questions to Excel file.
}
\seealso{
  Other Export to Excel / Import from Excel:
  \code{\link{readAllSheets}},
  \code{\link{readOneQuestionExcel}},
  \code{\link{readQuestionExcel}},
  \code{\link{updateQuestion}},
  \code{\link{writeOneQuestionExcel}}
}

