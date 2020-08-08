library(shiny)

vars <- setdiff(names(data2), "mssubclass")

pageWithSidebar(
  headerPanel('Housing Explorer'),
  sidebarPanel(
    helpText('Explore the relationships between each features by selecting X and Y variables in the drop down meanu below'),
    selectInput('xcol', 'X Variable', vars, selected = vars[[9]]),
    selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('Introduction',
               tags$div(
                 tags$h4('This project will be focusing on getting a general idea of houses that were 
                 built between 1872 and 2010 in terms of the prices, etc.
                 The purpose is to present the key information for people who want to buy a house 
                 that was built prior to 2010. 
                 Initially, I will analyze how lot size, sales price, and other variables changed throughout years. Next, I will
                 look into lot size and sale price of the houses located around the top 3 most expensive neighborhoods. My audiences
                 will also be able to gain a better understanding of how many houses were built each year, how many got remodeled, 
                 and much more.'),
                 tags$br(),
                 tags$h4("The business questions are:"),
                 tags$br(),
                 tags$h5(
                   tags$ol(
                     tags$li("How did the lot size of houses change throughout years?"), 
                     tags$li("What is the relationship between lot size and sales price of houses in different neighberhoods?"), 
                     tags$li("How many houses were built each year and how many houses got remodeled each year?") 
                   )
                 ),
               ),
      ),
      
      tabPanel('Line',plotOutput('linePlot')),
      tabPanel("Scatter", plotOutput("scatterplot")),
      tabPanel("Number of Houses", plotOutput("plot1"),plotOutput("plot2")),
      navbarMenu("More",
                 tabPanel("Quality and Price", plotOutput("qualityPlot1"),plotOutput("qualityPlot2")),
                 tabPanel("Conditions and Price", plotOutput("conditionPlot"))
      )
    )
  )
)