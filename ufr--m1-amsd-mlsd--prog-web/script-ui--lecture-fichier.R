library(shiny)
library(ggplot2)
library(bslib)

shinyApp(
  ui = fluidPage(
    "Lecture d'un fichier de données",
    theme = bs_theme(version = 4, bootswatch = "minty"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "donnees.choix", 
          label = "Jeu de données",
          selectize = TRUE,
          choices = c("mtcars", 
                      "LifeCycleSavings", 
                      "iris", 
                      "diamonds (ggplot2)" = "diamonds",
                      "txhousing (ggplot2)" = "txhousing",
                      "Fichier à charger" = "fichier")
        ),
        uiOutput("donnees.fichier.ui"),
        textOutput("donnees.nblignes"),
        textOutput("donnees.nbcolonnes")
      ),
      mainPanel(
        dataTableOutput("donnees.rendu"),
        style = "overflow: scroll;"
      )
    )
  ),
  server = function(input, output) {
    donnees.originales <- reactive({
      if (input$donnees.choix != "fichier") {
        # Données internes
        data.frame(get(input$donnees.choix))
      } else {
        # Données à charger
        if (is.null(input$donnees.fichier.input)) return (NULL)
        don = NULL
        try({
          don = read.table(
            input$donnees.fichier.input$datapath, 
            header = input$donnees.fichier.header == "oui", 
            sep = input$donnees.fichier.sep,
            dec = input$donnees.fichier.dec,
            stringsAsFactors = FALSE)
        }, silent = TRUE)
        don
      }
    })
    output$donnees.fichier.ok <- renderUI({
      don = donnees.originales()
      if (is.null(don) & !is.null(input$donnees.fichier.input))
        p(class = "bg-danger", "Impossible de charger le fichier")
    })
    output$donnees.fichier.ui <- renderUI({
      if (input$donnees.choix == "fichier") {
        list(
          fileInput("donnees.fichier.input", "Fichier"),
          radioButtons("donnees.fichier.header", 
                       "Noms de variables",
                       c("oui", "non")),
          radioButtons("donnees.fichier.sep", 
                       "Séparateur", 
                       c("point-virgule" = ";", 
                         "virgule" = ",", 
                         "espace" = " ", 
                         "tabulation" = "\t")),
          radioButtons("donnees.fichier.dec", 
                       "Séparateur de décimales",
                       c("point" = ".", "virgule" = ",")),
          uiOutput("donnees.fichier.ok")
        )
      }
    })
    output$donnees.rendu <- renderDataTable({
      don = donnees.originales()
      if (!is.null(don))
        if (!identical(rownames(don), as.character(1:nrow(don))))
          cbind(" " = rownames(don), don)
        else
          don
    })
    output$donnees.nblignes <- renderText({
      don = donnees.originales()
      if (!is.null(don))
        paste("Nombre de lignes : ", nrow(don))
    })
    output$donnees.nbcolonnes <- renderText({
      don = donnees.originales()
      if (!is.null(don))
        paste("Nombre de colonnes : ", ncol(don))
    })
  }
)