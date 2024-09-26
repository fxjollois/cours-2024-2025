
library(shiny)

library(tidyverse)

csv = read_csv("../scimagojr.csv")

top_regions = csv %>%
  group_by(Region) %>%
  summarise(Documents = sum(Documents))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Séance 2 - demande"),
    
    fluidRow(
      column(width = 4, plotOutput("top_regions")),
      column(width = 8, plotOutput("par_annee"))
    ),
    fluidRow(
      plotOutput("documents_citations")
    )

)

# Define server logic required to draw a histogram
server <- function(input, output) {

    
}

# Run the application 
shinyApp(ui = ui, server = server)
