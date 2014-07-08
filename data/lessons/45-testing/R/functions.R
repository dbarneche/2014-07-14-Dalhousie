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

linear.rescale  <-  function(x, range) {
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

add.trend.line  <-  function(x, y, d, col) {
  fit  <-  lm(d[[y]]~log10(d[[x]]))
  abline(fit, col=col, lwd=1.5, lty=2)
}

my.plot  <-  function(year, data, cols) {
  data.year  <-  data[data$year == year, ]
  col       <-  colour.by.category(data.year$continent, cols)
  cex       <-  linear.rescale(sqrt(data.year$pop), range=c(0.2,10))
  plot(lifeExp ~ gdpPercap, data.year, las=1, xlab='GDP per capta', ylab='Life expectancy', cex=cex, col='black', bg=col, pch=21, log="x", xlim=c(240,114000), ylim=c(20,85), main=unique(data.year$year))
  
  for(continent in unique(data.year$continent)) {
    add.trend.line("gdpPercap", "lifeExp",
                   d=data.year[data.year$continent == continent,],
                   col=cols[[continent]])
  }
}
