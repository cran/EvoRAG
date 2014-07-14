\name{parameter.reestimation}
\alias{parameter.reestimation}
\title{uses simulation to determine robustness of parameter estimates under a model}
\description{
	uses simulation to determine robustness of parameter estimates under a model
}
\usage{
   parameter.reestimation(GRAD, TIME, model, PARAMETERS, N, REP = 1)
}
\arguments{
  \item{GRAD}{vector of gradient values (i.e. any continuous variable) for sister pair dataset}
  \item{TIME}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{model}{any model implemented in EvoRAG}
  \item{PARAMETERS}{A vector listing the model parameters under which to simulate. Model parameters must be in the same order as described in sisterContinuous.}
  \item{REP}{How many replicated datasets of TIME and GRAD to use. Default = 1. Example: REP=3 generates a dataset with each element in TIME and GRAD repeated 3 times. This option will be used primarily for calculating statistical power as a function of increasing number of sister pairs}
  \item{N}{The number of simulations to perform}
}
\details{
Simulates data under a model, and re-estimates model parameters using the same model. A model performs well if the parameters it is simulated under are similar to those it re-estimates.
}
\value{
Returns a matrix showing the mean, median, range, several percentiles and the standard error for each model parameter.
}
\author{Jason T. Weir}
\examples{
\dontrun{
  ###simulate data
  set.seed(seed = 3)
  TIME = runif(n=300, min = 0, max = 10)
  GRAD = runif(n=300, min = 0, max = 60)
  DATA1 <- sim.sisters(TIME = TIME, GRAD=GRAD, parameters = c(2, -0.03), 
     model=c("BM_linear"))

  ###run parameter.reestimation
  model = c("BM_linear")
  parameter.reestimation(GRAD, TIME, model=model, PARAMETERS=c(2, -0.03), 
     N=100, REP = 1)
 }#end dontrun
}
\keyword{Simulation}
\keyword{parameter re-estimation}

