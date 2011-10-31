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
