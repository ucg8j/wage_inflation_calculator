fluidPage(
    # include google analytics
    tags$head(includeScript("google-analytics.js")),
    
    # Application title
    titlePanel("Are your wages keeping up?"),
    
    # User Input
    sidebarLayout(
        sidebarPanel(
            numericInput("wage", label = "Enter your wage", value = 75000),
            helpText('Data sourced from RBA.gov.au + treasury.gov.au'),
            helpText(a('Code and Methodology', href='https://github.com/ucg8j/wage_inflation_calculator'))
        ),
    
    # Outputs
    mainPanel(
        plotlyOutput("main_plot"),
        textOutput('inflate_txt'), br(),
        tableOutput("time_series")
    )
    
))