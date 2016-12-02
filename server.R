shinyServer(function(input, output) {

    # make df reactive
    ratesR <- rates
    makeReactiveBinding("ratesR")
    
    # create table of wage decrease
    wage.table <- reactive({
        input_wage <- input$wage
        
        ratesR <- ratesR %>%
            mutate(inflate.wages = adj_wage(input_wage, rates$rate, inflate=T),
                   discount.wages = adj_wage(input_wage, rates$rate, inflate=F))
        
        # ratesR <- tble
    })
    
    # create table in output
    output$main_plot <- renderPlotly({
        
        df <- as.data.frame(wage.table())
        
        cat(file=stderr(), "column names", df$inflate.wages, df$rate)
        
        plot_ly(df, x = df$year, y = df$inflate.wages, type = 'scatter', mode = 'lines') %>%
            add_trace(y = df$discount.wages, name = 'trace 2', mode = 'markers')
        
    })
})