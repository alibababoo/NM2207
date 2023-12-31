library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  h1("A day in My life"),
  
  # App title ----
  titlePanel("awesome!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 100,
                  value = 40)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot"),
      
      h1("here"),
      plotOutput(outputId = "Plot2")
      
    )
  )
)

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
  output$distPlot <- renderPlot({
    
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    
  })
  
  titlePanel("yay!")
  
  output$Plot2 <- renderPlot({
    y<- faithful$waiting
    
    ggplot(faithful) +
      aes(x=y) +
      geom_histogram(bins = input$bins)
    
  })
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)