\name{readAllSheets}
\alias{readAllSheets}
\title{Reads all sheets in workbook.}
\usage{
  readAllSheets(file, .progress = "none", ...)
}
\arguments{
  \item{file}{File name to read}

  \item{.progress}{Type of progress bar to use, passed to
  \code{\link[plyr]{ldply}}}

  \item{...}{Other arguments passed to
  \code{\link{readOneQuestionExcel}}}
}
\value{
  data frame
}
\description{
  Reads all sheets in workbook.
}
\seealso{
  Other Export to Excel / Import from Excel:
  \code{\link{readOneQuestionExcel}},
  \code{\link{readQuestionExcel}},
  \code{\link{updateQuestion}},
  \code{\link{writeOneQuestionExcel}},
  \code{\link{writeQuestionExcel}}
}

