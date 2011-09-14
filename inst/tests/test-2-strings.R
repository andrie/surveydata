context("String functions")

test_that("string wrap and reverse works", {
      long_string <- "the quick brown fox jumps over the lazy dog"
      long_string_2 <- c("the quick brown fox jumps over the lazy dog", 
          "Why is the sentence the quick brown fox jumps over the lazy dog so unique? ")
      
      expect_that(str_wrap(long_string, 10), 
          equals("the quick\nbrown fox\njumps\nover the\nlazy dog"))
      
      expect_that(str_wrap(long_string_2, 20), 
          equals(c("the quick brown fox\njumps over the lazy\ndog",
                  "Why is the sentence\nthe quick brown fox\njumps over the lazy\ndog so unique?")))
      
      expect_that(str_reverse(long_string), 
          equals("god yzal eht revo spmuj xof nworb kciuq eht"))
    })

#------------------------------------------------------------------------------

test_that("str_common_unique works", {
      
      
     str_common <- function(x) str_common_unique(x)$common
     str_unique <- function(x) str_common_unique(x)$unique
     
     x <- "Q"
     expect_that(str_common(x), is_a("character"))
     expect_that(str_unique(x), is_a("character"))

     expect_that(str_common(x), equals("Q"))
     expect_that(str_unique(x), equals(""))
     
     x <- c("Q", "Q1")
     expect_that(str_common(x), equals("Q"))
     expect_that(str_unique(x), equals(c("", "1")))
     
     x <- c("Q1", "Q1")
     expect_that(str_common(x), equals("Q1"))
     expect_that(str_unique(x), equals(c("", "")))
     
     x <- c("Q1", "Q2")
     expect_that(str_common(x), equals("Q"))
     expect_that(str_unique(x), equals(c("1", "2")))
     
     x <- c("1", "2", "3")
     expect_that(str_common(x), equals(""))
     expect_that(str_unique(x), equals(c("1", "2", "3")))
     
     x <- c("Q_1", "Q_2", "Q_3") 
     expect_that(str_common(x), equals("Q_"))
     expect_that(str_unique(x), equals(c("1", "2", "3")))

   })


#str_common_unique(c("Q_1", "Q_2", "Q_3"))