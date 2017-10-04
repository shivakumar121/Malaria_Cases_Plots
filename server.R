# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  MyData <- read.csv("UNdata_Export_20170922_054017352_MalariaCases_mod.csv")
  library(ggplot2)
  output$LinePlot <- renderPlot({
    CountryList <- input$Country
    TempIndex <- MyData$Country.or.Area %in% CountryList
    MySubsetDataList <- MyData[TempIndex,]
    MySubsetDataList$PercentChange <- rep(0, times = nrow(MySubsetDataList))
    colnames(MySubsetDataList)[1] <- "Country"
    for (CurrentCountry in levels(as.factor (as.character (MySubsetDataList$Country))))
    {
      TempIndex <- which(MySubsetDataList$Country == CurrentCountry)
      MinYearData <- min(MySubsetDataList[TempIndex, "Year.s."])
      StartValues <- MySubsetDataList[TempIndex,]$Value[which(MySubsetDataList[TempIndex,]$Year.s. == MinYearData)]
      if (StartValues == 0)
      {
        StartValues <- 1
      }
      PercentChangeTemp <- MySubsetDataList[TempIndex,"Value"]
      PercentChangeTemp <- ((PercentChangeTemp - StartValues) / StartValues) * 100
      MySubsetDataList$PercentChange[TempIndex] <- PercentChangeTemp
    }
    p1 <- ggplot(data = MySubsetDataList, aes(x = Year.s., y = PercentChange)) + geom_line(aes(color = Country),
                                                                                           size = 1.2
    ) + geom_point(size = 2.4)
    p1 <- p1 + scale_x_continuous(limits = c(min(MyData$Year.s.), max(MyData$Year.s.)), breaks = seq(from = min(MyData$Year.s.), to = max(MyData$Year.s.), by=1))
    p1 <- p1 + theme(panel.background = element_rect(fill = "white"),
                     panel.grid.major = element_line(color = "grey90"),
                     plot.background = element_rect(fill = "grey90"),
                     axis.title.x = element_text(size = 15),
                     axis.title.y = element_text(size = 15),
                     legend.title = element_text(size = 15),
                     legend.position = "bottom",
                     legend.text = element_text(size = 12),
                     axis.text.x = element_text(size = 12),
                     axis.text.y = element_text(size = 12))
    p1 <- p1 + labs (x = "Years", y = "Percent Change in Malaria Cases")
    p1
    
    
    
  })
  
}
