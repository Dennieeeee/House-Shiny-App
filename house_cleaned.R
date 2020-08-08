library(tidyverse)
library(ggplot2)
library(lubridate)
library(corrplot)
url='/Users/dennie/Desktop/NEU/ALY 6070/Module 5/House_Price_data.csv'
data <- read.csv(url)
names(data) <- tolower(names(data))

#remove outlier on lotfrontage
ggplot(data, aes(x = lotfrontage)) +
  geom_boxplot()
subset(data, lotfrontage > 150)
remove <- which(data$lotfrontage>150)
data<-data[-remove,]

#remove outlier on lotarea
ggplot(data, aes(x = lotarea)) +
  geom_boxplot()
subset(data, lotarea >60000)
remove <- which(data$lotarea>60000)
data<-data[-remove,] 

#remove rows with missing data in lotfrontage
remove <- which(is.na(data$lotfrontage))
data <- data[-remove,]

#remove outliers on saleprice
remove <- which(data$saleprice>500000)
data <- data[-remove,]

#get all numeric data into numericVar
numericVar <- which(sapply(data, is.numeric))
data2 <- data_numVar[,c(4:9,13,28,38)]

numericVarNames <- which(sapply(data, is.numeric))
cat('There are', length(numericVar), 'numeric variables')
#subset data - only include numeric variables
data_numVar <- data[,numericVar]

save(data, file = "data.Rdata")
save(data2, file = 'selected_variables.Rdata')
