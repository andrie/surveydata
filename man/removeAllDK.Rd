\name{removeAllDK}
\alias{removeAllDK}
\title{Removes "Do not know" and other similar words from factor levels in data frame.}
\usage{
  removeAllDK(x, dk = NULL)
}
\arguments{
  \item{x}{List or data frame}

  \item{dk}{Character vector, containing search terms, e.g.
  c("Do not know", "DK").  These terms will be replaced by
  NA. If NULL, will default to c("I don't know", "Don't
  Know", "Don't know", "Dont know" , "DK")}
}
\value{
  A data frame
}
\description{
  Removes "Do not know" and other similar words from factor
  levels in data frame
}
\seealso{
  \code{\link{hasDK}} and \code{\link{removeDK}}

  Other Functions to clean data: \code{\link{encToInt}},
  \code{\link{fixCommonEncodingProblems}},
  \code{\link{fixLevels01}}, \code{\link{fixLevels01R}},
  \code{\link{fixLevels01SPSS}}, \code{\link{hasDK}},
  \code{\link{intToEnc}}, \code{\link{leveltestR}},
  \code{\link{leveltestSPSS}}, \code{\link{removeDK}}
}
\keyword{"clean}
\keyword{data"}

