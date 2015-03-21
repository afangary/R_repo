corr <- function(directory, threshold = 0) {
    
   
  completeReturnDS <- complete(directory)
  completeObsid <- completeReturnDS[completeReturnDS["nobs"] > threshold, ]$id
 
  #print(completeObsid)
  CorrReturn = numeric()
  
  for (i in completeObsid){
    FileDS <-  read.table(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""), header=TRUE, sep=",")
    CompleteCasesDS <- FileDS[complete.cases(FileDS), ]
    CorrReturn <- c(CorrReturn, cor(CompleteCasesDS$sulfate, CompleteCasesDS$nitrate))
  }
  return(CorrReturn)
}

