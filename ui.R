#########################
MyData <- read.csv("UNdata_Export_20170922_054017352_MalariaCases_mod.csv")
#########################
ui <- fluidPage(
  
  #### App title ###
  titlePanel("Malaria Incidences"),
  
  sidebarLayout(
    
    
    sidebarPanel(
      
      
      selectInput (inputId = "Country",
                   label = "Countries To Plot",
                   choices = levels(MyData$Country.or.Area),
                   multiple = T,
                   selectize = F,
                   size = 10
      )
      
    ),
    
    
    mainPanel(
      
      
      plotOutput(outputId = "LinePlot")
      
    )
  )
)

