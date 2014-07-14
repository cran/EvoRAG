\name{sim.sisters}
\alias{sim.sisters}
\title{simulate Euclidean distances for sister pair data under 10 evolutionary models}
\description{
	simulate Euclidean distances for sister pair data under 10 evolutionary models
}
\usage{
   sim.sisters(TIME, GRAD, GRAD2 = "NULL", parameters, model, MULT=1)
}
\arguments{
  \item{TIME}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{GRAD}{vector of gradient values (i.e. any continuous variable) for sister pair dataset}
  \item{GRAD2}{this is a vector of gradient values for a second continuous variable to be used for models that test for the effect of two gradients on rates of evolution.}
  \item{parameters}{A vector listing the model parameters under which to simulate. Model parameters must be in the same order as described in sisterContinuous.}
  \item{model}{A vector listing the model name under which to simulate (e.g. model=c("OU_linear"). Any of the 10 models described in sisterContinuous may be used.}
  \item{MULT}{How many replicated simulations per set of GRAD and TIME. Default = 1}
}
\details{
This function is called by bootstrap.sister, but can also be used for customized routines to explore model power and to visualize what data is expected to look like under different evolutionary rates.
}
\value{
Returns a matrix with 3 columns corresponding to GRAD, TIME and simulated DIST.
}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution 66, 2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B 278, 1713-1720.
}
\author{Jason T. Weir}
\seealso{sisterContinuous, bootstrap.sister}
\examples{
##Example 1
  ###This example graphically compares the distributions of simulated Euclidean 
  ###distances under BM_null when Beta (evolutionary rate) is 0.1 and 0.2
  TIME = c(0:100) * 0.1
  GRAD = (0:100)*0 #BM_null does not require GRAD, thus simply make a dummy set of GRAD
  DATA1 <- sim.sisters(TIME=TIME, GRAD=GRAD, parameters = c(0.2), 
     model=c("BM_null"), MULT=10)
  DATA2 <- sim.sisters(TIME=TIME, GRAD=GRAD, parameters = c(0.1), 
     model=c("BM_null"), MULT=10)
  plot(DATA1[,3] ~ DATA1[,2], xlab="Genetic distance of sister pair", 
     ylab = "Euclidean distance", cex=0.5)
  expectation1 <- expectation.time(Beta = 0.2, Alpha="NULL", time.span=c(0, 10), 
     values="TRUE", plot=FALSE, quantile=FALSE)
  lines(expectation1[,2] ~ expectation1[,1], lwd=2)
  points(DATA2[,3] ~ DATA2[,2], col="red",  cex=0.5)
  expectation2 <- expectation.time(Beta = 0.1, Alpha="NULL", time.span=c(0, 10), 
      values="TRUE", plot=FALSE, quantile=FALSE)
  lines(expectation2[,2] ~ expectation2[,1],col="red", lwd=2)
  ###Notice that doubling Beta still results in largely overlapping distributions 
  ###of DIST at any given TIME, and the expectation (shown by lines) is not doubled. 

##Example 2
  ###graphically compare data simulated with the same evolutionary rate (Beta) 
  ###under BM_null versus OU_null to see the effect of constraint (Alpha)
  TIME = c(0:100) * 0.1
  GRAD = (0:100)*0 #GRAD is not required by these models, so a dummy set of GRAD are provided
  DATA1 <- sim.sisters(TIME=TIME, GRAD=GRAD, parameters = c(0.2), 
     model=c("BM_null"), MULT=10)
  DATA2 <- sim.sisters(TIME=TIME, GRAD=GRAD, parameters = c(0.2, 1), 
     model=c("OU_null"), MULT=10)
  plot(DATA1[,3] ~ DATA1[,2], xlab="Genetic distance of sister pair", 
     ylab = "Euclidean distance", cex=0.5)
  expectation1 <- expectation.time(Beta = 0.2, Alpha="NULL", time.span=c(0, 10), 
     values="TRUE", plot=FALSE, quantile=FALSE)
  lines(expectation1[,2] ~ expectation1[,1], lwd=2)
  points(DATA2[,3] ~ DATA2[,2], col="red", cex=0.5)
  expectation2 <- expectation.time(Beta = 0.2, Alpha=1, time.span=c(0, 10), 
     values="TRUE", plot=FALSE, quantile=FALSE)
  lines(expectation2[,2] ~ expectation2[,1],col="red", lwd=2)
  ###Notice that DIST increases in a similar fashion under BM and OU until about 
  ###TIME = 0.5 after which point the strong constraint in OU becomesevident.
}
\keyword{Brownian Motion}
\keyword{Ornstein Uhlenbeck}
\keyword{Simulation}