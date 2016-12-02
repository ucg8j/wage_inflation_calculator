fluidPage(
    # Application title
    titlePanel("Are your wages keeping up?"),
    
    sidebarLayout(
        sidebarPanel(
            numericInput("wage", label = "Enter your wage", value = 75000),
            helpText('Source: RBA.gov.au')
        ),
    
    mainPanel(
        plotlyOutput("main_plot"
                   # , height = "300px"
                   )
        
        # Display this only if the density is shown
#         conditionalPanel(condition = "input.density == true",
#                          sliderInput(inputId = "bw_adjust",
#                                      label = "Bandwidth adjustment:",
#                                      min = 0.2, max = 2, value = 1, step = 0.2)
#         )
    )
    
))