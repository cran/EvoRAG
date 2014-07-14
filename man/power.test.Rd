\name{power.test}
\alias{power.test}
\title{performs a simulation based analysis of statistical power}
\description{
	performs a simulation based analysis of statistical power
}
\usage{
   power.test(TIME, GRAD, parameters, test.model, threshold_deltaAICc, 
      REP=1, N, write = "FALSE", wd = "")
}
\arguments{
  \item{TIME}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{GRAD}{vector of gradient values (i.e. any continuous variable) for sister pair dataset}
  \item{parameters}{A vector listing the model parameters under which to simulate. Model parameters must be in the same order as described in sisterContinuous.}
  \item{test.model}{Any one of the following models are currently supported ("BM_linear", "OU_linear_beta", "OU_linear")}
  \item{threshold_deltaAICc}{A single threshold deltaAICc or a list of such values}
  \item{REP}{How many replicated datasets of TIME and GRAD to use. Default = 1. Example: REP=3 generates a dataset with each element in TIME and GRAD repeated 3 times. This option will be used primarily for calculating statistical power as a function of increasing number of sister pairs}
  \item{N}{The number of simulations to perform}
  \item{write}{If true, writes output to several files}
  \item{wd}{directory to write files to if other than the current working directory. (Windows example, "D:/SIMS/"}
}
\details{
Performs an analysis of statistical power (e.g. the probability of supporting a true alternative hypothesis) for a given dataset under a given model and set of model parameters. 
The threshold_deltaAICc should be set at a level that will maintain a type I error (probability of rejecting a true null model) of 0.05. Appropriate threshold_deltaAICc values can 
be determined using the function TypeI.error. The null hypothesis here tested is that rates of evolution do not vary as a function of gradient (e.g. "BM_null", and "OU_null"). 
The alternative, is rates do vary as a linear function of a gradient (e.g. "BM_linear", "OU_linear_beta", "OU_linear"). Several hundred or more replicates 
should be performed. Currently, only "BM_linear", "OU_linear_beta", "OU_linear" are included in the candidate set of gradient models.

}
\value{
Returns a list with the following elements:
test.model	The model for which power was calculated
parameters	The parameters under which power was calculated
N_sisters	The number of sister pairs in the dataset
N_sims	The number of simulations performed
power_test_hypothesis	Statistical power calculated for the alternative hypothesis that rates of evolution vary as a linear function of a gradient. Power is returned for each 
threshold value in threshold_deltaAIC. Where appropriate, power to reject BM_null and OU_null is returned for three comparisons: 1) BMlinear_and_OUlinear_beta_vs_2null: power when simulating data either under 
BM_linear or OU_linear_beta, but when the OU_linear model is not included in the analysis; 2) BMlinear_and_OUlinear_vs_2null: power when OU_linear_beta is not included; 3) 3gradient_vs_2null: power when all three gradient models are included.

power_test_hypothesis	The probability of the test model correctly rejecting each of the other null and gradient models on an individual basis. 

}
\author{Jason T. Weir}
\seealso{TypeI.error}
\examples{
\dontrun{

 ###simulate data
  set.seed(seed = 3)
  TIME = runif(n=300, min = 0, max = 10)
  GRAD = runif(n=300, min = 0, max = 60)
  DATA1 <- sim.sisters(TIME = TIME, GRAD=GRAD, parameters = c(2, -0.03), 
     model=c("BM_linear"))

  ###run power.test
  model = c("BM_linear")
  power.test(TIME=TIME, GRAD=GRAD, parameters = c(2, -0.03), test.model="BM_linear", 
     threshold_deltaAICc = c((1:20)*0.5), REP=1, N=2, write = "FALSE", wd = "")
 }#end dontrun
}
\keyword{Simulation}
\keyword{Statistical power}
\keyword{Type II error}


 