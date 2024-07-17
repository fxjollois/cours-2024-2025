library(shiny)
library(shinydashboard)
library(formattable)
library(ggplot2)
library(dplyr)

resume = txhousing %>%
  group_by(city) %>%
  summarise(volume = sum(volume, na.rm = TRUE)) %>%
  mutate(volume = accounting(volume, big.mark = " "),
         volumeEuro = currency(volume, symbol = "€", big.mark = " "),
         part = percent(volume / sum(volume, na.rm = TRUE)))

format_vol <- formatter(
  "span", 
  style = ~ style(color = ifelse(part > .20, "green", "black"),
                  "font-weight" = ifelse(part > .20, "bold", NA)))
formattable(resume, list(part = format_perf, volumeEuro = format_volume))

formattable(
  resume, 
  list(
    volume = format_vol,
    volumeEuro = color_tile("", "darkgreen"),
    part = color_bar("orange")
  )
)


shinyApp(
  ui = dashboardPage(
    dashboardHeader( title = "Test formattable" ),
    dashboardSidebar(),
    dashboardBody(
      formattableOutput("tableau"),
      
    ),
    title = "Test formattable",
    skin = "yellow"
  ),
  server = function(input, output) {
    output$tableau <- renderFormattable({
      formattable(resume, list(part = format_perf))
    })
  }
)