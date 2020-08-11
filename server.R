library(tidyverse)
library(ggplot2)
library(dplyr)

function(input, output) {
  selectedData <- reactive({
    data2[, c(input$xcol, input$ycol)]
  })
  
  output$scatterPlot <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(mar = c(5.1, 4.1, 2.5, 1))
    plot(selectedData(),main = 'Scatter Plot between X Variable and Y Variable')
      
  })
  #################################################################################################################
  
  output$countPlot1 <- renderPlot({
    plot(data$street, main = 'Street Types', xlab='Type of Street', ylab='Count')
  })
  output$countPlot2 <- renderPlot({
    plot(data$alley, main = 'Types of Alley', xlab='Type of Alley', ylab='Count')
  })
  output$countPlot3 <- renderPlot({
    plot(data$lotshape, main = 'General shape of property',xlab='Lot Shape', ylab='Count')
  })
  output$countPlot4 <- renderPlot({
    plot(data$utilities, main = 'Type of utilities available', xlab='Utilities', ylab='Count')
  })
  output$countPlot5 <- renderPlot({
    plot(data$housestyle, main = 'Style of dwelling', xlab='House Style', ylab='Count')
  })
  output$countPlot6 <- renderPlot({
    plot(data$garagetype, main = 'Type of Garage',xlab='Garage Types', ylab='Count')
  })
  
  #################################################################################################################
  output$barplot <- renderPlot({
    data %>% 
      mutate(Highest_Count = ifelse(neighborhood == 'NAmes', T, F)) %>% 
      ggplot(aes(x = neighborhood)) +
      geom_bar(aes(stat="identity", fill = Highest_Count))+
      labs(x='Neighborhoods',y='Number of Houses',title = 'Number of Houses in Each Neighborhood')+
      theme(panel.border = element_blank(),
            panel.grid = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20,face = 'bold'))
    
  })
  
  #visualize the amount of houses built each year
  output$plot1 <- renderPlot({
    g <- ggplot(data) + geom_bar(aes(x = yearbuilt))+
      labs(x='Year Built',y='Number of Houses',title = 'Number of Houses Built in Each Year')+
      theme(panel.border = element_blank(),
            panel.grid = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20,face = 'bold'))
    g+scale_fill_gradient(low="blue", high="red")
  })
  
  output$plot2 <- renderPlot({
    ggplot(data) + geom_bar(aes(x = yearremodadd))+
      scale_fill_continuous(type = "viridis")+
      labs(x='Year Remodeled',y='Number of Houses',title = 'Number of Houses Remodeled in Each Year')+
      theme(panel.border = element_blank(),
            panel.grid = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20,face = 'bold'))
  })

  
  #in More drop down menu
  output$conditionPlot <- renderPlot ({
    
    ggplot(data=data[!is.na(data$saleprice),], aes(x=salecondition, y=saleprice))+
      geom_boxplot(aes(color=salecondition)) + 
      labs(x='Sale Condition',y='House Prices', title = 'House Prices in Different Conditions of Properties') +
      theme(panel.border = element_blank(),
            panel.grid = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20,face = 'bold'),
      )
  
  })
  
  #in More drop down menu
  output$saleTypePlot1 <- renderPlot ({
    ggplot(data=data[!is.na(data$saleprice),], aes(x=saletype, y=saleprice)) +
      geom_boxplot(aes(color=saletype))+
      labs(x='Type of Sale',y='House Prices',
           title = 'House Prices in Different Types of Sale') +
      theme(panel.border = element_blank(),
            panel.grid = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20,face = 'bold'))
  })
  
  
}

