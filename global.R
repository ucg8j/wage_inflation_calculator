library(readr)  # fast I/O
library(shiny)  # web framework
library(plotly) # interactive graphs

# read data
rates <- read_csv('cpi.csv')

# what's the avg of the 3 years?
avg.cpi <- mean(rates$rate)

# return vector of adjusted wages
adj_wage <- function(wage, rates, inflate){

    wages <- vector()
    
    for (i in rates){
        w       <- ifelse(inflate, wage - wage*i, wage + wage*i)
        wages   <- c(wages,w)
    }
    
    return(wages)
}