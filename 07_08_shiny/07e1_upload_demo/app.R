library(shiny)
library(readr)
estate <- read_csv("./data/estate.csv")

ui <- fluidPage(
  tableOutput("estate")
)

server <- function(input, output, session) {
  output$estate <- renderTable({
    head(estate)
  })
}

shinyApp(ui, server)
