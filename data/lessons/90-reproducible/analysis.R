rm(list=ls())
library(plyr)
library(testthat)
source("R/functions-analyses.R")
test_dir('./tests/')

###### LOAD DATA ######
data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)

###### SAVING TABLES ######
# For each year, fit linear model to life expectancy vs gdp by continent
model.data <- ddply(data, .(continent,year), fit.model, x="lifeExp", y="gdpPercap")

# saving to file

