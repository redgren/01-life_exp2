library(shiny)
library(ggplot2)

ui <- fluidPage(
  fluidRow(column(6,
                  varSelectInput("var1", "Variable 1", data = iris),
                  varSelectInput("var2", "Variable 2", data = iris,
                                 selected = "Sepal.Width")
           ),
           column(6)
  ),
  fluidRow(column(6),
           column(6,plotOutput("plot")
           )
)
)
server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(iris, aes(x = !!input$var1, y = !!input$var2,
                     color = iris$Species)) +
      geom_point()
  })

}

shinyApp(ui = ui, server = server)
