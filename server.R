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
    
    # reactive commentary
     output$inflate_txt <- renderText({
         # today's year
         year.today <- c(format(Sys.Date(), "%Y"))
         # get wage for the year
         wage.today <- wage.table() %>%
             filter(year == year.today) %>%
             select(inflate.wages, discount.wages)
         c("If your wage kept up with inflation, today it would be ",
           '$', as.character(round(wage.today[1,1],2)),
           "If it hasn't kept up with inflation, your wage in 2013 terms is now ",
           '$', as.character(round(wage.today[1,2],2))
           )
     })
    
    # assign data to output slot
    output$time_series <- renderTable({
        wage.table()
    })
    
    # create plot in output
    output$main_plot <- renderPlotly({
        
        df <- as.data.frame(wage.table())
        
        cat(file=stderr(), df$inflate.wages, df$rate)
        
        plot_ly(df, x = df$year, y = df$inflate.wages, type = 'scatter', mode = 'lines') %>%
            add_trace(y = df$discount.wages, name = 'trace 2', mode = 'markers')
        
    })
})