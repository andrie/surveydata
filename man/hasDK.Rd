\name{hasDK}
\alias{hasDK}
\title{Tests whether levels contain "Don't know".}
\usage{
  hasDK(x, dk = "Don't Know")
}
\arguments{
  \item{x}{Character vector or Factor}

  \item{dk}{Character vector, containing search terms, e.g.
  c("Don't know", "Don't Know")}
}
\value{
  TRUE or FALSE
}
\description{
  Returns TRUE if x contains any instances of dk
}
\seealso{
  Other Functions to clean data: \code{\link{encToInt}},
  \code{\link{fixCommonEncodingProblems}},
  \code{\link{fixLevels01}}, \code{\link{fixLevels01R}},
  \code{\link{fixLevels01SPSS}}, \code{\link{intToEnc}},
  \code{\link{leveltestR}}, \code{\link{leveltestSPSS}},
  \code{\link{removeAllDK}}, \code{\link{removeDK}}
}
\keyword{"clean}
\keyword{data"}

