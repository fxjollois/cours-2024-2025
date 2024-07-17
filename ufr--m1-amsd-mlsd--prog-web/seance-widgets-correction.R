library(shiny)
library(shinydashboard)
library(DT)
library(leaflet)
library(geojsonio)
library(dplyr)
library(ggplot2)
library(scales)

txgeo = geojson_read("texas-city.geojson", what = "sp")

resume_year = txhousing %>%
  group_by(city, year) %>%
  summarise(vol = sum(volume, na.rm = TRUE))

resume_all = resume_year %>%
  ungroup() %>%
  group_by(year) %>%
  summarise(vol = sum(vol, na.rm = TRUE))

resume = txhousing %>%
  group_by(city) %>%
  summarise(vol = sum(volume, na.rm = TRUE),
            med = mean(median, na.rm = TRUE)) %>%
  inner_join(resume_year %>%
               ungroup() %>%
               group_by(city) %>%
               summarise(evol = last(vol) / first(vol),
                         evol = ifelse(evol == Inf, NA, evol)))

txgeo@data$city = sub(", TX", "", txgeo@data$name)
txgeo@data = dplyr::left_join(txgeo@data, resume)


shinyApp(
  ui = dashboardPage(
    dashboardHeader( title = "Séance Widgets HTML" ),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Onglet 1", tabName = "ong1", icon = icon("map")),
        menuItem("Onglet 2", tabName = "ong2", icon = icon("globe"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "ong1",
          box(DTOutput("ong1_tab"), width = 6),
          box(plotOutput("ong1_plot"), width = 6),
          box(leafletOutput("ong1_map", height = 600), width = 6)
        ),
        tabItem(
          tabName = "ong2",
          box(selectInput("ong2_var", 
                          label = "Choix de variable représentée", 
                          choices = c("Volume total" = 1, "Prix médian moyen" = 2, "Evolution depuis 2000" = 3)),
              width = 6),
          box(leafletOutput("ong2_map", height = 600), width = 12)
        )
      )
    ),
    title = "Séance Widgets HTML",
    skin = "yellow"
  ),
  server = function(input, output) {
    output$ong1_tab <- renderDT({
      datatable(resume,
                rownames = FALSE,
                colnames = c('Ville' = 'city', 'Volume' = 'vol',
                             'Prix' = 'med', 'Evolution' = 'evol'),
                caption = "Données concernant les ventes immobilières au Texas - 2000-2015",
                extensions = 'FixedColumns',
                options = list(scrollX = TRUE,
                               fixedColumns = list(leftColumns = 1),
                               searching = FALSE,
                               lengthChange = FALSE,
                               pageLength = 16)
                ) %>%
        formatPercentage("Evolution") %>%
        formatCurrency("Volume", currency = " €", mark = " ", digits = 0, before = FALSE) %>%
        formatCurrency("Prix", currency = " €", mark = " ", digits = 0, before = FALSE) %>%
        formatStyle("Volume", 
                    background = styleColorBar(range(resume$vol, na.rm = TRUE), 'lightblue')) %>%
        formatStyle("Prix", 
                    background = styleColorBar(range(resume$med, na.rm = TRUE), 'gray'),
                    backgroundSize = '98%') %>%
        formatStyle("Evolution", 
                    background = styleInterval(c(.9, 1.1), c('Tomato', 'white', 'darkseagreen')))
        
    })
    villes <- reactive({
      resume$city[input$ong1_tab_rows_selected]
    })
    output$ong1_plot <- renderPlot({
      villes = villes()
      res = resume_year %>%
        filter(city %in% villes) %>%
        summarise(year = year, vol = vol / first(vol))
      ggplot(res, aes(year, vol, col = city)) +
        geom_line(data = resume_all %>%
                    summarise(year = year, vol = vol / first(vol)), linetype = "dashed", color = "gray") +
        geom_line(size = 1) +
        scale_y_continuous(labels=scales::percent) +
        labs(x = "", y = "Evolution, en base 100", col = "Villes") +
        theme_minimal()
    })
    output$ong1_map <- renderLeaflet({
      villes = villes()
      txgeo_sel = subset(txgeo, sub(", TX", "", name) %in% villes)
      if (length(txgeo_sel) > 0) {
        leaflet(txgeo_sel) %>%
          addProviderTiles(providers$CartoDB.Positron) %>%
          addPolygons(fillColor = "darkred", fillOpacity = .8, color = "lightgray", weight = 1, label = ~name)
      }
    })
    
    output$ong2_map <- renderLeaflet({
      if (input$ong2_var == 1) { 
        txgeo@data$var = txgeo@data$vol 
        titre = "Volume total des ventes (2000-2015)"
      }
      if (input$ong2_var == 2) { 
        txgeo@data$var = txgeo@data$med 
        titre = "Prix médian moyen sur la période 2000-2015"
      }
      if (input$ong2_var == 3) { 
        txgeo@data$var = txgeo@data$evol 
        titre = "Evolution entre 2000 et 2015 (en %)"
      }
      pal = colorNumeric("Blues", NULL, na.color = "#eeeeee")
      leaflet(txgeo) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        addPolygons(fillColor = ~pal(var), 
                    fillOpacity = .9, 
                    color = "lightgray", weight = 1,
                    label = ~city) %>%
        addLegend(pal = pal, values = ~var, opacity = 1.0,
                  title = titre,
                  labFormat = labelFormat(transform = function(x) round(x)))
    })
  }
)