# Example using dataset membersurvey

which.q(membersurvey, "Q1")
which.q(membersurvey, "Q3")
which.q(membersurvey, c("Q1", "Q3"))

questions(membersurvey)
qText(membersurvey, "Q3")
qTextUnique(membersurvey, "Q3")
qTextCommon(membersurvey, "Q3")

head(membersurvey[, "Q1"])
head(membersurvey["Q1"])
