\name{expectation.time}
\alias{expectation.time}
\title{calculate the expected (i.e. mean) Euclidean distances through time given a rate of evolution, Beta.}
\description{
	calculate the expected (i.e. mean) Euclidean distances through time given a rate of evolution, Beta.
}
\usage{
   expectation.time(Beta, Alpha="NULL", time.span=c(0, 10), 
      values=TRUE, plot=TRUE, quantile=FALSE)
}
\arguments{
  \item{Beta}{Evolutionary rate parameter to plot}
  \item{Alpha}{Evolutionary constrain parameter tom plot (for OU model only). Leave as "NULL" to implement the BM model}
  \item{time.span}{A vector of length 1 if the expectation is calcuated for a single time; length 2 if to be calculated over a range from 0 to an upper value chosen by the user; or length > 0, where the user supplies 3 or more times over which to calculate the Expectation. }
  \item{values}{TRUE (null) returns the values in matrix form.}
  \item{plot}{Plot the expected (solid line) Euclidean distance and optionally quantiles for a given Beta.}  
  \item{quantile}{Calculate (and optionally plot) the expected quantiles (0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.99) for Euclidean distances under a given Beta.}
}
\details{
This function calculates the expectation (i.e. mean value under a half normal distribution) for Eculidean distance across a time range and optionally the quantiles (0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.99).
}
\value{
Returns a matrix with 3 columns corresponding to L, T and simulated E, and an additional 11 columns with quantiles if qualtiles=TRUE. If plot=TRUE, the expectation (solid line) and optionally the quantiles (dashed lines) are plotted.
}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution 66, 2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B 278, 1713-1720.
}
\author{Jason T. Weir}
\seealso{expectation.gradient, sisterContinuous, bootstrap.sister}
\examples{
##Example 1
  ###Compare data simulated under BM_null to the expectation and quantiles
  TIME = c(0:100) * 0.1
  GRAD = (0:100)*0 #BM_null does not require GRAD, thus simply make a dummy set of GRAD
  DATA1 <- sim.sisters(TIME=TIME, GRAD=GRAD, parameters = c(0.1), 
     model=c("BM_null"), MULT=10)
  expectation.time(Beta=0.1, Alpha="NULL", time.span=c(0, 10), values=FALSE, 
     plot=TRUE, quantile=TRUE)
  points(DATA1[,3] ~ DATA1[,2], col="black", cex=0.4)

##Example 2
  ###Compare data simulated under OU_null to the expectation and quantiles
  TIME = c(0:100) * 0.1
  GRAD = (0:100)*0 #GRAD is not required by these models, so a dummy set of GRAD are provided
  DATA1 <- sim.sisters(TIME=TIME, GRAD=GRAD, parameters = c(0.1, 1), 
     model=c("OU_null"), MULT=10)
  expectation.time(Beta=0.1, Alpha=1, time.span=c(0, 10), values=FALSE, 
     plot=TRUE, quantile=TRUE)
  points(DATA1[,3] ~ DATA1[,2], col="black", cex=0.4)
}
\keyword{Expectation}