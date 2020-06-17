library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Histograms of mtcars Variables"),
  sidebarLayout(
    sidebarPanel(
      textInput("title", "What should the title be?", value = "Title"),
      sliderInput("bins", "How many bins?", min = 1, max = 50, value = 25),
      varSelectInput("var", "Which variable?", data = mtcars)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(mtcars, aes(x = !!input$var)) +
      geom_histogram(bins = input$bins) +
      ggtitle(input$title) +
      theme_bw()
  })
}

shinyApp(ui = ui, server = server)
