library(shiny)
library(shinydashboard)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(
      title = "Texas Housing Dashboard",
      titleWidth = 300
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem(text = "Vue globale", tabName = "vue", icon = icon("dashboard")),
        menuItem(text = "TOPs", tabName = "top", icon = icon("list-ol")),
        menuItem(text = "Données", icon = icon("chalkboard-user"), href = "https://www.recenter.tamu.edu/")
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "vue",
          box(
            title = "Evolution du volume de ventes",
            footer = "en US$",
            status = "info",
            solidHeader = TRUE,
            width = 8,
            "graphique à prévoir ici"
          ),
          infoBox(
            title = "Progression",
            value = "+ ??%",
            subtitle = "Entre 2000 et 2015",
            icon = icon("line-chart"),
            fill = TRUE,
            color = "light-blue",
            width = 4
          ),
          valueBox(
            value = "??",
            subtitle = "Volume totale des ventes (en milliards)",
            icon = icon("usd"),
            color = "green",
            width = 4
          ),
          tabBox(
            title = "Informations",
            width = 4,
            tabPanel(title = "Onglet 1", "contenu 1"),
            tabPanel(title = "Onglet 2", "contenu 2")
          )
        ),
        tabItem(
          tabName = "top",
          box(title = "Ville", width = 4, "TOP des meilleures villes"),
          box(title = "Année", width = 4, "TOP des meilleurs années"),
          box(title = "Mois", width = 4, "TOP des meilleurs mois")
        )
      )
    ),
    title = "Texas Housing",
    skin = "red"
  ),
  server = function(input, output) {
  }
)