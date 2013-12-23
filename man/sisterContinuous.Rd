\name{sisterContinuous}
\alias{sisterContinuous}
\title{likelihood functions for continuous trait evolutionary models}
\description{
	Returns the negative log-likelihood of the data under an evolutionary model. Evolutionary models include   
}
\usage{
sisterContinuous(parameters, model = c("BM_null", "BM_2rate","BM_linear", 
   "BM_linear_breakpoint", "BM_quadratic", "OU_null", "OU_2rate", 
   "OU_linear", "OU_linear_beta", "OU_linear_breakpoint"), 
   breakpoint = "NULL", E, T, L)
}
\arguments{
  \item{parameters}{a vector of parameter values to be tested.}
  \item{model}{evolutionary model to calculate log-likelihood (see Details). }
  \item{breakpoint}{breakpoint (along L) to use for the BL_2rate and OU_2rate models. }
  \item{E}{vector of Euclidean distances for sister pair dataset.}
  \item{T}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{L}{vector of gradient values (i.e. any continuous variable) for sister pair dataset (see Details).}
}

\details{
This function calculates the negative log-likelihood for continuous trait data for a series of sister pairs (e.g. sister species) under a variety of evolutionary models that allow rates of evolution (Beta) or evolutionary constraint (Alpha) to either remain constant or to vary as a function of another continuous variable. The second continuous variable could be elevation, latitude, body mass or any other continuous variable of interest, over which rates of trait evolution might vary. This function can be used in combination with an optimizer such as optim or nlm to find the maximum likelihood values for model parameters. These optimizers often perform poorly on more complex models, and instead we suggest that model.test.sisters be used. 

Evolutionary models implemented are as follows.
\itemize{
	\item{\bold{BM_null and OU_null} }{Applies a simple Brownian motion (BM; 1 parameter) and Ornstein Uhlenbeck (OU; 2 parameters) model in which model parameters do not vary as a function of L. Model parameters: for BM_null a single parameter describing the evolutionary rate, parameters = c(Beta); for OU_null an additional parameter describing the evolutionary constraint, parameters = c(Beta, Alpha)}
	\item{\bold{BM_2rate and OU_2rate} }{Allows model parameters for BM (3 parameters)  and OU (5 parameters) to differ before and after a breakpoint along the gradient L. Model parameters: for BM_2rate parameters = c(Beta1, Beta2) where Beta1 and Beta2 are the rates before and after the breakpoint and breakpoint is a third parameter set using the breakpoint argument; for OU_2rate parameters = c(Beta1, breakpoint, Beta2, Alpha1, Alpha2) where Alpha1 and Alpha2 are the constraints before and after the breakpoint.}
	\item{\bold{BM_linear and OU_linear} }{Allows model parameters for BM (2 parameters) and OU (4 parameters) to vary as a linear function of L. Model parameters: for BM_linear parameters = c(Beta_C, Beta_slope) which describe the intercept and slope of Beta; for OU_linear parameters = c(Beta_C, Beta_slope, Alpha_C, Alpha_slope) which describe the intercept and slope of Beta and Alpha}
	\item{\bold{OU_linear_beta} }{The same as OU_linear but only Beta varies linearly with L, while Alpha remains constant across L. Model parameters = c(Beta_C, Beta_slope, Alpha) }
	\item{\bold{BM_linear_breakpoint and OU_linear_breakpoint} }{A breakpoint model whereby model parameters before and after a breakpoint vary by different linear functions of L, with both linear functions intersecting at the breakpoint. Model parameters: for BM_linear_breakpoint parameters = c(Beta_C1, Beta_slope1, breakpoint, Beta_Slope2) which describe the intercept and slope of Beta prior to the breakpoint, and the slope of Beta following the breakpoint; for OU_linear_breakpoint parameters = c(Beta_C1, Beta_slope1, breakpoint, Beta_Slope2, Alpha_C1, Alpha_slope1, and Alpha_slope2) which describe the intercept and slope of Alpha prior to the breakpoint, and the slope of Alpha following the breakpoint.}
	\item{\bold{BM_quadratic} }{Model parameters for BM (3 parameters) change as a quadratic function of L. Model parameters = c(Beta_c, Beta_b, Beta_a) where Beta = Beta_c + Beta_b * L + Beta_a * L^2.}
}
}

\value{returns the negative log-Likelihood}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution 66, 2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B 278, 1713-1720.
}
\author{Jason T. Weir}
\seealso{model.test.sisters}
\examples{

data(bird.pitch)
attach(bird.pitch)

###The following example uses optim to find the maximum likelihood estimate 
###on data from Weir et al 2012.

#STEP 1: Correct Euclidean distances for sampling and measurement bias
E_cor <- MScorrection(nA=bird.pitch$number_individuals_Species1,
   nB=bird.pitch$number_individuals_Species2, 
   VarA=bird.pitch$Variance_PC1and2_Species1, 
   VarB=bird.pitch$Variance_PC1and2_Species2, 
   E_actual=bird.pitch$Uncorrected_Euclidean_Distance)

#STEP 2: Extract and test only forest species
E <- subset(E_cor, subset = (bird.pitch$Habitat == "forest"))
T <- subset(bird.pitch$T, subset = (bird.pitch$Habitat == "forest"))
L <- subset(bird.pitch$L, 
   subset = (bird.pitch$Habitat == "forest"))

#STEP 4: fit the model using optim
res <- optim(par = c(0.1,0.001), fn=sisterContinuous, model = c("BM_linear"),
     E=E, T=T, L=L, method="L-BFGS-B",lower=c(0,-5),upper=c(Inf,5))


    
}
\keyword{Brownian Motion}
\keyword{Ornstein Uhlenbeck}
