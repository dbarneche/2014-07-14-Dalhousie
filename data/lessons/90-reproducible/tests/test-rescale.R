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

test_that("Bad inputs for r.out", {
  x <- rnorm(20)
  expect_that(rescale(x, numeric(0)),  throws_error())
  expect_that(rescale(x, 1),           throws_error())
  expect_that(rescale(x, 1:3),         throws_error())
  expect_that(rescale(x, c("a", "b")), throws_error())
  
  expect_that(rescale(x, c(1, NA)),
              equals(rep(NA_real_, length(x))))
})
