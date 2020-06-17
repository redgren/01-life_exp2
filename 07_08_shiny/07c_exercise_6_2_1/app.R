library(shiny)
library(tidyverse)
library(broom)

ui <- fluidPage(
  numericInput("nsamp", "Number of samples", value = 50, step = 1),
  numericInput("diff", "Effect size", value = 0.5, step = 0.1),
  plotOutput("plot"),
  verbatimTextOutput("text")
)

server <- function(input, output) {
  timer1 <- reactiveTimer(1000)

  x1 <- reactive({
    timer1() #note the use of ()
    rnorm(n = input$nsamp, mean = 0, sd = 1)
  })

  x2 <- reactive({
    timer1() #note the use of ()
    rnorm(n = input$nsamp, mean = input$diff, sd = 1)
  })

  output$plot <- renderPlot({
    data.frame(`1` = x1(), `2` = x2()) %>%
      pivot_longer(cols = everything(),names_to = "Group", values_to = "y") %>%
      ggplot(aes(x = Group, y = y)) +
      geom_boxplot() +
      theme_bw()
  })

  output$text <- renderPrint({
    t.test(x1(), x2()) %>%
      tidy() %>%
      select(estimate, `P-value` = p.value, Lower = conf.low, Higher = conf.high)
  })
}

shinyApp(ui = ui, server = server)
