\name{EvoRAG-package}
\alias{EvoRAG-package}
\alias{EvoRAG}
\docType{package}
\title{
Evolutionary Rates Across Gradients
}
\description{
This packages uses maximum likelihood to estimate rates of trait evolution under several evolutionary models (Brownian Motion, Ornstein Ulhembeck) for datasets comprising many sister pairs (sister species or other sorts of sister pair data). Models in which a single evolutionary rate is applied to a dataset (null models) can be compared to models in which rates vary as a function of another continuous variable. The provided example tests to see if rates of vocal evolution in birds vary as a function of latitude. Functions are provided for simulating data under all implemented models and confidence intervals can be generated either from variances calculated via from bootstrap analysis or via profile likelihood.
}
\details{
\tabular{ll}{
Package: \tab EvoRAG\cr
Type: \tab Package\cr
Version: \tab 2.0\cr
Date: \tab 2014-01-07\cr
License: \tab GPL version 2 or greater?\cr
}
This package can be used to estimate rates of trait evolution across environmental or other sorts of gradients. The key function is model.test.sisters.
}
\author{

Jason T. Weir

Maintainer: Jason T. Weir <jason.weir@utoronto.ca>
}
\references{
Weir JT, D Wheatcroft, & T Price. 2012. The role of ecological constraint in driving the evolution of avian song frequency across a latitudinal gradient. Evolution. 66: 2773-2783.

Weir JT, & D Wheatcroft. 2011. A latitudinal gradient in rates of evolution of avian syllable diversity and song length. Proceedings of the Royal Society of London, B. 278:1713-1720.
}