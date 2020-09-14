withr::with_package("dplyr", {
  membersurvey %>% 
    as_tibble() %>% 
    .[c("id", "Q1", "Q2")] %>% 
    filter(Q2 == 2009)
})


