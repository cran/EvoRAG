\name{expectation.gradient}
\alias{expectation.gradient}
\title{calculate the expected (i.e. mean) Euclidean distances for a gradient model}
\description{
	For models where evolutionary rate (Beta) or constraint (alpha) vary across a gradient, calculate the expected (i.e. mean) Euclidean distances at each point across the gradient after a given amount of time.
}
\usage{
   expectation.gradient(gradient.span = c(0, 10), model = c("BM_null", 
      "BM_linear", "BM_2rate", "BM_linear_breakpoint", "BM_quadratic", 
      "OU_null", "OU_linear_beta", "OU_linear", "OU_2rate", 
      "OU_linear_breakpoint"), parameters, time=c(3), values=TRUE, 
      plot=TRUE, quantile=FALSE)
}
\arguments{
  \item{gradient.span}{The gradient range over which to calculate the expectation}
  \item{model}{A vector listing the model name under which to simulate (e.g. model=c("OU_linear"). Any of the 10 models described in sisterContinuous may be used.}
  \item{parameters}{A vector listing the model parameters under which to simulate. Model parameters must be in the same order as described in sisterContinuous.}
  \item{time}{The time (since species slit from a common ancestor) at which to calculate the expectation.}
  \item{values}{TRUE (null) returns the values in matrix form.}
  \item{plot}{Plot the expected (solid line) Euclidean distance and optionally quantiles for a given Beta.}  
  \item{quantile}{Calculate (and optionally plot) the expected quantiles (0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.99) for Euclidean distances under a given Beta.}
}
\details{
This function calculates the expectation (i.e. mean value under a half normal distribution) for Eculidean distance across a gradient where either evolutionary rate (Beta) and/or constraint (Alpha) vary as a function of the gradient. The user must specify the time at which the expectation will be calculated. The user can also have the quantiles (0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.99) calculated across the gradient.
}
\value{
Returns a matrix with 1 columns corresponding to L (the gradient value) and the expectation, and an additional 11 columns with quantiles if qualtiles=TRUE. If plot=TRUE, the expectation (solid line) and optionally the quantiles (dashed lines) are plotted.
}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution 66, 2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B 278, 1713-1720.
}
\author{Jason T. Weir}
\seealso{expectation.time, sisterContinuous}
\examples{
\dontrun{
##Example 1
  ###Expectation after 3 time units under BM_linear with Beta at 0 = 7, and 
  ###a slope of Beta = -0.1.
  expectation.gradient(gradient.span = c(0, 60), model = c("BM_linear"), 
     values = FALSE, parameters=c(7,-0.1), time=c(3),quantile=TRUE)


##Example 2
  ###Expectation after 3 time units under OU_linear with Beta constant 
  ###across the gradient and alpha declining.
  expectation.gradient(gradient.span = c(0, 60), model = c("OU_linear"), 
     values = FALSE, parameters=c(0.1, 0, 7, -0.1), time=c(3),quantile=TRUE)


##Example 3
  ###Expectation after 3 time units under OU_linear with Beta declining across 
  ###the gradient and alpha remaining constant.
  expectation.gradient(gradient.span = c(0, 60), model = c("OU_linear"), 
     values = FALSE, parameters=c(7, -0.1, 10, 0), time=c(3),quantile=TRUE)


##Example 4
  ###Expectation after 3 time units under BM_2rate with Beta 5 times higher 
  ###after a breakpoint at L = 20.
  expectation.gradient(gradient.span = c(0, 60), model = c("BM_2rate"), 
     values = FALSE, parameters=c(1, 20,5), time=c(3),quantile=FALSE)

##Example 5
  ###Expectation after 3 time units under BM_linear_breakpoint with the slope
  ###of Beta increasing 5 times higher after a breakpoint at L = 20.
  expectation.gradient(gradient.span = c(0, 60), model = c("BM_linear_breakpoint"), 
     values = FALSE, parameters=c(0.1, 0.001, 20,0.1), time=c(3),quantile=TRUE)


##Example 6
  ###Expectation after 3 time units under BM_quadratic in which beta increases 
  ###initially across the gradient and then declines. Under the quadratic, 
  ###Beta_a (the third parameter) > 0 parabola curves upward, Beta_a < 0 downward.
  expectation.gradient(gradient.span = c(0, 60), model = c("BM_quadratic"), 
     values = FALSE, parameters=c(10, 15, -0.2), time=c(3),quantile=TRUE)
}
}
\keyword{Expectation}