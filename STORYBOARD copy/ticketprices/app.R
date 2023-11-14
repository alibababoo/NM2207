

# scatter plot showing the popularity rating of her songs above or at the popularity rating of 80
library(shiny)
library(DT)
library(ggplot2)

swiftdata <- read.csv("swiftdata copy.csv")

# UI
ui <- fluidPage(
  titlePanel("Individual popularity rating of Taylor's top 63 songs"),
  mainPanel(
    DTOutput("data_table"),
    plotOutput("scatter_plot", width = "100%", height = "500px")
  )
)

# Server
server <- function(input, output) {
  output$data_table <- renderDT({
    columns_to_display <- setdiff(input$columns, c("name", "popularity"))
    swiftdata[, columns_to_display]
  })
  
  output$scatter_plot <- renderPlot({
    plot_data <- swiftdata[, c("name", "popularity", "album")]
    
    ggplot(plot_data, aes(x = popularity, y = name, color = album)) +
      geom_point() +
      theme(axis.text.x = element_text(angle = 360, hjust = 1)) +
      labs(x = "Popularity", y = "Song Names", color = "Album") +
      scale_color_discrete(name = "Album") +
      theme(legend.position = "top") + 
      scale_y_discrete(position = "left") +
      theme(axis.text.y = element_text(angle = 0, hjust = 1)) 
  }, width = 1100, height = 1200)
}

shinyApp(ui, server)


