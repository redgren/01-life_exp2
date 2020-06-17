library(shiny)
library(ggplot2)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      varSelectInput("var", "Variable", data = iris),
      sliderInput("bins", "Bin Width?", min = 1, max = 50, value = 20),
      sliderInput("bw", "Bandwidth", min = .01, max = .5, value = .25)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Histogram", plotOutput("hist")
                 ),
        tabPanel("Density", plotOutput("density")
                 ),
        tabPanel("Boxplot", plotOutput("box")
                 )
      ) # tabsetPanel
    ) # mainPanel
  ) #sidebarLayout

)#fluidPage

server <- function(input, output, session) {
  output$hist <- renderPlot({
    ggplot(iris, aes(x = !!input$var)) +
      geom_histogram(bins = input$bins)
  })
  output$density <- renderPlot({
    ggplot(iris, aes(x = !!input$var)) +
      geom_density(bw = input$bw)
  })
  output$box <- renderPlot({
    ggplot(iris, aes(y = !!input$var)) +
      geom_boxplot()
  })
}

shinyApp(ui, server)
