## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

required <- c("exdex", "revdbayes")

if (!all(unlist(lapply(required, function(pkg) requireNamespace(pkg, quietly = TRUE)))))
  knitr::opts_chunk$set(eval = FALSE)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

## ----cheeseboro---------------------------------------------------------------
library(lite)
cdata <- exdex::cheeseboro
# Each column of the matrix cdata corresponds to data from a different year
# blite() sets cluster automatically to correspond to column (year)
cpost <- blite(cdata, u = 45, k = 3, ny = 31 * 24, n = 10000)

## ----vertical, fig.width = 7, fig.height = 5, message = FALSE-----------------
summary(cpost)
plot(cpost)

## ----predinterval-------------------------------------------------------------
# Interval estimation
predict(cpost, hpd = TRUE)$short

## ----preddensity, fig.width = 7, fig.height = 5, message = FALSE--------------
# Density function
plot(predict(cpost, type = "d", n_years = c(100, 1000)))

