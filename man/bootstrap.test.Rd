\name{bootstrap.test}
\alias{bootstrap.test}
\title{Estimate confidence intervals using bootstrap}
\description{
	Applies bootstrap analyses to each of the packages models as an alternative way to estimate 
95% cofidence intervals.
}
\usage{
bootstrap.test(E, T, L, model, parameters, breakpoint = "NULL", 
   N = c(1000), method = "FAST", starting=list("NULL"))

}
\arguments{
  \item{E}{vector of Euclidean distances for sister pair dataset}
  \item{T}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{L}{vector of gradient values (i.e. any continuous variable) for sister pair dataset (see Details)}
  \item{model}{The name of the model to bootstrap.}
  \item{parameters}{a vector containing the maximum likelihood estimates of model parameters. These should be in the order indicated in sisterContinuous. }
  \item{breakpoint}{if using the models BM_2rate or OU_2rate, set this to the maximum likelihood estimate of the breakpoint.}
  \item{N}{The number of boostrap replicates to perform.}
  \item{method}{Use "FAST" for a faster (but for highly complex models, also less reliable) optimization routine. "SLOW" uses model.test.sister for optimization, and will generally provide more reliable results, but will take much longer to run.}
  \item{starting}{List of starting values for the model implemented when using method = "SLOW". If starting=list("NULL"), the built-in starting parameters are used.}
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
  T = runif(n=100, min = 0, max = 10)
  L = runif(n=100, min = 0, max = 60)
  DATA1 <- sim.sisters(L, T, parameters = c(2, -0.03), model=c("BM_linear"))

  ###Find the MLE of model parameters
  RESULT <- model.test.sisters(E=DATA1[,3], T=DATA1[,2], 
     L=DATA1[,1], models=c("BM_linear"))
  intercept <- as.numeric(RESULT[1,6])
  slope <- as.numeric(RESULT[1,7])
  model = c("BM_linear")
  parameters=c(intercept, slope)

  ###Run the bootstrap
  RR <- bootstrap.test(E=DATA1[,3], T=DATA1[,2], L=DATA1[,1], 
     model = "BM_linear", parameters, N = c(100), method = "FAST")
  summary <- RR$summary #to show only the summary. 
  bootstraps <- RR$bootstraps #to obtain the bootstraps


###EXAMPLE 2
  ###simulate data
  set.seed(seed = 3)
  T = runif(n=100, min = 0, max = 10)
  L = runif(n=100, min = 0, max = 60)
  DATA1 <- sim.sisters(L, T, parameters = c(2, -0.03, 1, 0.1), 
     model=c("OU_linear"))
  ###Find the MLE of model parameters
  RESULT <- model.test.sisters(E=DATA1[,3], T=DATA1[,2], L=DATA1[,1], 
     models=c("OU_linear"))
  intercept_beta <- as.numeric(RESULT[1,6])
  slope_beta <- as.numeric(RESULT[1,7])
  intercept_alpha <- as.numeric(RESULT[1,12])
  slope_alpha <- as.numeric(RESULT[1,13])
  parameters=c(intercept_beta, slope_beta, intercept_alpha, slope_alpha)

  ###Run the bootstrap
  RR <- bootstrap.test(E=DATA1[,3], T=DATA1[,2], L=DATA1[,1], 
     model = "OU_linear", parameters, N = c(100), method = "FAST")
  summary <- RR$summary #to show only the summary. 
  bootstraps <- RR$bootstraps #to obtain the bootstraps


###EXAMPLE 3
 ###This example uses the syllable dataset for oscine songbirds Weir & Wheatcroft 2011
     data(bird.syllables)
     attach(bird.syllables)

  #STEP 1 Correct Euclidean distances for sampling and measurement bias
     E_cor <- MScorrection(nA=bird.syllables$number_individuals_Species1,
     nB=bird.syllables$number_individuals_Species2, 
        VarA=bird.syllables$Species1_PC2_var, 
        VarB=bird.syllables$Species2_PC2_var, 
        E_actual=abs(bird.syllables$Species1_PC2_mean - 
        bird.syllables$Species2_PC2_mean))

  #STEP 2  Test all models on oscines only (in which song has a strong 
  #culturally transmitted component)
     E <- subset(E_cor, subset = (bird.syllables$Suboscine == "oscine"))
     T <- subset(bird.syllables$T,subset = (bird.syllables$Suboscine == "oscine"))
     L <- subset(bird.syllables$L, 
        subset = (bird.syllables$Suboscine == "oscine"))
     #The best fit model in FIT2 is BM_2rate in which tropical species 
     #have a much slower rate than temperate species
     FIT2 <- model.test.sisters(E, T, L)
     beta1 <- as.numeric(FIT2 [3,6])
     breakpoint <- as.numeric(FIT2 [3,8])
     beta2 <- as.numeric(FIT2 [3,9])
     parameters=c(beta1, beta2)

  #STEP 3  Run the bootstrap
     RR <- bootstrap.test(E, T, L, model = "BM_2rate", parameters, 
        breakpoint=breakpoint, N = c(100), method = "FAST")
     summary <- RR$summary #to show only the summary. 
     bootstraps <- RR$bootstraps #to obtain the bootstraps
}
}
\keyword{bootstrap}

