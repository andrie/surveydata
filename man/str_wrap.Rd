\name{str_wrap}
\alias{str_wrap}
\title{Wraps a string into separate lengths by inserting line breaks at word boundaries.}
\usage{
  str_wrap(x, len = 30)
}
\arguments{
  \item{x}{Character vector}

  \item{len}{Length of new strings}
}
\description{
  Wraps a string into separate lengths by inserting line
  breaks at word boundaries.
}
\examples{
str_wrap("the quick brown fox jumps over the lazy dog", 10)
}
\keyword{string}

