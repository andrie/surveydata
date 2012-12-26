# Surveydata

This package provides a class to work with typical survey data that originated in SPSS or other formats.

Once an SPSS data files is imported into R, it is:

* A data frame with a row for each respondent and a column for each question
* Column names are typically names in the pattern Q1, Q2_1, Q2_2, Q3, etc. Underscores separate the subquestions when these originated in a grid (array) of questions.
* Additional detail about the questions are stored in the `variable.labels` attribute of the data.frame. This typically contains the original questionnaire text for each question.

Data processing a survey file can be tricky, since the standard methods for dealing with data.frames will not conserve the `variable.labels` attribute.

The `surveydata` package defines a `surveydata` class and the following methods that knows how to deal with the `variable.labels` attribute:

* `as.surveydata`
* `[.surveydata`
* `[<-.surveydata`
* `$.surveydata`
* `$<-.surveydata`
* `merge.surveydata`

In addition, `surveydata` defines the following convenient methods for extracting and working with the variable labels:

* `varlabels`
* `varlabels<-`
