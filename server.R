library(tidyverse)
library(ggplot2)

function(input, output) {
  selectedData <- reactive({
    data2[, c(input$xcol, input$ycol)]
  })
  
  output$linePlot <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData())
    #points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
  ##############################################################################################################################
  ##############################################################################################################################
  
  #in More drop down menu
  output$conditionPlot <- renderPlot ({
    
    g <- ggplot(data=data[!is.na(data$saleprice),], aes(x=salecondition, y=saleprice))+
      geom_boxplot(aes(color=salecondition)) + labs(x='Sale Condition',y='House Prices',
                                                    title = 'Sale Prices VS. Condition of Properties') +
      theme(panel.border = element_blank(),
            panel.grid = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20,face = 'bold'),
            )
    #g<- g+ggtitle('Condition of Properties VS. Sale Prices')
    g
  })
  
  #in More drop down menu
  output$qualityPlot1 <- renderPlot ({
    ggplot(data=data[!is.na(data$saleprice),], aes(x=saletype, y=saleprice)) +
      geom_boxplot()+
      labs(x='Overall Quality',y='House Price',
           title = 'House Prices in Different Types of Sale') +
      theme(panel.border = element_blank(),
            panel.grid = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20,face = 'bold'))
  })
    
  output$qualityPlot2 <- renderPlot ({
    ggplot(data=data[!is.na(data$saleprice),], aes(x=saletype, y=saleprice))+
      geom_boxplot()+
      geom_jitter(alpha=1,color='tomato')+
      labs(x='Overall Quality') +
      theme(panel.border = element_blank(),
            panel.grid = element_blank())
    
  })

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

