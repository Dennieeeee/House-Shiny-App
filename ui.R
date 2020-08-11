library(shiny)

vars <- setdiff(names(data2), "mssubclass")

pageWithSidebar(
  headerPanel('Housing Explorer'),
  sidebarPanel(
    helpText('Explore the relationships between each features by selecting X and Y variables in the drop down menu below'),
    selectInput('xcol', 'X Variable', vars, selected = vars[[9]]),
    selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
  
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('Introduction',
               tags$div(
                 tags$h4('This project will be focusing on getting a general idea of houses that 
                         were built between 1872 and 2010 in terms of the prices, etc. The purpose 
                         is to present the key information to people who want to buy a house that 
                         was built before 2010. The visualizations in this dashboard explain how 
                         the lot size, sales price, and other features correlate with each other. 
                         My audiences will also be able to gain a better understanding of how many
                         houses were built each year, how many got remodeled, and much more.'),
                 tags$br(),
                 tags$h4("Questions that can be answered are:"),
                 tags$br(),
                 tags$h4(
                   tags$ol(
                     tags$li("Which neighborhood is the most popular and has the greatest number of houses?"), 
                     tags$li("Are there more houses built or got remodeled before and after 1980?"),
                     tags$li("Different types of the alley, utilities, garage, etc."),
                     tags$li("Which condition type of property is the most expensive and cheapest?") 
                   )
                 ),
               ),
      ),
      
      tabPanel('Different Variables',plotOutput('scatterPlot')),
      navbarMenu('Counts',
                 tabPanel('Descriptions',
                          tags$div(
                            tags$h4('Descriptions of each plots'),
                            tags$br(),
                            tags$h4('Street: Type of road access to property'),
                            tags$h5(
                              tags$ol(
                                tags$li('Grvl: Gravel'),
                                tags$li('Pave: Paved'))),
                            tags$h4('Alley: Type of alley access to property'),
                            tags$h5(
                              tags$ol(
                                tags$li('Grvl: Gravel'),
                                tags$li('Pave: Paved'),
                                tags$li('NA: No alley access'))),
                            tags$h4('LotShape: General shape of property'),
                            tags$h5(
                              tags$ol(
                                tags$li('Reg: Regular'),
                                tags$li('IR1: Slightly irregular'),
                                tags$li('IR2: Moderately Irregular'),
                                tags$li('IR3: Irregular'))),
                            tags$h4('Utilities: Type of utilities available'),
                            tags$h5(
                              tags$ol(
                                tags$li('AllPub: All public Utilities (E,G,W,& S)'),
                                tags$li('NoSewr: Electricity, Gas, and Water (Septic Tank)'),
                                tags$li('NoSeWa: Electricity and Gas Only'),
                                tags$li('ELO: Electricity only'))),
                            tags$h4('HouseStyle: Style of dwelling'),
                            tags$h5(
                              tags$ol(
                                tags$li('1Story:	One story'),
                                tags$li('1.5Fin: One and one-half story: 2nd level finished'),
                                tags$li('1.5Unf: One and one-half story: 2nd level unfinished'),
                                tags$li('2Story: Two story'),
                                tags$li('2.5Fin: Two and one-half story: 2nd level finished'),
                                tags$li('2.5Unf: Two and one-half story: 2nd level unfinished'),
                                tags$li('SFoyer: Split Foyer'),
                                tags$li('SLvl: Split Level'))),
                            tags$h4('GarageType: Garage location'),
                            tags$h5(
                              tags$ol(
                                tags$li('2Types	More than one type of garage'),
                                tags$li('Attchd: Attached to home'),
                                tags$li('Basment: Basement Garage'),
                                tags$li('BuiltIn: Built-In (Garage part of house - typically has room above garage)'),
                                tags$li('CarPort: Car Port'),
                                tags$li('Detchd: Detached from home'),
                                tags$li('NA: No Garage'))),
                          )),
                
                 tabPanel('Street Types',plotOutput('countPlot1')),
                 tabPanel('Alley Types',plotOutput('countPlot2')),
                 tabPanel('Lot Shapes',plotOutput('countPlot3')),
                 tabPanel('Utility Types',plotOutput('countPlot4')),
                 tabPanel('House Types',plotOutput('countPlot5')),
                 tabPanel('Garage Types',plotOutput('countPlot6'))),
      tabPanel("Neighborhoods", plotOutput("barplot")),
      tabPanel("Number of Houses", plotOutput("plot1"),plotOutput("plot2")),
      navbarMenu("Quality and Conditions",
                 tabPanel("Type of Sale and Price", plotOutput("saleTypePlot1")),
                 tabPanel("Conditions and Price", plotOutput("conditionPlot"))),
      tabPanel('Summary',
               tags$div(
                 tags$h4('Thanks for exploring the first Shiny Dashboard that I built. From the visualizations, 
                 we gained a better understanding of how many houses were built each year, how the price change over time, and so on. 
                 There are a lot of properties located nearby NAmes, North Ames, but they are also expensive. 
                 Also, more houses were built and got remodeled after 2000. As the price increase, the basement area and garage 
                 area are also getting bigger. Generally, houses that were built around 2010 are expensive. 
                 However, customers can consider the houses that are on low interest rate. 
                 In addition, the partial houses are the ones that were not completed when last assessed. 
                 Customers can choose between normal sale, family sale, abnormal sale, and allocation sale because they are cheaper 
                 than the partial houses. Overall, this dashboard provided a lot of information to support customers’ decision making.
                         '),
                 tags$br(),
                 tags$h4('References'),
                 tags$br(),
                 tags$h4('R graphics with ggplot2 workshop notes. (2020). Retrieved 8 August 2020, 
                         from http://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html'),
                 tags$br(),
                 tags$h4('Shiny - Shiny HTML Tags Glossary. (2020). Retrieved 8 August 2020, 
                        from https://shiny.rstudio.com/articles/tag-glossary.html')
                 
               ))
      
    )
  )
)