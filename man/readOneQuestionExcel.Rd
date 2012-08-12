\name{readOneQuestionExcel}
\alias{readOneQuestionExcel}
\title{Imports exported surveydata answers from Excel workbook.}
\usage{
  readOneQuestionExcel(wb, sheetname,
    colnames = c("Id", "Text", "Modified"))
}
\arguments{
  \item{wb}{Excel workbook, see also
  \code{\link[XLConnect]{loadWorkbook}}}

  \item{sheetname}{Name of worksheet}

  \item{colnames}{Column names of data frame (as written to
  Excel)}
}
\value{
  NULL
}
\description{
  Requires the package \code{XLConnect}
}
\seealso{
  Other Export to Excel / Import from Excel:
  \code{\link{readAllSheets}},
  \code{\link{readQuestionExcel}},
  \code{\link{updateQuestion}},
  \code{\link{writeOneQuestionExcel}},
  \code{\link{writeQuestionExcel}}
}

