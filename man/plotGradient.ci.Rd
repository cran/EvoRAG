\name{plotGradient.ci}
\alias{plotGradient.ci}
\title{Plot evolutionary rates and their confidence regions across a gradient}
\description{
	Takes the output from bootstrap.test for the BM_linear model and plots how evolutionary rates and their confidence regions change across the gradient. 
}
\usage{
plotGradient.ci(bootstraps1, bootstraps2=c("FALSE"), Lmin, Lmax, ylim, 
   MLE = FALSE, MLE1, MLE2, xlab="Gradient") 
}
\arguments{
  \item{bootstraps1}{the raw bootstraps output by bootstrap.test}
  \item{bootstraps2}{same as bootstraps1, but for an optional second dataset.}
  \item{Lmin}{minimum gradient value for graph}
  \item{Lmax}{maximum gradient value for graph}
  \item{ylim}{maximum y-axis value}
  \item{MLE}{Logical. If MLE=TRUE, then the maximum likelihood values are  plotted. If MLE=FALSE, then the mean bootstrap values are plotted.}
  \item{MLE1}{A list of the maximum likelihood parameter values for dataset 1}
  \item{MLE2}{A list of the maximum likelihood parameter values for dataset 2, if a second dataset provided}
  \item{xlab}{A title for the x-axis.}
 }
\details{
Currently, only works for the BM_linear model.
}
\value{
A plot of the bootstrap 95% confidence region and either the mean bootstrap value or the MLE of the model parameters.
}
\author{Jason T. Weir}
\seealso{bootstrap.test}
\examples{
\dontrun{
  ###simulate data
  set.seed(seed = 3)
  TIME = runif(n=200, min = 0, max = 10)
  GRAD = runif(n=200, min = 0, max = 60)
  DATA1 <- sim.sisters(GRAD, TIME, parameters = c(0.1, 0.065), model=c("BM_linear"))

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
  
  ###Plot data
  plotGradient.ci(bootstraps1=bootstraps, 
     bootstraps2= c("FALSE"), Lmin=0, Lmax=60, ylim=c(0,10), 
     MLE=TRUE, MLE1=c(0.1, 0.065), MLE2=c(0,0), xlab="Latitude")
  }#end dontrun
}  
\keyword{confidence interval, plot}
