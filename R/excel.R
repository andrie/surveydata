# 
# Author: andrie
###############################################################################


#==============================================================================
# Write to Excel



#' Export surveydata answers to Excel worksheet.
#' 
#' Writes surveydata answers to worksheet in Excel.
#' 
#' The worksheet is laid as follows:
#' \describe{
#'  \item{A1}{Question id}
#'  \item{A2}{Question text}
#'  \item{A5:C5}{Data frame with columns qID, Original text and Modified text}
#' }
#' 
#' Requires the package \code{XLConnect}
#' 
#' @param s surveydata object
#' @param Q question id
#' @param wb Excel workbook, see also \code{\link[XLConnect]{loadWorkbook}}
#' @param sheetname Name of worksheet
#' @param subset logical expression indicating elements or rows to keep: missing values are taken as false
#' @param colnames Column names of data frame (as written to Excel) 
#' @return NULL
#' @export
#' @family Export to Excel / Import from Excel
writeOneQuestionExcel <- function(s, Q, wb, sheetname=Q, subset, colnames=c("Id", "Text", "Modified")){
  stopifnot(require(XLConnect))
  stopifnot(length(Q)==1)
  
  if (missing(subset)) 
    r <- TRUE
  else {
    e <- substitute(subset)
    r <- eval(e, s, parent.frame())
  }
  
  sheet <- createSheet(wb, sheetname)
  
  # Write qID and question text
  headerText <- data.frame(x = c(as.character(Q), qTextCommon(s, Q)))#, language))
  writeWorksheet(wb, headerText, sheet=sheetname, startRow=1, header=FALSE)
  setColumnWidth(wb, sheet=sheetname, column = 2:3, width = 256*50)
  
  
  # Write data frame of answer text
  expt <- as.data.frame(s[r, c("id", Q), drop=FALSE])
  expt <- quickdf(lapply(expt, as.character)) # converts factors to character
  expt <- expt[!is.na(expt[, Q]), ]
  Encoding(expt[, Q]) <- "UTF-8" 
  expt <- data.frame(expt, rep("", nrow(expt)), stringsAsFactors=FALSE)
  names(expt) <- colnames
  
  
  writeWorksheet(wb, expt, sheet=sheetname, startRow=5)
  
  #Format data frame as wrap text
  cs <- createCellStyle(wb)
  setWrapText(cs, wrap = TRUE)
  setCellStyle(wb, sheet = sheetname, row=6:(6+nrow(headerText)), col = 2, cellstyle = cs)
  
  return(NULL)
}

#------------------------------------------------------------------------------

#' Writes surveydata questions to Excel file.
#' 
#' @inheritParams writeOneQuestionExcel
#' @param file File name
#' @param delete Logical. If TRUE, deletes file 
#' @param ... Other arguments passed to writeOneQuestionExcel
#' @export
#' @family Export to Excel / Import from Excel
writeQuestionExcel <- function(s, Q, file=NULL, delete=TRUE, ...){
  stopifnot(require(XLConnect))
  stopifnot(is.surveydata(s))
  if(is.null(file)) stop("Invalid file")
  if(delete & file.exists(file)) unlink(file)
  wb <- loadWorkbook(file, create = TRUE)
  sapply(Q, function(xt)writeOneQuestionExcel(s, Q=xt, wb=wb, ...))
  
  saveWorkbook(wb)
}


#xls.question <- function(s, q, language, wb, sheetname=q){
#  .Deprecated(writeQuestionExcel)
#  writeQuestionExcel(s=s, Q=q, wb=wb, sheetname=sheetname, subset=language==language)
#}




#==============================================================================
# Read from Excel

library(XLConnect)
library(plyr)


#' Imports exported surveydata answers from Excel workbook.
#' 
#' Requires the package \code{XLConnect}
#' 
#' @param wb Excel workbook, see also \code{\link[XLConnect]{loadWorkbook}}
#' @param sheetname Name of worksheet
#' @param colnames Column names of data frame (as written to Excel) 
#' @return NULL
#' @export
#' @family Export to Excel / Import from Excel
readOneQuestionExcel <- function(wb, sheetname, colnames=c("Id", "Text", "Modified")){
  stopifnot(require(XLConnect))
  xx <- readWorksheet(wb, sheetname, region="A1:A3", header=FALSE)
  yy <- na.omit(readWorksheet(wb, sheetname, startRow=5, endCol=3))
  attr(yy, "na.action") <- NULL
  
  if(nrow(yy) == 0) return(NULL)
  ret <- data.frame(
      xx[1, 1], 
      #xx[2, 1], 
      #language = xx[3, 1],
      yy,
      stringsAsFactors = FALSE
  )
  names(ret) <- c("Qid", colnames)
  ret
}

#' Reads all sheets in workbook.
#' 
#' @inheritParams readOneQuestionExcel
#' @param file File name to read
#' @param .progress Type of progress bar to use, passed to \code{\link[plyr]{ldply}}
#' @param ... Other arguments passed to \code{\link{readOneQuestionExcel}}
#' @return data frame
#' @export
#' @family Export to Excel / Import from Excel
readAllSheets <- function(file, .progress="none", ...){
  stopifnot(require(XLConnect))
  if(!file.exists(file)) stop("File can not be found")
  wb <- loadWorkbook(file)
  sheets <- getSheets(wb)
  ldply(sheets, function(s){readOneQuestionExcel(wb, sheetname=s, ...)}, .progress=.progress)
}

#' Imports exported surveydata answers from Excel workbook.
#' 
#' Requires the package \code{XLConnect}
#' 
#' @inheritParams readOneQuestionExcel
#' @param files Character vector of file names to read
#' @param showMessages If TRUE, displays a message for each file that get processed
#' @param .progress Type of progress bar to use, passed to \code{\link[plyr]{ldply}}
#' @param ... Other arguments passed to \code{\link{readAllSheets}} and \code{\link{readOneQuestionExcel}}
#' @return data frame
#' @export
#' @family Export to Excel / Import from Excel
readQuestionExcel <- function(files, showMessages=TRUE, .progress=c("tk", "none", "win"), ...){
  .progress <- match.arg(.progress)
  do.call(
      rbind, 
      lapply(files, function(f){
            if(showMessages) message(basename(f))
            readAllSheets(file=f, .progress=.progress, ...)
          }
  ))
}

#' Updates surveydata answers with data imported from Excel workbook.
#' 
#' Requires the package \code{XLConnect}
#' 
#' @param x surveydata object
#' @param file Optional character vector of file names, each pointing to an Excel file to import. If supplied, then the files will be imported using \code{\link{readQuestionExcel}}
#' @param new Data frame obtained from \code{\link{readQuestionExcel}}
#' @return surveydata object
#' @export
#' @family Export to Excel / Import from Excel
updateQuestion <- function(x, file, new=readQuestionExcel(file)){
  stopifnot(is.surveydata(x))
  stopifnot(is.data.frame(new))
  x <- as.data.frame(x)
  for(QID in unique(new$Qid)){
    chunk <- new[new$Qid==QID, ]
    r   <- sapply(chunk$Id, match, x$id)
    if(is.factor(x[[QID]])){
      xx <- x[[QID]] <- as.character(x[[QID]])
      xx[r] <- as.character(chunk$Modified)
      xx <- as.factor(xx)
      x[[QID]] <- xx
    } else {
      xx <- x[[QID]]
      xx[r] <- as.character(chunk$Modified)
      x[[QID]] <- xx
    }
  }
  as.surveydata(x)
}

