withr::with_package("dplyr", {
  membersurvey %>% 
    as.tbl() %>% 
    .[c("id", "Q1", "Q2")] %>% 
    filter(Q2 == 2009)
})


