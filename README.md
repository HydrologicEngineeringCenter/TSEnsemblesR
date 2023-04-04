
# TSEnsemblesR

<!-- badges: start -->
[![Codecov test coverage](https://codecov.io/gh/HydrologicengineeringCenter/TSEnsemblesR/branch/main/graph/badge.svg)](https://app.codecov.io/gh/HydrologicengineeringCenter/TSEnsemblesR?branch=main)
<!-- badges: end -->

TSEnsemblesR is a wrapper for the ![TSEnsembles Java library](https://github.com/HydrologicEngineeringCenter/FIRO_TSEnsembles) using the `rJava` package to read and write ensembles of hydrologic data.

## Installation

You can install the development version of TSEnsemblesR using the `remotes` package:

``` r
remotes::install_github("HydrologicEngineeringCenter\TSEnsemblesR")
```

## Example

This example needs to be updated.
``` r
library(TSEnsemblesR)
## basic example code
ensembleFile <- openTSEnsembles(file, method="SQLite")
readEnsembles(file, location, parameter)

[... do something to make ensembles ...]

writeEnsembles(file, location, parameter, forecastMatrix)
```

