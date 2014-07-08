########################
# ANALYTICAL FUNCTIONS #
########################
double  <-  function(x) {
  x * 2
}

average  <-  function(x) {
  sum(x) / length(x)
}

variance  <-  function(x) {
  x <- na.omit(x)
  if(length(x) == 0){
    stop("Can't compute the variance of no numbers")
  }
  (1 / (length(x) - 1)) * sum((x-mean(x))^2)
}

rescale  <-  function(x, range) {
  p  <-  (x - min(x)) / (max(x) - min(x))
  range[[1]] + p * (range[[2]] - range[[1]])
}

get.n.countries  <-  function(x) {
  length(unique(x$country))
}

get.total.pop  <-  function(x) {
  sum(x$pop)
}

get.countries  <-  function(x) {
  unique(x$country)
}

model  <-  function(x) {
  fit  <-  lm(lifeExp ~ log10(gdpPercap), data=x)
  c(n=length(x$lifeExp), r2=summary(fit)$r.squared, a=coef(fit)[[1]], b=coef(fit)[[2]])
}

######################
# PLOTTING FUNCTIONS #
######################
colour.by.category <- function(things, table) {
  unname(table[things])
}

add.trend.line <- function(x, y, d, ...) {
  lx <- log10(d[[x]])
  fit <- lm(d[[y]] ~ lx)
  xr <- range(lx)
  lines(10^xr, predict(fit, list(lx=xr)), ...)
}

add.continent.trend.line <- function(x, y, d, continent, col.table, ...) {
  add.trend.line(x, y, d[d$continent == continent,], col=col.table[continent], ...)
}

f <- function(continent) {
  add.continent.trend.line("gdpPercap", "lifeExp", data.1982, continent, col.table)
}

##########################
# ANALYSES FORM LESSON 1 #
##########################
data <- read.csv("gapminder-FiveYearData.csv", stringsAsFactors=FALSE)

double(pi)
double(2)

data.1982  <-  data[data$year == 1982, ]
average(data.1982$gdpPercap) #same as: sum(data.1982$gdpPercap) / length(data.1982$gdpPercap)
variance(data.1982$pop) #try with var(data.1982$pop)

##########################
# ANALYSES FORM LESSON 2 #
##########################
library(plyr)
get.n.countries(data)

n.countries  <-  integer(0)
for(continent in unique(data$continent)) {
  n.countries[[continent]]  <-  get.n.countries(data[data$continent == continent, ])    
}
n.countries

#USING PLYR 
ddply(data, .(continent), get.n.countries)
ddply(data, .(continent, year), get.n.countries)
ddply(data, .("continent", "year"), get.n.countries)
ddply(data, ~continent*year, get.n.countries)
get.total.pop(data)
ddply(data, .(continent, year), get.total.pop)
ddply(data, .(continent, year), function(x)sum(x$pop))
lmPerContAndYear  <-  dlply(data, .(continent, year), model)

######################
# MAKE PLOTS BY YEAR #
######################
col.table  <-  c(Asia='tomato',
                 Europe='chocolate4',
                 Africa='dodgerblue2',
                 Americas='darkgoldenrod1',
                 Oceania='green4')

col <- colour.by.category(data.1982$continent, col.table)
cex <- rescale(sqrt(data.1982$pop), c(0.2, 10))

plot(lifeExp ~ gdpPercap, data.1982, log="x", cex=cex, col=col, pch=21)
f("Africa")
f("Asia")
f("Europe")
f("Americas")
f("Oceania")
