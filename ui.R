fluidPage(
    # Application title
    titlePanel("Are your wages keeping up?"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput("wage", label = "Enter your wage", value = 75000),
            helpText('Source: RBA.gov.au')
        ),
    
    mainPanel(
        plotlyOutput("main_plot"),
        textOutput('inflate_txt'), br(),
        tableOutput("time_series")
    )
    
))