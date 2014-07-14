\name{TypeI.error}
\alias{TypeI.error}
\title{performs a simulation based analysis of type I error}
\description{
	performs a simulation based analysis of type I error
}
\usage{
   TypeI.error(TIME, GRAD, beta, alpha=0, null.model, REP=1, N, 
      write.file = "FALSE", wd = "")
}
\arguments{
  \item{TIME}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{GRAD}{vector of gradient values (i.e. any continuous variable) for sister pair dataset}
  \item{beta}{Evolutionary rate, beta, to simulate under}
  \item{alpha}{value of evolutionary constraint, alpha, when null.model = "OU_null". Should be set to 0 when using "BM_null"}
  \item{null.model}{Either "BM_null" or "OU_null"}
  \item{REP}{How many replicated datasets of TIME and GRAD to use. Default = 1. Example: REP=3 generates a dataset with each element in TIME and GRAD repeated 3 times. This option will be used primarily for calculating statistical power as a function of increasing number of sister pairs}
  \item{N}{The number of simulations to perform}
  \item{write.file}{If true, writes output to several files}
  \item{wd}{directory to write files to if other than the current working directory. (Windows example, "D:/SIMS/"}
}
\details{
Performs an analysis of type I error (e.g. the probability of rejecting a true null hypothesis) when the the model with the lowest AICc is chosen as the best fit. 
The null hypothesis here tested is that rates of evolution do not vary as a function of gradient (e.g. "BM_null", and "OU_null"). 
The alternative, is rates do vary as a linear function of a gradient (e.g. "BM_linear", "OU_linear_beta", "OU_linear").  
Currently, only "BM_linear", "OU_linear_beta", "OU_linear" are included in the candidate set of gradient models.
}
\value{
Returns a list with the following elements:
simulation_parameters	The parameters and model under which simulation occurred
TypeI_errors	Returns the Type I error and the appropriate threshold delta AICc value necessary to reject the null hypothesis while maintaining a type I error of 0.05.
model_parameters	Also returns the median, 0 percentile and 95 percentile of the distribution of parameter values estimated across the simulations for each model. 
These can be used to check for bias in the null models.
}
\author{Jason T. Weir}
\seealso{power.test}
\examples{
\dontrun{

 ###simulate data
  set.seed(seed = 3)
  TIME = runif(n=300, min = 0, max = 10)
  GRAD = runif(n=300, min = 0, max = 60)
  DATA1 <- sim.sisters(TIME = TIME, GRAD=GRAD, parameters = c(2), model=c("BM_null"))

  ###run typeI error test. This should be run for a minimum of N=1000 simulations
  TypeI.error(TIME, GRAD, beta=2, null.model="BM_null", REP=1, N=10, 
     write.file = "FALSE", wd = "")
 }#end dontrun
}
\keyword{Simulation}
\keyword{delta AICc}
\keyword{Type I error}