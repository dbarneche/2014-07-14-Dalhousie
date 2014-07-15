rescale <- function(x, r.out) {
  if (length(r.out) != 2)
    stop("Expected r.out to be length 2")
  xr <- range(x, na.rm=TRUE)
  p <- (x - min(xr)) / (max(xr) - min(xr))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
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