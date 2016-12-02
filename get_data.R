library(rvest) # webscrape
library(dplyr) # data munging
library(readr) # fast I/O

# obtain inflation rates from 6/2013 
rba.site <- read_html("http://www.rba.gov.au/inflation/measures-cpi.html")

# vector to replace 'jun' values
years <- c(2014,2015,2016)

# extract table
rates <- rba.site                   %>%
    html_nodes("table")             %>% 
    `[[`(1)                         %>% # select first table
    html_table()                    %>%
    filter(X1 == 'Jun')             %>% # select EOFY figures
    mutate(X1 = years,
           X2 = as.numeric(X2)/100) %>%
    select(year = X1, 
           rate = X2)               %>%
    rbind(c(2013,0))                %>% # add a zero/start year
    rbind(c(2017,.02),                  # add future CPI rates from Treasury webpage
          c(2018,.0225),                # see README for source and rationale for not webscraping
          c(2019,.0225))            %>%   
    arrange(year)                   %>%
    write_csv('cpi.csv')