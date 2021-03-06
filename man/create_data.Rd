% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_data.R
\name{create_data}
\alias{create_data}
\title{Simulate sequencing data obtained from the alphabetr approach with a specified clonal structure}
\usage{
create_data(TCR, plates, error_drop, error_seq, error_mode, skewed, prop_top,
  dist = "linear", numb_cells)
}
\arguments{
\item{TCR}{The specified clonal structure, which can be created from
\code{\link{create_clones}}.}

\item{plates}{The number of plates of data.}

\item{error_drop}{A vector of length 2 with the mean of the drop error rate
and the sd of the drop error rate.}

\item{error_seq}{A vector of length 2 with the mean of the in-frame error
rate and the sd of the in-frame error rate.}

\item{error_mode}{A vector of two strings determining the "mode" of the error
models. The first element sets the mode of the drop errors, and the second
element sets the mode of the in-frame errors. The two modes available are
"constant" for a constant error rate and "lognormal" for error rates
drawn from a lognormal distribution. If the mode is set to "constant" the
sd specified in \code{error_drop} and/or \code{error_seq} will be ignored.}

\item{skewed}{Number of clones represent the top proportion of the population
by frequency (which is specified by \code{prop_top}).}

\item{prop_top}{The proportion of the population in frequency represented by
the number of clones specified by \code{skewed}.}

\item{dist}{The distribution of frequency of the top clones. Currently only
"linear" is available.}

\item{numb_cells}{A two column matrix determining the sampling strategy of
the experiment. The first column represents the number of cells per well,
and the second column represents the number of wells with that sample
size. The sum of column 2 should equal 96 times the number of plates.}
}
\value{
A list of length 2. The first element is a matrix representing the
   data of the alpha chains, and the second element is a matrix representing
   the data of beta chains. The matrix represents the sequencing data by
   representing the wells of the data by rows and the chain indices by
   column. Entry [i, j] of the matrix represents if chain j is found in
   well i (yes == 1, no == 0). e.g. if alpha chain 25 is found in well 10,
   then [10, 25] of the alpha matrix will be 1.
}
\description{
\code{create_data()} simulates an alphabetr sequencing experiment by sampling
   clones from a clonal structure specified by the user. The clones are
   placed on a frequency distribution where a fixed number clones represents
   the top proportion of the population in frequency and the other clones
   represent the rest of the population in frequency. Different error models
   and different sampling strategies can be simulated as well.
}
\examples{
 # see the help for create_clones() for details of this function call
 clones <- create_clones(numb_beta = 1000,
                         dual_alpha = .3,
                         dual_beta = .06,
                         alpha_sharing = c(0.80, 0.15, 0.05),
                         beta_sharing  = c(0.75, 0.20, 0.05))

 # creating a data set with 5 plates, lognormal error rates, 10 clones
 # making up the top 60\% of the population in frequency, and a constant
 # sampling strategy of 50 cells per well for 480 wells (five 96-well plates)
 dat <- create_data(clones$TCR, plate = 5,
                    error_drop = c(.15, .01),
                    error_seq  = c(.05, .001),
                    error_mode = c("lognormal", "lognormal"),
                    skewed = 10,
                    prop_top = 0.6,
                    dist = "linear",
                    numb_cells = matrix(c(50, 480), ncol = 2))


}

