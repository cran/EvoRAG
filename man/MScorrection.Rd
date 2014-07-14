\name{MScorrection}
\alias{MScorrection}
\title{Correct for finite sample size in Euclidean distances given known variances in each sample}
\description{Correct for finite sample size in Euclidean distances given known variances in each sample}
\usage{
MScorrection(nA, nB, VarA, VarB, MSwithin = NA, DIST_actual)
}
\arguments{
  \item{nA}{The number of individuals sampled in species A}
  \item{nB}{The number of individuals sampled in species B}
  \item{VarA}{Sample variance for species A}
  \item{VarB}{Sample variance for species B}
  \item{MSwithin}{Alternatively, if MSwithin (e.g. the error mean squared; see Sokal & Rohlf 1995 pg 214) is available, this can be used instead of VarA and VarB}
  \item{DIST_actual}{The uncorrected Euclidean distance between species A and B}
}
\details{
Euclidean distances are generally biased upwards by sampling and measurement error within species. This bias is typically large when few individuals are measured and the true Euclidean distance between species is small. Here I use a correction based on the ANOVA (Weir & Wheatcroft 2011) that corrects the expected bias in Euclidean distances (for full details see Weir & Whatcroft 2011, Weir et al. 2012). Corrected Euclidean distances can be used with other functions in this package. Alternatively, measurement error can be included directly in likelihood functions in model.test.sister.
}
\value{returns the negative log-Likelihood}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution 66, 2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B 278, 1713-1720.

Sokal, R. R. & Rohlf, F. J. 1995 Biometry: the principles and practice of statistics in biological research, 3rd edn. New York, NY: W. H. Freeman & Co page 214.
}
\author{Jason T. Weir}
\seealso{MScorrection_MSwithin}
\examples{

     data(bird.pitch)
     attach(bird.pitch)
     DIST_cor <- MScorrection(nA=bird.pitch$number_individuals_Species1,
        nB=bird.pitch$number_individuals_Species2, 
        VarA=bird.pitch$Variance_PC1and2_Species1, 
        VarB=bird.pitch$Variance_PC1and2_Species2, MSwithin = NA,		
        DIST_actual=bird.pitch$Uncorrected_Euclidean_Distance)
     
}