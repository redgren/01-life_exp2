library(shiny)
library(readr)
library(dplyr)
options(shiny.maxRequestSize = 10 * 1024^2)
#only set up for multiple files with the same columns.
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "What file(s)?",
                accept = "text/csv", multiple = TRUE),
      varSelectInput("dfx", "Select categorical X variable", character(0)),
      varSelectInput("dfy", "Select quantitative Y variable", character(0)),
      checkboxInput("logdata", "Log Y Data?")
    ), # sidebarPanel
    mainPanel(
      plotOutput("boxp"),
      verbatimTextOutput("summ")
    ) # mainPanel
  ) #sidebarLayout
) #fluidPage

server <- function(input, output, session) {

  df <- reactive({
    req(input$file)
    n_files <- nrow(input$file)
    dlist <- vector("list", length = n_files)
    for (i in seq(1:n_files)){
      dlist[[i]] <- read_csv(input$file[[i, "datapath"]])
    }
    df<- bind_rows(dlist)
  })
  observeEvent(df(), {
    updateSelectInput(session, "dfx", choices = names(df()))
  })

  observeEvent(df(), {
    updateSelectInput(session, "dfy", choices = names(df()))
  })

  output$summ <- renderPrint({
    summary(df())
  })
  output$boxp <- renderPlot({
    p <- ggplot(df(),aes(x=as.factor(!!input$dfx), y = !!input$dfy)) +
      geom_boxplot()
    if (input$logdata){
      p <- p + scale_y_log10()
    }
    p
  }) #renderPLot
}

shinyApp(ui, server)
