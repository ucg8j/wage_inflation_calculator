library(readr)  # fast I/O
library(shiny)  # web framework
library(plotly) # interactive graphs
library(scales) # dataTable formatting

# read data
rates <- read_csv('cpi.csv')

# return vector of adjusted wages
adj_wage <- function(wage, rates, inflate){

    wages <- vector()       # initialise vector
    wages <- c(wages, wage) # provide start value
    
    # for each inflation rate calculate inflated/deflated amount
    for (i in rates){
        
        # take the last wage value
        wage <- as.numeric(wages[length(wages)])
        
        if (inflate){
            w <- wage + (wage*i)
        } else {
            w <- wage - (wage*i)
        }
        wages <- c(wages,w)
    }
    
    return(wages[-1])
}