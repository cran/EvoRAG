\name{starting.values}
\alias{starting.values}
\title{returns the null starting values used in model.test.sisters}
\description{
	returns the null starting values used in model.test.sisters
}
\usage{
starting.values(MODEL)
}
\arguments{
  \item{MODEL}{any one of the evolutionary models implemented by model.test.sisters except BM_2rate and OU_2rate.}
}

\details{
because nlm (and other optimization functions in R) often gets stuck on local likelihood optima, model.test.sisters uses a variety of starting parameters in combination with nlm optimization and reports the results for the best set of starting parameters as the maximum likelihood estimate. The null starting parameters have been optimized for rates of Beta and Alpha that are typically less than 1. The user can also provide their own matrix of starting parameters. This function is provided here so the user can determine if the starting parameters are suited to their particular dataset. Alternatively, values of Euclidean distances and of L can also be transformed (i.e. by dividing large values by a constant) so they lie within a range acceptable for the starting parameters.
}

\value{returns a matrix with the starting values. Each column is a different parameter, and the last column is NA}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution 66, 2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B 278, 1713-1720.
}
\author{Jason T. Weir}
\seealso{model.test.sisters}
\examples{

starting.values(MODEL = "OU_linear")
    
}
\keyword{Brownian Motion}
\keyword{Ornstein Uhlenbeck}
