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
    })
    
    # reactive commentary
     output$inflate_txt <- renderText({
         
         # today's year
         year.today <- c(format(Sys.Date(), "%Y"))
         
         # get wage for the year
         wage.today <- wage.table()             %>%
             filter(year == year.today | year == 2019)  %>% # TODO should change variable name or put 2019 elsewhere
             arrange(year)                      %>%
             select(inflate.wages, discount.wages) 
             
         
         # text output
         paste0("If your wage kept up with inflation, today it would be ",
           '$', format(round(wage.today[1,1],2), big.mark = ","),
           ". If it hasn't kept up with inflation, your wage expressed in 2013 terms is now ",
           '$', format(round(wage.today[1,2],2), big.mark = ","), 
           '. The payrise needed to keep pace with inflation up to 2016 is approximately ', 
           round((wage.today[1,1]-input$wage)/input$wage*100,1), ' percent. By 2019 approximately a ',
           round((wage.today[2,1]-input$wage)/input$wage*100,1),  
           ' percent increase is needed to keep up with inflation.'
           )
     })
    
    # assign data to output slot
    output$time_series <- renderTable({ 
        df <- wage.table()
        
        # improve the formatting
        df$`wage to keep up` <- paste0('$', comma(df$inflate.wages))    # 70000 to $70,000
        df$`2013 wages`      <- paste0('$', comma(df$discount.wages))   # 70000 to $70,000
        df$year              <- paste0(floor(df$year))                  # 2013.00 to 2013
        df$inflation.rate    <- paste0(df$rate*100, '%')                  # 2013.00 to 2013
        df$discount.wages    <- NULL
        df$inflate.wages     <- NULL
        df$rate              <- NULL
        df
    })
    
    # create plot in output
    output$main_plot <- renderPlotly({
        
        df <- as.data.frame(wage.table())
        
        plot_ly(df, x = df$year, y = df$inflate.wages, name = 'wage needed', type = 'scatter', mode = 'lines') %>%
            add_trace(y = df$discount.wages, name = 'real wage loss', mode = 'lines')
        
    })
})