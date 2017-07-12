# Surveydata: a package provides to work with typical survey data formats.

master: [![master build status](https://travis-ci.org/andrie/surveydata.svg?branch=master)](https://travis-ci.org/andrie/surveydata)
dev: [![dev build status](https://travis-ci.org/andrie/surveydata.svg?branch=dev)](https://travis-ci.org/andrie/surveydata)
[![](http://www.r-pkg.org/badges/version/surveydata)](http://www.r-pkg.org/pkg/surveydata)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/surveydata)](http://www.r-pkg.org/pkg/surveydata)
[![Coverage Status](https://img.shields.io/codecov/c/github/andrie/surveydata/master.svg)](https://codecov.io/github/andrie/surveydata?branch=master)

A surveydata object consists of:

* A data frame:

  * with a row for each respondent and a column for each question.  
  * Column names are typically names in the pattern Q1, Q2_1, Q2_2, Q3 - where underscores separate the subquestions when these originated in a grid (array) of questions.
* Attributes:

  * Question metadata gets stored in the `variable.labels` attribute of the data frame. This typically contains the original questionnaire text for each question.
  * Information about the subquestion separator (typically an underscore) is stored in the `patterns` attribute.

Data processing a survey file can be tricky, since the standard methods for dealing with data frames does not conserve the `variable.labels` attribute.  The `surveydata` package defines a `surveydata` class and the following methods that knows how to deal with the `variable.labels` attribute:

* `as.surveydata`
* `[.surveydata`
* `[<-.surveydata`
* `$.surveydata`
* `$<-.surveydata`
* `merge.surveydata`

In addition, `surveydata` defines the following convenient methods for extracting and working with the variable labels:

* `varlabels`
* `varlabels<-`
