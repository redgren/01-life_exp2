library(shiny)

ui <- fluidPage(
  tags$img(src = "AU-Logo-on-white-small.png"),
  wellPanel(
  tags$h1("AU Website Video"),
  tags$br(),
  tags$h5("Open in a browser"),
  tags$hr(),
  tags$video(width="100%", type = "video/mp4", autoplay=TRUE, muted = NA, loop = NA,
              src = "AU20191011_Early_Fall.mp4")
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
