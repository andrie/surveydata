print_opentext <- function(x){
  x %>% 
    na.omit() %>% 
    as.vector() %>% 
    # gsub("\n+", ". ", .) %>% 
    unique() %>% 
    (function(x){x[order(nchar(x), decreasing = TRUE)]}) %>% 
    sQuote() %>%  
    paste("*", ., collapse = "\n\n") %>% 
    cat()
  invisible(NULL)  
}


utils::globalVariables(c("startlanguage", "txt"))
#' @importFrom DT datatable
as_opentext_datatable <- function(.data, Q_number){
  Q_number <- enquo(Q_number)
  .data %>% 
    un_surveydata() %>% 
    select(!!Q_number, startlanguage) %>% 
    rename(txt = !!Q_number, lang = startlanguage) %>% 
    filter(!is.na(txt) & nchar(txt) > 3) %>%
    mutate(
      nchar = nchar(txt),
      # txt = gsub("\\.\n+", ". ", txt) %>% gsub("\n+", " ", .),
      txt = sQuote(txt)
    ) %>% 
    distinct() %>% 
    arrange(lang, -nchar) %>% 
    DT::datatable()
}

