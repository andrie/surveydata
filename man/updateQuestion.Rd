\name{updateQuestion}
\alias{updateQuestion}
\title{Updates surveydata answers with data imported from Excel workbook.}
\usage{
  updateQuestion(x, file, new = readQuestionExcel(file))
}
\arguments{
  \item{x}{surveydata object}

  \item{file}{Optional character vector of file names, each
  pointing to an Excel file to import. If supplied, then
  the files will be imported using
  \code{\link{readQuestionExcel}}}

  \item{new}{Data frame obtained from
  \code{\link{readQuestionExcel}}}
}
\value{
  surveydata object
}
\description{
  Requires the package \code{XLConnect}
}
\seealso{
  Other Export to Excel / Import from Excel:
  \code{\link{readAllSheets}},
  \code{\link{readOneQuestionExcel}},
  \code{\link{readQuestionExcel}},
  \code{\link{writeOneQuestionExcel}},
  \code{\link{writeQuestionExcel}}
}

