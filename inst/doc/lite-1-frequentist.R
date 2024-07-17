## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

required <- c("exdex")

if (!all(unlist(lapply(required, function(pkg) requireNamespace(pkg, quietly = TRUE)))))
  knitr::opts_chunk$set(eval = FALSE)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(comment = "#>", collapse = TRUE)

## ----cheesy, echo = FALSE, fig.width = 7, fig.height = 5----------------------
oldpar <- par(mar = c(4, 4, 1, 1))
cmat <- exdex::cheeseboro
NAmat <- matrix(NA, ncol = 10, nrow = 250)
cmat <- rbind(cmat, NAmat)
cvec <- c(cmat)
plot(cvec, xlab = "year", ylab = "hourly wind gusts, mph", axes = FALSE,
     ylim = c(0, max(cvec, na.rm = TRUE)), type = "l")
axis(1, at = c(-1000, seq(from = 372, by = 744 + 250, length = 10), 100000), 
     labels = c(NA, 2000:2009, NA))
axis(2)
par(oldpar)

## ----cheeseboro---------------------------------------------------------------
library(lite)
cdata <- exdex::cheeseboro
# Each column of the matrix cdata corresponds to data from a different year
# flite() sets cluster automatically to correspond to column (year)
cfit <- flite(cdata, u = 45, k = 3)
summary(cfit)
summary(cfit, adjust = FALSE)

## ----vertical, fig.width = 7, fig.height = 5, message = FALSE-----------------
plot(cfit)

## ----spectral, fig.width = 7, fig.height = 5, message = FALSE-----------------
plot(cfit, which = "gp", adj_type = "spectral")

## ----returnlevels, fig.width = 7, fig.height = 5------------------------------
rl <- returnLevel(cfit, m = 100, level = 0.95, ny = 31 * 24)
summary(rl)
rl
plot(rl)

