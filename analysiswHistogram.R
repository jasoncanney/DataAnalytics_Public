# Date: 11/15/2014
# Description: Regis Univerity, MSDS600 Data Science, Data Analysis with R
# Author: Nermina Kustura

# Save instructor provided .csv files in working direcotry

setwd("~/Desktop/Dev/R/twitteR") 
# path <- ("C:\\Users\\Nermina\\Desktop\\Data_Science\\RStudio\\") #set path for working directory
File <- list.files(pattern = ".csv") ## creates a vector with all csv file names in the folder

Mean                <- rep(0,length(File)) # sets Mean vector
Minimum             <- rep(0,length(File)) # sets Min vector
Maximum             <- rep(0,length(File)) # sets Max vector
Standard_Deviation  <- rep(0,length(File)) # sets SD vector
Total               <- rep(0,length(File)) # sets Sum vector
Histogram_Plot      <- rep(0,length(File)) # sets histogram vector         

for(i in 1:length(File)){                             # loops through csv files in the folder
  data                  <- read.csv(File[i],header=F) # reads each csv file to get the data
  Mean[i]               <- mean(data[[1]])            # calculates mean for each file
  Minimum[i]            <- min(data[[1]])             # calculates minimum for each file
  Maximum[i]            <- max(data[[1]])             # calculates maximum for each file
  Standard_Deviation[i] <- sd(data[[1]])              # calculates standard deviation for each file
  Total[i]                 <- sum(data[[1]])             # calculates sum for each file
  Histogram_Plot[i]     <- hist(data[[1]])            # calculates histogram plot points for each file
}

result <- cbind(File,Mean,Minimum,Maximum,Standard_Deviation,Total,Histogram_Plot) #combines the results of calculations into result vector
write.csv(result,"Data_Anaysis.csv") # writes the results to csv file with column labels for each file and calculations

result # writes results on the console
