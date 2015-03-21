pollutantmean <- function(directory, pollutant, id=1:332) {
  
  #setwd(directory)
  #AllFilelist <- list.files()
  Wk2DS <- data.frame() 
  
  for (i in id){
        
    Wk2DS <- rbind(Wk2DS, read.table(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""), header=TRUE, sep=","))
    
  }
  
  mymean <- mean(Wk2DS[, pollutant], na.rm=T)
  #mymean <- mean(VarData, na.rm=T)
  
}