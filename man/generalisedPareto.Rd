% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generalisedPareto.R
\name{generalisedPareto}
\alias{generalisedPareto}
\alias{fitGP}
\alias{coef.GP}
\alias{vcov.GP}
\alias{nobs.GP}
\alias{logLik.GP}
\alias{gpObsInfo}
\title{Frequentist inference for the generalised Pareto distribution}
\usage{
fitGP(data, u)

\method{coef}{GP}(object, ...)

\method{vcov}{GP}(object, ...)

\method{nobs}{GP}(object, ...)

\method{logLik}{GP}(object, ...)

gpObsInfo(pars, excesses, eps = 1e-05, m = 3)
}
\arguments{
\item{data}{A numeric vector of raw data.  Missing values are removed using
\code{\link[stats:na.fail]{na.omit}}.}

\item{u}{A numeric scalar.  The extremal value threshold.}

\item{object}{A fitted model object returned from \code{fitGP()}.}

\item{...}{Further arguments to be passed to the functions in the
sandwich package \code{\link[sandwich]{meat}} (if \code{cluster = NULL}),
or \code{\link[sandwich:vcovCL]{meatCL}} (if \code{cluster} is not
\code{NULL}).}

\item{pars}{A numeric parameter vector of length 2 containing the values of
the generalised Pareto scale and shape parameters.}

\item{excesses}{A numeric vector of threshold excesses, that is, amounts
by which exceedances of \code{u} exceed \code{u}.}

\item{eps, m}{These control the estimation of the observed
information in \code{gpObsInfo} when the GP shape parameter \eqn{\xi} is
very close to zero.  In these cases, direct calculation is unreliable.
\code{eps} is a (small, positive) numeric scalar.  If the absolute value
of the input value of \eqn{\xi}, that is, \code{pars[2]}, is smaller than
\code{eps} then we approximate the \code{[2, 2]} element using a Taylor
series expansion in \eqn{\xi}, evaluated up to and including the
\code{m}th term.}
}
\value{
\code{fitGP} returns an object of class \code{"GP"}, a list
with components: \code{maxLogLik}, \code{threshold}, \code{mle},
\code{vcov}, \code{exceedances}, \code{nexc},
where \code{exceedances} is a vector containing the values that exceed the
threshold \code{threshold} and \code{nexc} is the length of this vector.

  \code{coef.GP}: a numeric vector of length 2 with names
    \code{c("sigma[u]", "xi")}.  The MLEs of the GP parameters
    \eqn{\sigma_u} and \eqn{\xi}.

  \code{vcov.GP}: a \eqn{2 \times 2}{2 x 2} matrix with row and
    column names \code{c("sigma[u]", "xi")}.  The estimated
    variance-covariance matrix for the model parameters. No adjustment for
    cluster dependence has been made.

  \code{nobs.GP}: a numeric vector of length 1.  The number of
    observations used to estimate (\eqn{\sigma_u}, \eqn{\xi}).

  \code{logLik.GP}: an object of class \code{"logLik"}: a numeric scalar
    with value equal to the maximised log-likelihood. The returned object
    also has attributes \code{nobs}, the numbers of observations used in
    each of these model fits, and \code{"df"} (degrees of freedom), which is
    equal to the number of total number of parameters estimated (2).

\code{gpObsInfo} returns a 2 by 2 matrix with row and columns names
\code{c("sigma[u]", "xi")}.
}
\description{
Functions involved in making inferences about the scale and shape
parameters of a generalised Pareto distribution using maximum likelihood
estimation.
}
\details{
\code{fitGP}: fit a generalised Pareto distribution using maximum likelihood
  estimation, using an \strong{independence} log-likelihood formed by
  summing contributions from individual observations. No adjustment for
  cluster dependence has been made in estimating the variance-covariance
  matrix stored as component in \code{vcov} in the returned object. This
  function calls \code{\link[revdbayes]{grimshaw_gp_mle}}.

\code{coef}, \code{vcov}, \code{nobs} and \code{logLik} methods are
provided for objects of class \code{"GP"} returned from \code{fitGP}.

\code{gpObsInfo}: calculates the observed information matrix for a random
sample \code{excesses} from the generalized Pareto distribution, that is,
the negated Hessian matrix of the generalized Pareto independence
log-likelihood, evaluated at \code{pars}.
}
\examples{
# Set up data and set a threshold
cdata <- c(exdex::cheeseboro)

# Fit a generalised Pareto distribution
fit <- fitGP(cdata, 45)

# Calculate the log-likelihood at the MLE
res <- logLikVector(fit)

# The logLik method sums the individual log-likelihood contributions.
logLik(res)

# nobs, coef, vcov, logLik methods for objects returned from fitGP()
nobs(fit)
coef(fit)
vcov(fit)
logLik(fit)
}
