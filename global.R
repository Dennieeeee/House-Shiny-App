library(tidyverse)
library(ggplot2)
library(lubridate)
library(corrplot)
url='/Users/dennie/Desktop/NEU/ALY 6070/Module 5/House_Price_data.csv'
data <- read.csv(url)
names(data) <- tolower(names(data))

#remove outliers on lotfrontage
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

#remove missing values in masvnrarea
remove <- which(is.na(data$masvnrarea))
data <- data[-remove,]

# sorted data by the saleprice in descending order in order to identify which neighborhood has the most expensive housing
data <- data[order(data$saleprice, decreasing = TRUE),] 
highestPrice <- head(data[,c(13,81)])

#subset data - only include numeric variables
numericVar <- which(sapply(data, is.numeric))
data_numVar <- data[,numericVar]
data2 <- data_numVar[,c(4:9,13,28,38)]

#rename the columns in data2
names(data2)[names(data2) == "lotarea"] <- "Lot_Area"
names(data2)[names(data2) == "overallqual"] <- "Material_Quality"
names(data2)[names(data2) == "overallcond"] <- "Condition_Rating"
names(data2)[names(data2) == "yearbuilt"] <- "Year_Built"
names(data2)[names(data2) == "yearremodadd"] <- "Remodel_Date"
names(data2)[names(data2) == "masvnrarea"] <- "Masonry_Veneer_Area"
names(data2)[names(data2) == "totalbsmtsf"] <- "Basement_Area"
names(data2)[names(data2) == "garagearea"] <- "Garage_Area"
names(data2)[names(data2) == "saleprice"] <- "Price"

#create a subset of categorical data
categorical <- which(sapply(data, is.factor))
data3<- data[,categorical]
summary(data3)


