\name{bootstrap.test}
\alias{bootstrap.test}
\title{Estimate confidence intervals using bootstrap}
\description{
	Applies bootstrap analyses to each of the packages models as an alternative way to estimate 
95% confidence intervals.
}
\usage{
bootstrap.test(DIST, TIME, GRAD, model, parameters, meserr1=0, meserr2=0, 
   breakpoint = "NULL", N = c(1000), starting=NULL)
}
\arguments{
  \item{DIST}{vector of Euclidean distances for sister pair dataset}
  \item{TIME}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{GRAD}{vector of gradient values (i.e. any continuous variable) for sister pair dataset (see Details)}
  \item{model}{The name of the model to bootstrap.}
  \item{parameters}{a vector containing the maximum likelihood estimates of model parameters. These should be in the order indicated in sisterContinuous. }
  \item{meserr1}{a list of measurement errors that correspond to the first of each species in a sister pair. Order of sister pairs is the same as for DIST.}
  \item{meserr2}{a list of measurement errors that correspond to the second of each species in a sister pair. Order of sister pairs is the same as for DIST.}
  \item{breakpoint}{if using the models BM_2rate or OU_2rate, set this to the maximum likelihood estimate of the breakpoint.}
  \item{N}{The number of bootstrap replicates to perform.}
  \item{starting}{List of starting values. If starting=NULL, the built-in starting parameters are used.}
}
\details{
N bootstrap samples are generated, and are used to generate two estimates of the 95% confidence intervals for each model parameter. The first method reports the 0.025 and 0.0975 quantiles of the bootstrap distribution of parameter values. The second method uses BCa (see Efron and Tibshirani 1993; code adapted from the bcanon function in the bootstrap package from CRAN). BCa should generally utilize 1000 or more bootstrap replicates for reliable results. The bootstrapping should generally work well with simple models, but re-estimating parameters from more complex models with small dataset may behave poorly. A large discrepancy between the mean and median of the bootstrap distribution for a parameter suggests that a number of bootstrap replicates failed to properly converge, and the results should not be used.
}
\value{
A matrix is returned listing the mean, median, variance, and 95% confidence intervals for each of the model parameters.
}
\references{
Efron, B. and Tibshirani, R. (1986). The Bootstrap Method for standard errors, confidence intervals,
and other measures of statistical accuracy. Statistical Science, Vol 1., No. 1, pp 1-35.
}
\author{Jason T. Weir}
\seealso{sisterContinuous}
\examples{
\dontrun{
###EXAMPLE 1

  ###simulate data
  set.seed(seed = 3)
  TIME = runif(n=100, min = 0, max = 10)
  GRAD = runif(n=100, min = 0, max = 60)
  DATA1 <- sim.sisters(TIME = TIME, GRAD=GRAD, parameters = c(2, -0.03), 
     model=c("BM_linear"))

  ###Find the MLE of model parameters
  RESULT <- model.test.sisters(DIST=DATA1[,3], TIME=DATA1[,2], 
     GRAD=DATA1[,1], models=c("BM_linear"))
  intercept <- as.numeric(RESULT[5,1])
  slope <- as.numeric(RESULT[6,1])
  model = c("BM_linear")
  parameters=c(intercept, slope)

  ###Run the bootstrap
  RR <- bootstrap.test(DIST=DATA1[,3], TIME=DATA1[,2],
     GRAD=DATA1[,1], model = "BM_linear", parameters, meserr1=0, 
	 meserr2=0, N = c(100))
  summary <- RR$summary #to show only the summary. 
  bootstraps <- RR$bootstraps #to obtain the bootstraps


###EXAMPLE 2
  ###simulate data
  set.seed(seed = 3)
  TIME = runif(n=100, min = 0, max = 10)
  GRAD = runif(n=100, min = 0, max = 60)
  DATA1 <- sim.sisters(TIME = TIME, GRAD=GRAD, parameters = c(2, -0.03, 1, 
      0.1), model=c("OU_linear"))
  ###Find the MLE of model parameters
  RESULT <- model.test.sisters(DIST=DATA1[,3], TIME=DATA1[,2],    
     GRAD=DATA1[,1], models=c("OU_linear"))
  intercept_beta <- as.numeric(RESULT[5,1])
  slope_beta <- as.numeric(RESULT[7,1])
  intercept_alpha <- as.numeric(RESULT[11,1])
  slope_alpha <- as.numeric(RESULT[12,1])
  parameters=c(intercept_beta, slope_beta, intercept_alpha, slope_alpha)

  ###Run the bootstrap
  RR <- bootstrap.test(DIST=DATA1[,3], TIME=DATA1[,2], 
     GRAD=DATA1[,1], model = "OU_linear", parameters, meserr1=0, meserr2=0, 
     N = c(100))
  summary <- RR$summary #to show only the summary. 
  bootstraps <- RR$bootstraps #to obtain the bootstraps
 }#end dontrun
}
\keyword{bootstrap}

