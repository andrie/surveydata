\name{as.surveydata}
\alias{as.surveydata}
\title{Coercion from and to surveydata.}
\usage{
  as.surveydata(x, ptn = pattern(x), defaultPtn = c("^",
  "($|(_\\d+(_\\d+)*)$)"), renameVarlabels = FALSE)
}
\arguments{
  \item{x}{Object to coerce to surveydata}

  \item{ptn}{A character vector of length two, consisting
  of a prefix and suffix.  When subsetting based on
  question numbers, the prefix, question number and suffix
  forms a regex pattern that defines the pattern to extract
  valid question numbers.  See \code{\link{pattern}} and
  \code{\link{which.q}} for more detail.}

  \item{defaultPtn}{The default for ptn, if it does't exist
  in the object that is being coerced.}

  \item{renameVarlabels}{If TRUE, turns variable.labels
  attribute into a named vector, using \code{names(x)} as
  names.}
}
\description{
  Methods for creating "surveydata" objects, testing for
  class, and coercion from other objects.
}
\seealso{
  \code{\link{surveydata-package}},
  \code{\link{is.surveydata}}
}

