\name{lapplyNames}
\alias{lapplyNames}
\title{Applies function only to named elements of a list.}
\usage{
  lapplyNames(x, names, FUN, ...)
}
\arguments{
  \item{x}{List}

  \item{names}{Character vector identifying which elements
  of the list to apply FUN}

  \item{FUN}{The function to apply.}

  \item{...}{Additional arguments passed to FUN}
}
\description{
  This is useful to clean only some columns in a list (or
  data.frame or surveydata object). This is just a wrapper
  around \code{\link{lapply}} where only the named elements
  are changed.
}
\seealso{
  Other Tools: \code{\link{qOrder}}
}

