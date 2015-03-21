complete <- function(directory, id =1:332) {
  
 # print(directory)
  #setwd(directory)
 # AllFilelist <- list.files()
  Wk2DS <- data.frame() 
  nobs = numeric()
  
  for (i in id){
        
   Wk2DS <-  read.table(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""), header=TRUE, sep=",")
   
    nobs <- c(nobs, sum(complete.cases(Wk2DS)))
       
  }
  return(data.frame(id, nobs))
}
