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
    arrange(year)

# add treasury projections for life of agreement
treasury.site <- read_html("http://www.treasury.gov.au/PublicationsAndMedia/Publications/2016/PEFO-2016/HTML/Economic-outlook")
future.rates <- treasury.site               %>%
    html_nodes("table")                     %>% 
    `[[`(1)                                 %>% # select first table
    html_table()                            #%>%

# other table fiddling
colnames(future.rates)  <- future.rates[1, ]    # set first row as colnames
future.rates            <- future.rates[-1, ]   # delete first row
future.rates            <- subset(future.rates, future.rates[,1] == 'Consumer price index') # only CPI
future.rates           <- future.rates[, -c(1,2,3,4,7)]    # drop columns

# What do I have now?
# > future.rates
#   2016-17 2017-18 2018-19 2019-20
# 5       2   2 1/4   2 1/2   2 1/2

# Those fractions are annoying... *** ENTERING MANUAL MODE ***
rates <- rbind(rates, c(2017,.02), c(2018,.0225), c(2019,.0225))


write_csv(rates,'cpi.csv')