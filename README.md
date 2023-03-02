
# TSEnsemblesR

<!-- badges: start -->
<!-- badges: end -->

TSEnsemblesR is a wrapper for the TSEnsembles Java library using `{rJava}` to read and write ensembles.

## Installation

You can install the development version of TSEnsemblesR like so:

``` r
remotes::install_github("eheisman\TSEnsemblesR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(TSEnsemblesR)
## basic example code
ensembleFile <- openTSEnsembles(file, method="SQLite")
readEnsembles(file, location, parameter)

[... do something to make ensembles ...]

writeEnsembles(file, location, parameter, forecastMatrix)
```

