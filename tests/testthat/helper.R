# Create surveydata object


make_test_survey <- function(){
  dat <- data.frame(
    id   = 1:4,
    Q1   = c("Yes", "No", "Yes", "Yes"),
    Q4_1 = c(1, 2, 1, 2), 
    Q4_2 = c(3, 4, 4, 3), 
    Q4_3 = c(5, 5, 6, 6), 
    Q10 = factor(c("Male", "Female", "Female", "Male")),
    crossbreak  = c("A", "A", "B", "B"), 
    weight      = c(0.9, 1.1, 0.8, 1.2)
  )
  
  varlabels(dat) <- c(
    "RespID",
    "Question 1", 
    "Question 4: red", "Question 4: green", "Question 4: blue", 
    "Question 10",
    "crossbreak",
    "weight"
  )
  
  as.surveydata(dat, renameVarlabels=TRUE)
}

make_test_data <- function(){
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
  names(sdat_labels) <- names(sdat)
  attributes(sdat)$variable.labels <- sdat_labels
  sdat
}

make_test_data_2 <- function(){
  sdat2 <- data.frame(
    id   = 1:4,
    Q1   = c("Yes", "No", "Yes", "Yes"),
    `Q4__1` = c(1, 2, 1, 2), 
    `Q4__2` = c(3, 4, 4, 3), 
    `Q4__3` = c(5, 5, 6, 6), 
    `Q4__ignore` = c(NA, NA, "some text", NA),
    Q10 = factor(c("Male", "Female", "Female", "Male")),
    crossbreak  = c("A", "A", "B", "B"), 
    crossbreak2 = c("D", "E", "D", "E"),
    weight      = c(0.9, 1.1, 0.8, 1.2),
    check.names=FALSE
  )
  
  varlabels(sdat2) <- c(
    "RespID",
    "Question 1", 
    "Question 4: red", "Question 4: green", "Question 4: blue", 
    "Question 4: Other",
    "Question 10",
    "crossbreak",
    "crossbreak2",
    "weight")
  sdat2
}