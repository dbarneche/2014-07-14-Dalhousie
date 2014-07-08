
rescale <- function(x, r.out) {
  p <- (x - min(x)) / (max(x) - min(x))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
}

colour.by.category <- function(x, table) {
  unname(table[x])
}

add.trend.line <- function(x, y, d, ...) {
  fit <- lm(d[[y]] ~ log10(d[[x]]))
  abline(fit, ...)
}

pop.by.country.relative <- function(country, data, base.year=1952) {
  dsub <- data[data$country == country, c("year", "pop")]
  dsub$pop.rel <- dsub$pop / dsub$pop[dsub$year == base.year]
  dsub
}

fit.model <- function(d, x, y) {
  fit <- lm( d[[y]] ~ log10(d[[x]]) )
  data.frame(n=length(d[[y]]), r2=summary(fit)$r.squared,a=coef(fit)[1],b=coef(fit)[2])
}

myplot <- function(data,x,y,...){
  
  col.table <- c(Asia="tomato", Europe="chocolate4", Africa="dodgerblue2", Americas="darkgoldenrod1", Oceania="green4")
    
  plot(data[[y]]~data[[x]], log="x", pch=21,
       cex=rescale(sqrt(data$pop), c(0.2, 10)),
       col=colour.by.category(data$continent, col.table), 
       xlab=x, ylab=y,...)
  d_ply(data, .(continent), function(df) add.trend.line(x, y, df, col=col.table[df$continent]))
}


to.pdf <- function(expr, filename, ..., verbose=TRUE) {
  if ( verbose )
    cat(sprintf("Creating %s\n", filename))
  pdf(filename, ...)
  on.exit(dev.off())
  eval.parent(substitute(expr))
}


to.dev <- function(expr, dev, filename, ..., verbose=TRUE) {
  if ( verbose )
    cat(sprintf("Creating %s\n", filename))
  dev(filename, ...)
  on.exit(dev.off())
  eval.parent(substitute(expr))
}
