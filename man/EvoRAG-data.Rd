\name{EvoRAG-data}
\alias{bird.pitch}
\alias{bird.syllables}
\title{example data sets of avian sister pairs with trait data and a gradient}
\description{This dataset is from Weir et al. 2012 (Evolution). 
}
\usage{
data(bird.pitch)
data(bird.syllables)
}

\details{
bird.pitch: Euclidean distances are estimated from 6 measures of bird song pitch (using a Euclidean distance of PC1 and PC2). The gradient is midpoint latitude of the sister pair.

bird.syllables: Euclidean distances are from PC2 in a dataset which measured number of syllable types and temporal aspects of bird song. PC2 reflected the number of syllable types in a song. The gradient is midpoint latitude of the sister pair.
}
\value{returns the dataset in the form of a matrix}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution 66, 2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B. 278:1713-1720.

}
\author{Jason T. Weir}
\examples{
     data(bird.pitch)
     data(bird.syllables)
}