colour.by.category <- function(x, table) {
  unname(table[x])
}

add.trend.line <- function(x, y, d, ...) {
  lx  <-  log10(d[[x]])
  fit <-  lm(d[[y]] ~ lx)
  xr  <-  range(lx)
  lines(10^xr, predict(fit, list(lx=xr)), ...)
}

myplot <- function(data,x,y,...){
  
  col.table <- c(Asia="tomato", Europe="chocolate4", Africa="dodgerblue2", Americas="darkgoldenrod1", Oceania="green4")
  
  plot(data[[y]]~data[[x]], log="x", pch=21, las=1,
       cex=rescale(sqrt(data$pop), c(0.2, 10)),
       col='black', bg=colour.by.category(data$continent, col.table), 
       xlab=x, ylab=y, ...)
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
