\name{readQuestionExcel}
\alias{readQuestionExcel}
\title{Imports exported surveydata answers from Excel workbook.}
\usage{
  readQuestionExcel(files, showMessages = TRUE,
    .progress = c("tk", "none", "win"), ...)
}
\arguments{
  \item{files}{Character vector of file names to read}

  \item{showMessages}{If TRUE, displays a message for each
  file that get processed}

  \item{.progress}{Type of progress bar to use, passed to
  \code{\link[plyr]{ldply}}}

  \item{...}{Other arguments passed to
  \code{\link{readAllSheets}} and
  \code{\link{readOneQuestionExcel}}}
}
\value{
  data frame
}
\description{
  Requires the package \code{XLConnect}
}
\seealso{
  Other Export to Excel / Import from Excel:
  \code{\link{readAllSheets}},
  \code{\link{readOneQuestionExcel}},
  \code{\link{updateQuestion}},
  \code{\link{writeOneQuestionExcel}},
  \code{\link{writeQuestionExcel}}
}

