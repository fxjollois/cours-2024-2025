library(shiny)
library(shinydashboard)

e = new.env()

ui = dashboardPage(
  dashboardHeader(
    title = "Correction"
  ),
  dashboardSidebar(
    selectInput(
      "choixDF",
      label = "Choix des données",
      choices = c("mtcars", "iris", "LifeCycleSavings", "Fichier texte", "Fichier RData")
    ),
    conditionalPanel(
      condition = "input.choixDF == 'Fichier texte'",
      fileInput("fichierTXT", label = "Fichier à importer", placeholder = "Choississez votre fichier texte"),
      checkboxInput("fichierHeader", label = "Noms de variables présents", value = FALSE),
      radioButtons("fichierSep", label = "Séparateur", 
                   c("point-virgule" = ";", "virgule" = ",", "espace" = " ", "tabulation" = "\t", "autre" = "autre")),
      conditionalPanel(
        condition = "input.fichierSep == 'autre'",
        textInput("fichierSepAutre", label = "Séparateur")
      ),
      radioButtons("fichierDec", label = "Séparateur de décimales",
                   c("point" = ".", "virgule" = ",")),
      checkboxInput("fichierSkip", label = "Ignorer les premières lignes ?"),
      conditionalPanel(
        condition = "input.fichierSkip",
        textInput("fichierSkipNb", label = "Nombre de lignes", value = 0)
      )
    ),
    conditionalPanel(
      condition = "input.choixDF == 'Fichier RData'",
      fileInput("fichierRDATA", label = "Fichier à importer", placeholder = "Choississez votre fichier RData"),
      selectInput("choixVar", label = "Quelle variable prendre ?", choices = NULL)
    )
  ),
  dashboardBody(
    valueBox(textOutput("nbLig"), subtitle = "Lignes", width = 6, icon = icon("grip-lines")),
    valueBox(textOutput("nbCol"), subtitle = "Colonnes", width = 6, icon = icon("grip-lines-vertical")),
    box(
        title = "Contenu du data.frame",
        width = 12,
        DT::dataTableOutput("table")
    )
  ),
  title = "Correction"
)

server = function (input, output, session) {
  donneesTXT <- reactive({
    if (is.null(input$fichierTXT)) return (NULL)
    if (input$fichierSep == 'autre') sep = input$fichierSepAutre
    else sep = input$fichierSep
    don = NULL
    try({
      don = read.table(
        input$fichierTXT$datapath,
        header = input$fichierHeader,
        sep = sep,
        dec = input$fichierDec,
        skip = input$fichierSkipNb,
        stringsAsFactors = FALSE)
    }, silent = TRUE)
    don
  })
  
  observeEvent(input$fichierRDATA, {
    input$fichierRDATA
    
    load(input$fichierRDATA$datapath, envir = e)
    liste = ls(e)
    
    updateSelectInput(session = session, inputId = "choixVar", choices = liste)
  })
  
  donneesRDATA <- reactive({
    don = NULL
    try({
      don = get(input$choixVar, envir = e)
    }, silent = TRUE)
    don
  })
  
  donnees <- reactive({
    don = NULL
    if (input$choixDF == "Fichier texte") {
      # Données à charger
      don = donneesTXT()
    } else {
      if (input$choixDF == "Fichier RData") {
        don = donneesRDATA()
      } else {
        don = get(input$choixDF)
      }
    }
    don
  })
  
  output$table <- DT::renderDataTable({
    donnees()
  })
  output$nbLig <- renderText({ nrow(donnees()) })
  output$nbCol <- renderText({ ncol(donnees()) })
}

shinyApp(ui, server)