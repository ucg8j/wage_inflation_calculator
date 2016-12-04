fluidPage(
    # include google analytics
    tags$head(includeScript("google-analytics.js")),
    
    # Application title
    titlePanel("Are your wages keeping up?"),
    
    # User Input
    sidebarLayout(
        sidebarPanel(
            numericInput("wage", label = "Enter your wage", value = 75000),
            helpText('Source: RBA.gov.au')
        ),
    
    # Outputs
    mainPanel(
        plotlyOutput("main_plot"),
        textOutput('inflate_txt'), br(),
        tableOutput("time_series")
    )
    
))