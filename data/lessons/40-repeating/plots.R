source("R/functions.R")
library(plyr)

data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)

##################################
# Example 1 - plot life expectancy vs GDP per capita in 1982, fitting a trend line to each continent

data.1982 <- data[data$year == 1982,]

col.table <- c(Asia="tomato", Europe="chocolate4", Africa="dodgerblue2", Americas="darkgoldenrod1", Oceania="green4")
plot(lifeExp ~ gdpPercap, data.1982, log="x", cex=rescale(sqrt(data.1982$pop), c(0.2, 10)), col= colour.by.category(data.1982$continent, col.table), pch=21)
add.trend.line("gdpPercap", "lifeExp", data.1982[data.1982$continent == "Asia",], col=col.table["Asia"])
add.trend.line("gdpPercap", "lifeExp", data.1982[data.1982$continent == "Africa",], col=col.table["Africa"])
add.trend.line("gdpPercap", "lifeExp", data.1982[data.1982$continent == "Europe",], col=col.table["Europe"])
add.trend.line("gdpPercap", "lifeExp", data.1982[data.1982$continent == "Americas",], col=col.table["Americas"])
add.trend.line("gdpPercap", "lifeExp", data.1982[data.1982$continent == "Oceania",], col=col.table["Oceania"])

# A better appproach using plyr



##################################
# Example 2 - population growth from 1952

plot(pop.rel ~ year, pop.by.country.relative("India", data), type="o")
lines(pop.rel ~ year, pop.by.country.relative("Australia", data), type="o", col="green4")
lines(pop.rel ~ year, pop.by.country.relative("China", data), type="o", col="red")

# A better appproach using plyr

