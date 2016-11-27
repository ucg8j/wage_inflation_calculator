library(readr)  # fast I/O
library(shiny)  # web framework
library(plotly) # interactive graphs

# read data
rates <- read_csv('cpi.csv')

# what's the avg of the 3 years?
avg.cpi <- mean(rates$rate)