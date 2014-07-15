

# Examples from lesson #1 - Intro to R - presented by Diego Barneche  

## Vector types

There are 5 different types of vector in R.  

```r
x <- TRUE       # x becomes TRUE
x <- 1          # x now has a value of 1 (overwritten the line above)
x <- c(1, TRUE) # x now contains two values of 1, because a vector always stores the same mode of elements
x
```

```
## [1] 1 1
```

```r
x <- c(1, TRUE, '1') #now all values are characters, because there is a underlying hierarchy. For instance, if there is one element of mode 'character' in your vector, then all elements will be treated as so
x
```

```
## [1] "1"    "TRUE" "1"
```

## Lists  
If you want to store the different modes of elements in one single object, you use lists.  

```r
x <- list(1, TRUE, "1")
x
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] TRUE
## 
## [[3]]
## [1] "1"
```

## Querrying  
You can ask yourself about the nature of an unknown vector - suppose you did not know what x is:  

```r
storage.mode(x)
```

```
## [1] "list"
```

```r
typeof(x)
```

```
## [1] "list"
```

```r
class(x)
```

```
## [1] "list"
```

# Examples from lesson #2 - Writing functions - presented by Diego Barneche  

## Playing with the basics  
When you write your function, you define it based on *arguments*  

```r
f <- function(something) {
    something
}
f(100)
```

```
## [1] 100
```
The function `f()` is what we call the identity function, i.e., the function returns the exact input. In this particular case, the argument `something` took the value 100. You could instead define an object before, and then calling the function on that object, which should do exactly the same thing.  

```r
x  <-  100 #x now is a numeric vector of one element of value 100
f(x)
```

```
## [1] 100
```
It returned exactly the same thing. In this case, `something` took the value of x, which was 100.  

## Downloading the gapminder data
We have to download a .csv file that we will use for the rest of our course. Right-click this [link][id] and save it to some new directory. Let's play with it now. 

```r
data  <-  read.csv('../data/gapminder-FiveYearData.csv', header=TRUE, stringsAsFactors=FALSE)
head(data) #try the function tail() instead, what happened?
```

```
##       country year      pop continent lifeExp gdpPercap
## 1 Afghanistan 1952  8425333      Asia   28.80     779.4
## 2 Afghanistan 1957  9240934      Asia   30.33     820.9
## 3 Afghanistan 1962 10267083      Asia   32.00     853.1
## 4 Afghanistan 1967 11537966      Asia   34.02     836.2
## 5 Afghanistan 1972 13079460      Asia   36.09     740.0
## 6 Afghanistan 1977 14880372      Asia   38.44     786.1
```

```r
#subset the data for year 1982 only
data.1982  <-  data[data$year == 1982, ]

#let's create a function to compute the arithmetic average of a vector
average  <-  function(x) {
    sum(x) / length(x)
}

average(data.1982$gdpPercap)
```

```
## [1] 7519
```

```r
#same as 
sum(data.1982$gdpPercap) / length(data.1982$gdpPercap)
```

```
## [1] 7519
```
Notice that repeating things may be problematic; first because it increases your chances of typos; second, if for some reason you change the name of your columns in `dat`, you will have to manually change all these names, which will be quite annoying.  

# Examples from lesson #5 - Testing functions - presented by Gavin Simpson  
We have seen how important it is to test your functions in R. We have used a very user-friendly packages called `testthat`, where most tests are expectations of a certain result/output:  

## Example of test  

```r
#using function rescale as an example
rescale <- function(x, r.out) {
  if (length(r.out) != 2)
    stop("Expected r.out to be length 2")
  xr <- range(x, na.rm=TRUE)
  p <- (x - min(xr)) / (max(xr) - min(xr))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
}

#some of the possible tests for it
library(testthat)
test_that("Rescale gives expected range", {
  x <- rnorm(20)
  x[4] <- NA
  r.out <- sort(runif(2))
  ## Range is expected:
  expect_that(range(rescale(x, r.out), na.rm=TRUE), equals(r.out))
  ## Rescaling onto same range does not change the data:
  expect_that(rescale(x, range(x, na.rm=TRUE)), equals(x))
  
  ## Rescaling onto a reversed range works
  expect_that(range(rescale(x, rev(r.out)), na.rm=TRUE), equals(r.out))
  ## And the output is what was expected:
  expect_that(rescale(x, rev(r.out)),
              equals(sum(r.out) - rescale(x, r.out)))
})
```

# Examples from lessons #2 and #4 - Writing plot functions and looping - presented by Diego Barneche and Gavin Simpson  

## Making a plot  


```r
col.table  <-  c(Asia='tomato',
                 Europe='chocolate4',
                 Africa='dodgerblue2',
                 Americas='darkgoldenrod1',
                 Oceania='green4')

for (year in unique(data$year))
    my.plot(year, data, col.table)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-101.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-102.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-103.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-104.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-105.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-106.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-107.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-108.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-109.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-1010.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-1011.png) ![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-1012.png) 

[id]: https://raw.github.com/dbarneche/2014-07-14-Dalhousie/gh-pages/data/lessons/10-functions/gapminder-FiveYearData.csv
