# Description:  MSDS600 Week 4 R Data Analysis
# Author: Jason Canney
# Date: 11/11/2014

# Place instructor provided .csv files into your RStudio working directory

setwd("~/Desktop/Dev/R/twitteR")  #set working directory

dataset1 <- read.csv("BN1.csv")  # read csv file 
dataset2 <- read.csv("BN2.csv")  # read csv file 
dataset3 <- read.csv("Binomial.csv")  # read csv file 
dataset4 <- read.csv("IN.csv")  # read csv file
dataset5 <- read.csv("N1.csv")  # read csv file 
dataset6 <- read.csv("N2.csv")  # read csv file 

#dataset1  #print out the csv to make sure it was read in correctly
#dataset2
#dataset3
#dataset4
#dataset5
#dataset6

# function Rmean
# purpose: takes in data set and runs a set of analysis steps on dataset
# input: dataset
# output: console and graphs
Rmean <- function(dataset)
{
  lapply(dataset, mean) #Calculate mean
  
}  #Function ends here, this is the end of your highlight

# function Rsd
# purpose: takes in data set and runs a set of analysis steps on dataset
# input: dataset
# output: console and graphs
Rsd <- function(dataset)
{
  lapply(dataset, sd) #Calculate standard deviation
  
}  #Function ends here, this is the end of your highlight

# function Rmin
# purpose: takes in data set and runs a set of analysis steps on dataset
# input: dataset
# output: console and graphs
Rmin <- function(dataset)
{
  min(dataset) #Calculate the minimum value in the data set
  
}  #Function ends here, this is the end of your highlight

# function Rmax
# purpose: takes in data set and runs a set of analysis steps on dataset
# input: dataset
# output: console and graphs
Rmax <- function(dataset)
{
  max(dataset) #Calculate maximum
  
}  #Function ends here, this is the end of your highlight

# function Rhist
# purpose: takes in data set and runs a set of analysis steps on dataset
# input: dataset
# output: console and graphs
Rhist <- function(dataset)
{
  lapply(dataset, hist)#Create histogram plot
  
}  #Function ends here, this is the end of your highlight

#Analyze dataset1
Rmean(dataset1)
Rsd(dataset1)
Rmin(dataset1)
Rmax(dataset1)
Rhist(dataset1)

#Analyze dataset2
Rmean(dataset2)
Rsd(dataset2)
Rmin(dataset2)
Rmax(dataset2)
Rhist(dataset2)

#Analyze dataset3
Rmean(dataset3)
Rsd(dataset3)
Rmin(dataset3)
Rmax(dataset3)
Rhist(dataset3)

#Analyze dataset4
Rmean(dataset4)
Rsd(dataset4)
Rmin(dataset4)
Rmax(dataset4)
Rhist(dataset4)

#Analyze dataset5
Rmean(dataset5)
Rsd(dataset5)
Rmin(dataset5)
Rmax(dataset5)
Rhist(dataset5)

#Analyze dataset6
Rmean(dataset6)
Rsd(dataset6)
Rmin(dataset6)
Rmax(dataset6)
Rhist(dataset6)

