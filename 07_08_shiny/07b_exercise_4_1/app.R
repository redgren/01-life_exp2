library(shiny)

ui <- fluidPage(
  textInput("name", "What is your name?"),
  textOutput("greetname")
)

server <- function(input, output) {
  output$greetname <- renderText({
    paste("Hello", input$name)
  })
}

shinyApp(ui = ui, server = server)
