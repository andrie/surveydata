\docType{package}
\name{surveydata-package}
\alias{surveydata}
\alias{surveydata-package}
\title{Tools, classes and methods to manipulate survey data.}
\description{
  Tools, classes and methods to manipulate survey data.
}
\details{
  Surveydata objects have been designed to function with
  SPSS export data, i.e. the result of an SPSS import,
  \code{read.spss()}.  This type of data is contained in a
  data.frame, with information about the questionnaire text
  in the \code{variable.labels} attribute.  Surveydata
  objects keep track of the variable labels, by offering
  methods for renaming, subsetting, etc.

  Coercion functions: \itemize{ \item
  \code{\link{as.surveydata}} \item
  \code{\link{is.surveydata}} \item
  \code{\link{as.data.frame.surveydata}} }

  To access and modify attributes: \itemize{ \item
  \code{\link{pattern}} \item \code{\link{varlabels}} }

  To subset or merge surveydata objects: \itemize{ \item
  \code{\link[surveydata]{merge}} \item
  \code{\link[surveydata]{extract}} }

  To extract question text from varlabels: \itemize{ \item
  \code{\link[surveydata]{qText}} \item
  \code{\link[surveydata]{qTextCommon}} \item
  \code{\link[surveydata]{qTextUnique}} }

  Functions to fix common encoding problems: \itemize{
  \item \code{\link[surveydata]{entToInc}} \item
  \code{\link[surveydata]{incToEnt}} \item
  \code{\link[surveydata]{fixCommonEncodingProblems}} }

  Functions to clean data: \itemize{ \item
  \code{\link[surveydata]{removeDK}} to remove "Don't know"
  responses \item \code{\link[surveydata]{removeAllDK}} to
  remove "Don't know" responses from all questions \item
  \code{\link[surveydata]{fixLevels01}} to fix level
  formatting of all question with Yes/No type answers }
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

sdat_labels <- c(
    "RespID",
    "Question 1", 
    "Question 4: red", "Question 4: green", "Question 4: blue", 
    "Question 10",
    "crossbreak",
    "crossbreak2",
    "weight")

attributes(sdat)$variable.labels <- sdat_labels

sv <- as.surveydata(sdat)

# Extract specific questions
sv[, "Q1"]
sv[, "Q4"]

# Query attributes
varlabels(sv)
pattern(sv)

# Find question text
qText(sv, "Q1")
qText(sv, "Q4")

qTextCommon(sv, "Q4")
qTextUnique(sv, "Q4")
}
\author{
  Andrie de Vries \email{andrie@pentalibra.com}
}
\keyword{package}

