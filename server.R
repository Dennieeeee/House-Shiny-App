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

#add month and date columns and create a yearbuilt date column


#get all numeric data into numericVar
numericVar <- which(sapply(data, is.numeric))
numericVar <- which(sapply(data, is.numeric))
numericVarNames <- which(sapply(data, is.numeric))
cat('There are', length(numericVar), 'numeric variables')
#subset data - only include numeric variables
data_numVar <- data[,numericVar]
#correlation:
cor_numVar <- cor(data_numVar, use='pairwise.complete.obs')
cor_sorted <- as.matrix(sort(cor_numVar[,'saleprice'],decreasing = TRUE))
cor_sorted <- as.matrix(sort(cor_numVar[,'saleprice'],decreasing = TRUE))
CorHight <- names(which(apply(cor_sorted, 1, function(x) abs(x)>0.5)))
cor_numVar <- cor_numVar[CorHight,CorHight]
corrplot.mixed(cor_numVar, tl.col='black',tl.pos='lt',las=2)
#######################################################################################
#######################################################################################

function(input, output) {
  selectedData <- reactive({
    data <- data[data[,'yearbuilt'] %in% as.numeric(input$year)]
  })
  
  #in More drop down meanu
  output$conditionPlot <- renderPlot ({
    
    plot(data$salecondition,data$saleprice,
         main='Price VS. Year Built',
         xlab = data$salecondition, ylab = 'price')
  })
  
  #in More drop down meanu
  output$qualityPlot <- renderPlot ({
    ggplot(data=data[!is.na(data$saleprice),], aes(x=saletype, y=saleprice))+
      geom_boxplot(col='blue') + labs(x='Overall Quality') +
      theme(panel.border = element_blank(),
            panel.grid = element_blank())
    
  })
    
  #   data[, c("year", input$year), drop = FALSE]
  # }, rownames = TRUE)

  output$scatterplot <- renderPlot({
    
    ggplot(data=data[data[,'neighborhood'] %in% c('NoRidge', 'NridgHt','StoneBr'),],
           aes(x=lotarea,
               y=saleprice,
               color = neighborhood))+
      geom_point() +
      theme(panel.border = element_blank(),
            panel.grid = element_blank())
  })
  
  output$lineplot <- renderPlot({
    ggplot(data, aes(selectedData(), data$saleprice))+
      geom_line()
  })
  
  output$plot1 <- renderPlot({
    ggplot(data) + geom_bar(aes(x = yearbuilt))+
      theme(panel.border = element_blank(),
            panel.grid = element_blank())
  })
  
  output$plot2 <- renderPlot({
    ggplot(data) + geom_bar(aes(x = yearremodadd))+
      theme(panel.border = element_blank(),
            panel.grid = element_blank())
  })
}

