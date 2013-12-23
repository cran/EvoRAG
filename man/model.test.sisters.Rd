\name{model.test.sisters}
\alias{model.test.sisters}
\title{Fit evolutionary models for continuous trait data}
\description{
	Takes a dataset of continuous trait values for a series of sister pairs (e.g. sister species) with known ages of divergence and finds the maximum likelihood fits under a series of evolutionary models.
}
\usage{
model.test.sisters(E, T, L, models = c("BM_null", "BM_linear", 
     "BM_2rate", "BM_linear_breakpoint", "BM_quadratic", "OU_null", 
     "OU_linear_beta", "OU_linear", "OU_2rate", "OU_linear_breakpoint"), 
     starting=list("NULL"), Beta_starting = "NULL", Alpha_starting = "NULL")
}
\arguments{
  \item{E}{vector of Euclidean distances for sister pair dataset}
  \item{T}{vector of evolutionary ages (i.e. node ages ) for sister pair dataset}
  \item{L}{vector of gradient values (i.e. any continuous variable) for sister pair dataset (see Details)}
  \item{models}{A vector listing which models to test. By default all models are tested. Models with more than 4 parameters 
      should be used with caution, especially with small datasets (i.e. less than 100 sister pairs) as the data may provide insufficient power
      to reject simpler models in favor of complex ones. As a general rule of thumb, I suggest a minimum of 20 sister pairs for every model
      parameter.}
  \item{starting}{List of starting values for each model. If starting=list("NULL"), the built-in starting parameters are used.
     The method can be sensitive to starting parameters. For each model, the null method tests a large number of starting parameters, and chooses
     the set of starting parameters maximized the likelihood. However, the null starting parameters may not be optimized for all datasets.
     The user can customize starting parameters. Each element of the list that is not "NULL" is a matrix, with the number of columns equal
     to the number of model parameters and each row containing a different set of starting parameters. See Example 3 below.}
  \item{Beta_starting}{vector of Beta starting values to test for BM_2rate and OU_2rate models. "Null" uses built-in starting parameters are used. The null values are c(0.001, 0.01, 0.1, 1, 10, 100, 1000) for BM_2rate and c(0.01, 0.1, 1, 10, 100) for OU_2rate}
  \item{Alpha_starting}{vector of Alpha starting values to test for OU_2rate model. "Null" uses built-in starting parameters are used. The null values are c(0.01, 0.1, 1, 10)}
}
\details{
Evolutionary models include null models whereby a single set of model parameters are fit to all sister pairs and models whereby parameters are allowed to vary as a function of another continuous variable. The second continuous variable could be elevation, latitude, body mass or any other continuous variable of interest, over which rates of trait evolution might vary. This function uses the nlm optimizer to search for the maximum likelihood estimates under 10 evolutionary models. For details of the evolutionary models implemented see sisterContinuous. Running all models on a dataset of about 100 sisters should take about 5 to 10 minutes. Excluding those models with more than 4 parameters will speed up the search considerably. For BM_2rate and OU_2rate models, Beta and alpha values before and after the breakpoint are each set to the values in Beta_starting and Alpha_starting, and all possible pairwise combinations of these are tested together with a variety of breakpoints. Thus keep the length of these vectors of starting values under 5, or expect to wait a long time for the function to execute.
}
\value{
Returns a table with log-likelihoods, Akaike information criterion, parameter estimates and parameter variances (as estimated using the Hessian matrix) for each of 10 evolutionary models. Hessian matrices are sometimes singular and thus cannot always be inverted to obtain parameter variances (the 2 rate models routinely have this issue). The final column with heading CHECK states TRUE if variances were successfully extracted. Alternatively, use bootstrapping to obtain variances and confidence intervals.
}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution 66,2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B 278,1713-1720.
}
\author{Jason T. Weir}
\seealso{sisterContinuous}
\examples{
\dontrun{
##Example 1
  ###This example uses the four models used in Weir et al. 2012 to test for 
  ###a latitudinal effect on Euclidean distances for bird song pitch on 87 
  ###forest sister pairs.
     data(bird.pitch)
     attach(bird.pitch)

  #STEP 1 Correct Euclidean distances for sampling and measurement bias
     E_cor <- MScorrection(nA=bird.pitch$number_individuals_Species1,
        nB=bird.pitch$number_individuals_Species2, 
        VarA=bird.pitch$Variance_PC1and2_Species1, 
        VarB=bird.pitch$Variance_PC1and2_Species2, 
        E_actual=bird.pitch$Uncorrected_Euclidean_Distance)

  #STEP 2  Extract and test only forest species
     E <- subset(E_cor, subset = (bird.pitch$Habitat == "forest"))
     T <- subset(bird.pitch$T,subset = (bird.pitch$Habitat == "forest"))
     L <- subset(bird.pitch$L, 
        subset = (bird.pitch$Habitat == "forest"))
     models = c("BM_null", "BM_linear", "OU_null", "OU_linear")
     #The following generally takes 1 to 2 minutes to run
     FIT1 <- model.test.sisters(E, T, L, models)

  ###The best fit model for forest species is the OU_linear model in which  
  ###rates of evolution increase with latitude (b1_slope is positive) and 
  ###evolutionary constraint declines with increasing latitude (a1_slope is 
  ###negative).High latitude species are evolving faster and in a less 
  ###constrained fashion.

##Example 2
  ###This example tests to see if allopatric and sympatric species pairs
  ###have significantly different rates under the BM_null model

  #STEP 1  Correct Euclidean distances for sampling and measurement bias
     E_cor <- MScorrection(nA=bird.pitch$number_individuals_Species1,
        nB=bird.pitch$number_individuals_Species2, 
        VarA=bird.pitch$Variance_PC1and2_Species1, 
        VarB=bird.pitch$Variance_PC1and2_Species2, 
            E_actual=bird.pitch$Uncorrected_Euclidean_Distance)

  #STEP 2  First, fit BM_linear to the entire dataset
     E <- E_cor
     T <- bird.pitch$T
     L <- bird.pitch$L
     models = c("BM_null")
     FIT2a <- model.test.sisters(E, T, L, models) 

  #STEP 3  Next, fit BM_linear to the allopatric subset
     E <- subset(E_cor, subset = (bird.pitch$Patry == "allopatric"))
     T <- subset(bird.pitch$T,
        subset = (bird.pitch$Patry == "allopatric"))
     L <- subset(bird.pitch$L, 
        subset = (bird.pitch$Patry == "allopatric"))
     models = c("BM_null")
     FIT2b <- model.test.sisters(E, T, L, models) 

  #STEP 4  Finally, fit BM_linear to the sympatric subset
     E <- subset(E_cor, subset = (bird.pitch$Patry == "sympatric"))
     T <- subset(bird.pitch$T,
        subset = (bird.pitch$Patry == "sympatric"))
     L <- subset(bird.pitch$L, 
        subset = (bird.pitch$Patry == "sympatric"))
     models = c("BM_null")
     FIT2c <- model.test.sisters(E, T, L, models) 

  #STEP 5  Compare the AIC of the model fit to the entire dataset to the model 
  #with separate rates for allopatric and sympatric subsets.
     ###To calculate AIC for the allopatric and sympatric model
     ###the loglikelihoods for the subsets are summed
     logLikelihood <- as.numeric(FIT2b[,2]) + as.numeric(FIT2c[,2]) 
     ###The subsets model has 2 parameters (1 for each subset) 
     ###thus AIC = 2*2 - 2*logLike
     AIC_forest_nonforest <-  2*2 - 2*logLikelihood 
     
  ###The AIC for the entire dataset is 167.37 and for the model with separate rates 
  ###for allopatric and sympatric AIC is 167.64. The best fit model is the full dataset 
  ###model without separate rates for different subsets, indicating a failure to reject 
  ###the null hypothesis in favour of separate rates for allopatric and sympatric 
  ###species pairs.


##Example 3
  ###using the same data as Example 1, this example demonstrates user control of 
  ###starting parameters
  #STEP 1  generate matrices of starting values for those models which the user 
  #wishes to use customized starting values
     p_matrix <- c(0.0001, 0.001, 0.01, 0.1, 1,2,3,4,5,10,100,1000)
     BM_null_starting <- matrix(p_matrix, length(p_matrix), 1, byrow=TRUE)

     p_matrix <- c(10, -1, 10, 1, 0, -0.1, 0, 0.1)
     BM_linear_starting <- matrix(p_matrix, length(p_matrix)/2, 2, byrow=TRUE)

  #first, use only 2 models, each with customize starting parameters 
     models <- c("BM_null", "BM_linear")
     FIT3a <- model.test.sisters(E, T, L, models = models, 
         starting = list(BM_null_starting, BM_linear_starting) )

  #next use 4 models, but customize starting parameters for only the first two 
     models <- c("BM_null", "BM_linear", "OU_null", "OU_linear")
     FIT3b <- model.test.sisters(E, T, L, models, 
         starting = list(BM_null_starting, BM_linear_starting, "NULL", "NULL") )

  #next use all models, but customize starting parameters for only the first two 
     FIT3c <- model.test.sisters(E, T, L, starting = list(BM_null_starting, 
         BM_linear_starting, "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", 
         "NULL", "NULL") )

##Example 4
  ###This example simulates data under a model to see if model.test.sisters
  ###can accurately choose the correct model and parameters
  T = runif(n=1000, min = 0, max = 10)
  L = runif(n=1000, min = 0, max = 60)

  #First, simulate under BM_linear model
  models <- c("BM_null", "BM_linear", "OU_null", "OU_linear")
  DATA4A <- sim.sisters(L, T, parameters = c(0.1, 0.01), model=c("BM_linear"), MULT=10)
  FIT4A <- model.test.sisters(E=DATA4A[,3], T=DATA4A[,2], L=DATA4A[,1], models)
  ###The best fit model is BM_linear, and estimated model parameters are similar to the
  ###actual model parameters in the simulated data.

  #Next simulate under the OU_linear model
  models <- c("BM_null", "BM_linear", "OU_null", "OU_linear")
  DATA4B <- sim.sisters(L, T, parameters = c(0.2, 0.02,1, -0.01), model=c("OU_linear"))
  FIT4B <- model.test.sisters(E=DATA4B[,3], T=DATA4B[,2], L=DATA4B[,1], models)
  ###The best fit model is OU_linear, and estimated model parameters are similar to the
  ###actual model parameters in the simulated data.


##EXAMPLE 5
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
     FIT5 <- model.test.sisters(E, T, L)
     #The best fit model in FIT5 is BM_2rate in which tropical species have a 
     #much slower rate than temperate species. this model was not tested in Weir 
     #& Wheatcroft 2011, and gives a better fit (but similar results) than the 
     #BM_linear model which they use.
 }#end dontrun
}
\keyword{Brownian Motion}
\keyword{Ornstein Uhlenbeck}
