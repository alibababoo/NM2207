library(shiny)
library(ggplot2)
library(dplyr)

library(DT) # For interactive data tables


# Reading the CSV file
swiftdata <- read.csv("swiftdata.csv")

# UI
ui <- fluidPage(
  titlePanel("Taylor Swift's Songs: Data Analysis of her songs with popularity rating of 80 and above"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("columns", "Select Columns to Display", 
                         choices = c("name", "album", "date", "acousticness", "danceability",
                                     "energy", "liveness", "speechiness", "tempo", 
                                     "valence", "popularity", "minutes"),
                         selected = c("name", "album", "date", "acousticness", "danceability",
                                      "energy", "liveness", "speechiness", "tempo", 
                                      "valence", "popularity", "minutes"))
    ),
    mainPanel(
      DTOutput("data_table")
    )
  )
)

# Server
server <- function(input, output) {
  output$data_table <- renderDT({
    datatable(swiftdata[, input$columns], 
              options = list(pageLength = 10),
              rownames = FALSE)
  })
}

shinyApp(ui, server)


