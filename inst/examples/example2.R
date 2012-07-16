


# Example using dataset membersurvey
 
ms <- as.surveydata(membersurvey, renameVarlabels=TRUE)
questions(ms)
qText(ms, "Q30")
head(ms[, "Q1"])
head(ms["Q1"])
