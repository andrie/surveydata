\name{str_common_unique}
\alias{str_common_unique}
\title{Finds the common and unique elements in a character vector}
\usage{
  str_common_unique(x)
}
\arguments{
  \item{x}{Character vector}
}
\value{
  list of common and unique strings
}
\description{
  Function takes a character string as input and find the
  common and unique elements.  Assumes that the common
  element is at start of string
}
\examples{
q_string <- c("Q_1", "Q_2", "Q_3")
str_common_unique(q_string)$common
str_common_unique(q_string)$unique
}
\keyword{string}

