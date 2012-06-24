\name{encToInt}
\alias{encToInt}
\title{Converts a character vector to an integer vector}
\usage{
  encToInt(x, encoding = localeToCharset())
}
\arguments{
  \item{x}{Character vector}

  \item{encoding}{A character string describing the
  encoding of x.  Defaults to the current locale.  See also
  \code{\link{iconvlist}}}
}
\value{
  An integer vector
}
\description{
  Conversion of character vector to integer vector.  The
  encoding of the character vector can be specified but
  will default to the current locale.
}
\examples{
encToInt("\\\\xfa")
}
\seealso{
  \code{\link{intToEnc}}, \code{\link{iconv}} and
  \code{\link{utf8ToInt}}

  Other Functions to clean data:
  \code{\link{fixCommonEncodingProblems}},
  \code{\link{fixLevels01}}, \code{\link{fixLevels01R}},
  \code{\link{fixLevels01SPSS}}, \code{\link{hasDK}},
  \code{\link{intToEnc}}, \code{\link{leveltestR}},
  \code{\link{leveltestSPSS}}, \code{\link{removeAllDK}},
  \code{\link{removeDK}}
}
\keyword{encoding}

