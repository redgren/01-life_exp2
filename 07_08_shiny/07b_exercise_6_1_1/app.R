library(shiny)
library(ggplot2)

ui <- fluidPage(
  sliderInput("nsamp", "Sample Size", value = 50, min = 1, max = 200),
  plotOutput("plot"),
  verbatimTextOutput("summary")
)

server <- function(input, output, session) {

  timer2 <- reactiveTimer(2000)

  samp <- reactive({
    timer2()
    rnorm(input$nsamp)
  })

  output$plot <- renderPlot({
    qplot(samp(), bins = 20)
  })

  output$summary <- renderPrint({
    summary(samp())
  })
}

shinyApp(ui, server)
