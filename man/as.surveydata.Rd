\name{as.surveydata}
\alias{as.surveydata}
\title{Coercion from and to surveydata.}
\usage{
  as.surveydata(x, sep = "_", exclude = "other",
    ptn = pattern(x),
    defaultPtn = list(sep = sep, exclude = exclude),
    renameVarlabels = FALSE)
}
\arguments{
  \item{x}{Object to coerce to surveydata}

  \item{sep}{Separator between question and subquestion
  names}

  \item{exclude}{Excludes from pattern search}

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
\examples{
# Create surveydata object

sdat <- data.frame(
    id   = 1:4,
    Q1   = c("Yes", "No", "Yes", "Yes"),
    Q4_1 = c(1, 2, 1, 2), 
    Q4_2 = c(3, 4, 4, 3), 
    Q4_3 = c(5, 5, 6, 6), 
    Q10 = factor(c("Male", "Female", "Female", "Male")),
    crossbreak  = c("A", "A", "B", "B"), 
    crossbreak2 = c("D", "E", "D", "E"),
    weight      = c(0.9, 1.1, 0.8, 1.2)
)

varlabels(sdat) <- c(
    "RespID",
    "Question 1", 
    "Question 4: red", "Question 4: green", "Question 4: blue", 
    "Question 10",
    "crossbreak",
    "crossbreak2",
    "weight")

sv <- as.surveydata(sdat, renameVarlabels=TRUE)

# Extract specific questions
sv[, "Q1"]
sv[, "Q4"]

# Query attributes
varlabels(sv)
pattern(sv)

# Find unique questions

questions(sv)
which.q(sv, "Q1")
which.q(sv, "Q4")

# Find question text
qText(sv, "Q1")
qText(sv, "Q4")

qTextCommon(sv, "Q4")
qTextUnique(sv, "Q4")



# Example using dataset membersurvey
 
ms <- as.surveydata(membersurvey, renameVarlabels=TRUE)
questions(ms)
qText(ms, "Q30")
head(ms[, "Q1"])
head(ms["Q1"])
}
\seealso{
  \code{\link{surveydata-package}},
  \code{\link{is.surveydata}}
}

