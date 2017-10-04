#########################
MyData <- read.csv("UNdata_Export_20170922_054017352_MalariaCases_mod.csv")
#########################
# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Malaria Incidences"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      #sliderInput(inputId = "bins",
      #label = "Number of bins:",
      #min = 1,
      #max = 50,
      #value = 30)
      selectInput (inputId = "Country",
                   label = "Countries To Plot",
                   choices = levels(MyData$Country.or.Area),
                   multiple = T,
                   selectize = F,
                   size = 10
      )
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "LinePlot")
      
    )
  )
)

