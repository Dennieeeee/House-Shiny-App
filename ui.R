library(shiny)
fluidPage(
  headerPanel('Housing Explorer'),

  sidebarLayout(
    sidebarPanel(
      # Select a year
      sliderInput('year',label='year built:',
                  min=1872,max=2010,value = 2010,step = 1),
      selectInput('var1','X Variables',numericVar),
      
      selectInput('var2','Y Variables',numericVar),
      
      numericInput('clusters','Cluster Count',3,min=1,max=9),
  ),

    mainPanel(
      tabsetPanel(
        tabPanel("Scatter", plotOutput("scatterplot")),
        tabPanel("Line", plotOutput("lineplot")),
        # fluidRow(plotOutput('plot1'),
        #          plotOutput('plot2')),
        tabPanel("Number of Houses", plotOutput("plot1"),plotOutput("plot2")),
        navbarMenu("More",
          tabPanel("Quality and Price", plotOutput("qualityPlot")),
          tabPanel("Conditions and Price", plotOutput("conditionPlot"))
        )
      )
    )
  )
)


