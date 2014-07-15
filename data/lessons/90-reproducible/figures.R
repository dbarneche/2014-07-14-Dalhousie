rm(list=ls())
library(plyr)
source("R/functions-analyses.R")
source("R/functions-figures.R")

data      <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)
data.1982 <- data[data$year == 1982,]

myplot(data.1982,"gdpPercap","lifeExp", main=1982, lty=2)

# one way of saving to pdf


# a better way of saving to pdf


# similar approach to save png


# nest within loop

