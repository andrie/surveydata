\name{removeDK}
\alias{removeDK}
\title{Removes "Don't know" from levels and replaces with NA.}
\usage{
  removeDK(x, dk = "Don't Know")
}
\arguments{
  \item{x}{Vector or Factor}

  \item{dk}{Character vector, containing search terms, e.g.
  c("Don't know", "Don't Know")}
}
\value{
  A factor with "Dont know" removed
}
\description{
  Tests the levels of x contain any instances of "Don't
  know".  If so, replaces these levels with NA
}
\seealso{
  Other Functions to clean data: \code{\link{encToInt}},
  \code{\link{fixCommonEncodingProblems}},
  \code{\link{fixLevels01}}, \code{\link{fixLevels01R}},
  \code{\link{fixLevels01SPSS}}, \code{\link{hasDK}},
  \code{\link{intToEnc}}, \code{\link{leveltestR}},
  \code{\link{leveltestSPSS}}, \code{\link{removeAllDK}}
}
\keyword{"clean}
\keyword{data"}

