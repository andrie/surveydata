\name{.merge_varlabels}
\alias{.merge_varlabels}
\title{Merges variable...}
\usage{.merge_varlabels(dat1, dat2, new_names=union(names(dat1), names(dat2)))}
\description{Merges variable.labels attribute from two surveydata objects}
\details{Merges variable labels from two data objects.  The labels from dat1 takes precedence.}
\keyword{internal}
\arguments{\item{dat1}{surveydata object}
\item{dat2}{surveydata object}
\item{new_names}{A vector with names of the merged varlabels.  Defaults to the union of names of dat1 and dat2}}
