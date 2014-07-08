
library(plyr)
source("R/functions.R")
data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)



###### SAVING TABLES############
# For each year, fit linear model to life expectancy vs gdp by continent
model.data <- ddply(data, .(continent,year), fit.model, x="lifeExp", y="gdpPercap")

# saving to file


####SAVING PLOTS############
data.1982 <- data[data$year == 1982,]
myplot(data.1982,"gdpPercap","lifeExp", main =1982)

# one way of saving to pdf


# a better way of saving to pdf


# similar approach to save png


# nest within loop

