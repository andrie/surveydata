\name{writeOneQuestionExcel}
\alias{writeOneQuestionExcel}
\title{Export surveydata answers to Excel worksheet.}
\usage{
  writeOneQuestionExcel(s, Q, wb, sheetname = Q, subset,
    colnames = c("Id", "Text", "Modified"))
}
\arguments{
  \item{s}{surveydata object}

  \item{Q}{question id}

  \item{wb}{Excel workbook, see also
  \code{\link[XLConnect]{loadWorkbook}}}

  \item{sheetname}{Name of worksheet}

  \item{subset}{logical expression indicating elements or
  rows to keep: missing values are taken as false}

  \item{colnames}{Column names of data frame (as written to
  Excel)}
}
\value{
  NULL
}
\description{
  Writes surveydata answers to worksheet in Excel.
}
\details{
  The worksheet is laid as follows: \describe{
  \item{A1}{Question id} \item{A2}{Question text}
  \item{A5:C5}{Data frame with columns qID, Original text
  and Modified text} }

  Requires the package \code{XLConnect}
}
\seealso{
  Other Export to Excel / Import from Excel:
  \code{\link{readAllSheets}},
  \code{\link{readOneQuestionExcel}},
  \code{\link{readQuestionExcel}},
  \code{\link{updateQuestion}},
  \code{\link{writeQuestionExcel}}
}

