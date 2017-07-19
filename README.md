Surveydata
================

Surveydata: a package provides to work with typical survey data formats.
========================================================================

master: [![master build status](https://travis-ci.org/andrie/surveydata.svg?branch=master)](https://travis-ci.org/andrie/surveydata) dev: [![dev build status](https://travis-ci.org/andrie/surveydata.svg?branch=dev)](https://travis-ci.org/andrie/surveydata) [![](http://www.r-pkg.org/badges/version/surveydata)](http://www.r-pkg.org/pkg/surveydata) [![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/surveydata)](http://www.r-pkg.org/pkg/surveydata) [![Coverage Status](https://img.shields.io/codecov/c/github/andrie/surveydata/master.svg)](https://codecov.io/github/andrie/surveydata?branch=master)

Usage
-----

Usage
-----

The `surveydata` package makes it easy to work with typical survey data that originated in SPSS or other formats.

Motivation
----------

Specifically, it helps keep the question text with the data itself.

To track the questions of a survey, you have two options: \* Keep the data in a data frame, and keep a separate list of the questions \* Keep the questions as an attribute of the data frame

Neither of these options are ideal, since any subsetting of the survey data means you must keep track of the question metadata separately.

This package solves the problem by creating a new class, `surveydata`, and keeping the questions as an attribute of this class. Whenever you do a subsetting operation, the metadata stays intact.

In addition, the metadata knows if a question consists of a single column, or multiple columns. When doing subsetting on the question name, the resulting object can be either a single column or multiple columns.

``` r
library(surveydata)
library(dplyr)
sv <- membersurvey %>% as.tbl()
sv
```

    ## # A tibble: 215 x 109
    ##       id  Q1_1  Q1_2          Q2   Q3_1   Q3_2   Q3_3   Q3_4   Q3_5   Q3_6
    ##    <dbl> <dbl> <dbl>       <ord> <fctr> <fctr> <fctr> <fctr> <fctr> <fctr>
    ##  1     3     8   2.0        2009     No     No     No     No     No     No
    ##  2     5    35  12.0 Before 2002    Yes     No     No     No     No     No
    ##  3     6    34  12.0 Before 2002    Yes    Yes     No     No     No    Yes
    ##  4    11    20   9.0        2010     No     No     No     No     No     No
    ##  5    13    20   3.0        2010     No     No     No     No     No     No
    ##  6    15    36  20.0 Before 2002     No    Yes     No     No     No     No
    ##  7    21    12   2.5        2009    Yes     No     No     No     No    Yes
    ##  8    22    11   0.5        2011    Yes    Yes    Yes    Yes    Yes     No
    ##  9    23    18   3.0        2008    Yes    Yes    Yes    Yes    Yes    Yes
    ## 10    25    24   8.0        2006     No     No     No    Yes    Yes    Yes
    ## # ... with 205 more rows, and 99 more variables: Q3_7 <fctr>, Q3_8 <fctr>,
    ## #   Q3_9 <fctr>, Q3_10 <fctr>, Q3_11 <fctr>, Q3_12 <fctr>, Q3_13 <fctr>,
    ## #   Q3_14 <fctr>, Q3_15 <fctr>, Q4 <fctr>, Q5 <fctr>, Q6_1 <fctr>,
    ## #   Q6_2 <fctr>, Q6_3 <fctr>, Q6_4 <fctr>, Q6_5 <fctr>, Q6_6 <fctr>,
    ## #   Q6_7 <fctr>, Q6_8 <fctr>, Q6_9 <fctr>, Q6_10 <fctr>, Q7 <fctr>,
    ## #   Q8 <fctr>, Q9_1 <fctr>, Q9_2 <fctr>, Q9_3 <fctr>, Q9_4 <fctr>,
    ## #   Q9_5 <fctr>, Q10 <fctr>, Q11_1 <fctr>, Q11_2 <fctr>, Q11_3 <fctr>,
    ## #   Q11_4 <fctr>, Q11_5 <fctr>, Q11_other <fctr>, Q12_1 <fctr>,
    ## #   Q13_1 <fctr>, Q13_2 <fctr>, Q13_3 <fctr>, Q13_4 <fctr>, Q14_1 <fctr>,
    ## #   Q14_2 <fctr>, Q14_3 <fctr>, Q14_4 <fctr>, Q14_5 <fctr>, Q14_6 <fctr>,
    ## #   Q14_7 <fctr>, Q14_8 <fctr>, Q14_9 <fctr>, Q14_10 <fctr>, Q15_1 <fctr>,
    ## #   Q15_2 <fctr>, Q15_3 <fctr>, Q15_4 <fctr>, Q15_5 <fctr>, Q15_6 <fctr>,
    ## #   Q19_1 <fctr>, Q19_2 <fctr>, Q19_3 <fctr>, Q19_4 <fctr>, Q19_5 <fctr>,
    ## #   Q19_6 <fctr>, Q20_1 <fctr>, Q20_2 <fctr>, Q20_3 <fctr>, Q20_4 <fctr>,
    ## #   Q20_5 <fctr>, Q20_6 <fctr>, Q20_7 <fctr>, Q20_8 <fctr>, Q20_9 <fctr>,
    ## #   Q20_10 <fctr>, Q20_other <fctr>, Q21_1 <fctr>, Q21_2 <fctr>,
    ## #   Q21_3 <fctr>, Q21_4 <fctr>, Q21_5 <fctr>, Q21_6 <fctr>, Q23_1 <fctr>,
    ## #   Q23_2 <fctr>, Q23_3 <fctr>, Q23_4 <fctr>, Q23_5 <fctr>,
    ## #   Q23_other <fctr>, Q24 <dbl>, Q25 <dbl>, Q26_1 <ord>, Q27_1 <dbl>,
    ## #   Q27_2 <dbl>, Q30 <fctr>, Q30_other <fctr>, Q31 <fctr>,
    ## #   Q31_other <fctr>, Q32 <ord>, Q33 <fctr>, Q35 <fctr>, weight <dbl>,
    ## #   size <dbl>

Notice from this summary that Question 2 has two columns, i.e. `Q2_1` and `Q2_2`. You can extract both these columns by simply referring to `Q2`:

`r   sv[, "Q2"]`

`## # A tibble: 215 x 1   ##             Q2   ##          <ord>   ##  1        2009   ##  2 Before 2002   ##  3 Before 2002   ##  4        2010   ##  5        2010   ##  6 Before 2002   ##  7        2009   ##  8        2011   ##  9        2008   ## 10        2006   ## # ... with 205 more rows`

However, the subset of `Q1` returns only a single column:

`r   sv[, "Q2"]`

`## # A tibble: 215 x 1   ##             Q2   ##          <ord>   ##  1        2009   ##  2 Before 2002   ##  3 Before 2002   ##  4        2010   ##  5        2010   ##  6 Before 2002   ##  7        2009   ##  8        2011   ##  9        2008   ## 10        2006   ## # ... with 205 more rows`

Note that in both cases the `surveydata` object doesn't return a vector - subsetting a `surveydata` object always returns a `surveydata` object.

About surveydata objects
------------------------

A surveydata object consists of:

-   A data frame with a row for each respondent and a column for each question. Column names are typically names in the pattern `Q1`, `Q2_1`, `Q2_2`, `Q3` - where underscores separate the subquestions when these originated in a grid (array) of questions.

-   Question metadata gets stored in the \`{variable.labels} attribute of the data frame. This typically contains the original questionnaire text for each question.

-   Information about the subquestion separator (typically an underscore) is stored in the `patterns` attribute.

Data processing a survey file can be tricky, since the standard methods for dealing with data frames does not conserve the `variable.labels` attribute. The `surveydata` package defines a `surveydata` class and the following methods that knows how to deal with the `variable.labels` attribute:

-   `as.surveydata`
-   `[.surveydata`
-   `[<-.surveydata`
-   `$.surveydata`
-   `$<-.surveydata`
-   `merge.surveydata`

In addition, `surveydata` defines the following convenient methods for extracting and working with the variable labels:

-   `varlabels`
-   `varlabels<-`

Defining a surveydata object
----------------------------

First load the `surveydata` package.

``` r
library(surveydata)
```

Next, create sample data. A data frame is the ideal data structure for survey data, and the convention is that data for each respondent is stored in the rows, while each column represents answers to a specific question.

``` r
sdat <- data.frame(
id   = 1:4,
Q1   = c("Yes", "No", "Yes", "Yes"),
Q4_1 = c(1, 2, 1, 2), 
Q4_2 = c(3, 4, 4, 3), 
Q4_3 = c(5, 5, 6, 6), 
Q10 = factor(c("Male", "Female", "Female", "Male")),
crossbreak  = c("A", "A", "B", "B"), 
weight      = c(0.9, 1.1, 0.8, 1.2)
)
```

The survey metadata consists of the questionnaire text. For example, this can be represented by a character vector, with an element for each question.

To assign this metadata to the survey data, use the `varlabels()` function. This function assigns the questionnaire text to the `variable.labels` attribute of the data frame.

``` r
varlabels(sdat) <- c(
"RespID",
"Question 1", 
"Question 4: red", "Question 4: green", "Question 4: blue", 
"Question 10",
"crossbreak",
"weight"
)
```

Finally, create the surveydata object. To do this, call the `as.surveydata()` function. The argument `renameVarlabels` controls whether the `varlabels` get renamed with the same names as the data. This is an essential step, and ensures that the question text remains in synch with the column names.

``` r
sv <- as.surveydata(sdat, renameVarlabels = TRUE)
```

Extracting specific questions
-----------------------------

It is easy to extract specific questions with the `[` operator. This works very similar to extraction of data frames. However, there are two important differences:

-   The extraction operators will always return a `surveydata` object, even if only a single column is returned. This is different from the behaviour of data frames, where a single column is simplified to a vector.
-   Extracing a question with multiple subquestions, e.g. "Q4" returns multiple columns

``` r
sv[, "Q1"]
```

    ##    Q1
    ## 1 Yes
    ## 2  No
    ## 3 Yes
    ## 4 Yes

``` r
sv[, "Q4"]
```

    ##   Q4_1 Q4_2 Q4_3
    ## 1    1    3    5
    ## 2    2    4    5
    ## 3    1    4    6
    ## 4    2    3    6

The extraction makes use of the underlying metadata, contained in the `varlabels` and `pattern` attributes:

``` r
varlabels(sv)
```

    ##                  id                  Q1                Q4_1 
    ##            "RespID"        "Question 1"   "Question 4: red" 
    ##                Q4_2                Q4_3                 Q10 
    ## "Question 4: green"  "Question 4: blue"       "Question 10" 
    ##          crossbreak              weight 
    ##        "crossbreak"            "weight"

``` r
pattern(sv)
```

    ## $sep
    ## [1] "_"
    ## 
    ## $exclude
    ## [1] "other"

Working with question columns
-----------------------------

It is easy to query the surveydata object to find out which questions it contains, as well as which columns store the data for those questions.

``` r
questions(sv)
```

    ## [1] "id"         "Q1"         "Q4"         "Q10"        "crossbreak"
    ## [6] "weight"

``` r
which.q(sv, "Q1")
```

    ## [1] 2

``` r
which.q(sv, "Q4")
```

    ## [1] 3 4 5

Reading the questionnaire text
------------------------------

The function `qText()` gives access to the questionnaire text.

``` r
qText(sv, "Q1")
```

    ## [1] "Question 1"

``` r
qText(sv, "Q4")
```

    ## [1] "Question 4: red"   "Question 4: green" "Question 4: blue"

### Getting the common question text

Use `qTextCommon()` to retrieve the common text, i.e. the question itself:

``` r
qTextCommon(sv, "Q4")
```

    ## [1] "Question 4"

### Getting the unique question text

And use `qTextUnique()` to retrieve the unique part of the question, i.e. the subquestions:

``` r
qTextUnique(sv, "Q4")
```

    ## [1] "red"   "green" "blue"

Using `surveydata` with `dplyr`
-------------------------------

The `surveydata` object knows how to deal with the following `dplyr` verbs:

-   `select`
-   `filter`
-   `mutate`
-   `arrange`
-   `summarize`

In every case the resulting object will also be of class `surveydata`.

Summary
-------

The `surveydata` object can make it much easier to work with survey data.
