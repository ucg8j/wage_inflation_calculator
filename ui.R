fluidPage(
    # include google analytics
    tags$head(includeScript("google-analytics.js")),
    
    # Application title
    titlePanel("Are your wages keeping up with inflation?"),
    
    # User Input
    sidebarLayout(
        sidebarPanel(
            numericInput("wage", label = "Enter your base annual salary", value = 75000),
            helpText('Data sourced from', 
                     a("RBA.gov.au", href='http://www.rba.gov.au/inflation/measures-cpi.html'),
                     '+', 
                     a('treasury.gov.au', href='http://www.treasury.gov.au/PublicationsAndMedia/Publications/2016/PEFO-2016/HTML/Economic-outlook')),
            helpText(a('Code and Methodology', href='https://github.com/ucg8j/wage_inflation_calculator'))
        ),
    
    # Outputs
    mainPanel(
        plotlyOutput("main_plot"),
        textOutput('inflate_txt'), br(),
        tableOutput("time_series")
    )
    
))