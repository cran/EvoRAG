\name{Profile.like.CI}
\alias{Profile.like.CI}
\title{Estimate confidence intervals using profile likelihood}
\description{
	profile likelihood is used to estimate 95% confidence intervals for select models. 
}
\usage{
Profile.like.CI(DIST, TIME, GRAD, meserr1 = 0, meserr2 = 0, like, par, 
   MODEL, test.values.par1, test.values.par2, p_starting="NULL")
}
\arguments{
  \item{DIST}{vector of Euclidean distances for sister pair dataset}
  \item{TIME}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{GRAD}{vector of gradient values (i.e. any continuous variable) for sister pair dataset (see Details)}
  \item{meserr1}{a list of measurement errors that correspond to the first of each species in a sister pair. Order of sister pairs is the same as for DIST.}
  \item{meserr2}{a list of measurement errors that correspond to the second of each species in a sister pair. Order of sister pairs is the same as for DIST.}
  \item{like}{loglike at the MLE as returned by model.test.sisters}
  \item{par}{a vector containing the maximum likelihood estimates of model parameters. These should be in the order indicated in sisterContinuous. }
  \item{MODEL}{The name of the gradient model to perform profile likelihood on. Currently implemented models are "BM_linear", "OU_linear_beta", and "OU_linear"}
  \item{test.values.par1}{a vector of values to calculate likelihoods for parameter 1}
  \item{test.values.par2}{a vector of values to calculate likelihoods for parameter 2}
  \item{p_starting}{List of starting values for the model. If starting=list("NULL"), the built-in starting parameters are used, and is generally recommended.}
}
\details{
This function uses profile likelihood to estimate confidence for select parameters. Likelihood surfaces often have ridges (e.g. the "OU_linear" model), and the resulting confidence intervals are not always symmetric around the MLE. 
Profile likelihood generates confidence intervals appropriate in such cases. However, the code is computationally demanding. 
Currently, profile likelihood is only implemented for the two parameters of BM_linear and for the slope parameters of OU_linear_beta (1 parameter) and OU_linear (2 parameters).
}
\value{
Returns a list with the following elements:
profile.likelihoods_par1, 2, 3 etc  For each parameter, a matrix showing the range of values tested (test.value), the log likelihoods of each value in the range (logLike), the difference in likelihood from the MLE and each value (logLikeDifference). The final column (CI_range) gives a 1 if the value was less than 1.92 loglikelihood units below the MLE, and thus outside the 95% confidence intervals, and a 0 if it fell within the CI.
model   The model used
MLE_par1  The MLE for parameter 1
CI_par1  The lower and upper 95% CI for parameter 100
warnings_par1  A warning is returned only if  the lower or upper limit of the CI has not been reached by the range of tested values. Otherwise, returns NA
}
\author{Jason T. Weir}
\seealso{bootstrap.test}
\examples{
\dontrun{

  ###This example uses the syllable dataset for oscine songbirds Weir & Wheatcroft 2011
  data(bird.syllables)
  attach(bird.syllables)

  #STEP 1 Correct Euclidean distances for sampling and measurement bias
     DIST_cor <- MScorrection(nA=bird.syllables$number_individuals_Species1,
        nB=bird.syllables$number_individuals_Species2, 
        VarA=bird.syllables$Species1_PC2_var, 
        VarB=bird.syllables$Species2_PC2_var, 
        DIST_actual=abs(bird.syllables$Species1_PC2_mean - 
        bird.syllables$Species2_PC2_mean))

  #STEP 2  Test all models on oscines only (in which song has a strong 
  #culturally transmitted component)
     DIST <- subset(DIST_cor, subset = (bird.syllables$Suboscine == "oscine"))
     TIME <- subset(bird.syllables$TIME,subset = (bird.syllables$Suboscine == "oscine"))
     GRAD <- subset(bird.syllables$GRAD, 
        subset = (bird.syllables$Suboscine == "oscine"))
     FIT5 <- model.test.sisters(DIST=DIST, TIME=TIME, GRAD=GRAD, models=models)
     #The best fit model in FIT5 is BM_linear in which tropical species have a 
     #much slower rate than temperate species. 

  #STEP 3 run the profile likelihood
  Profile.like.CI(DIST=DIST, TIME=TIME, GRAD=GRAD, meserr1 = 0, meserr2 = 0, 
     like=FIT5[1,2], par=c(FIT5[5,2], FIT5[6,2]), MODEL="BM_linear", MULT=1, 
	 test.values.par1 = c((0:100)*0.001), test.values.par2 = c((33:100)*0.0001), 
	 p_starting="NULL")
	 
  }#end dontrun
}
 \keyword{confidence interval}