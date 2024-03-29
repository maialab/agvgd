% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_substitutions.R
\name{read_substitutions}
\alias{read_substitutions}
\title{Read a file with amino acid substitutions}
\usage{
read_substitutions(
  file = stop("`file` must be specified"),
  amino_acid_code = c("one_letter", "three_letter")
)
}
\arguments{
\item{file}{The path to a file with amino acid substitutions.}

\item{amino_acid_code}{The type of symbol used for amino acids in the
returned output.}
}
\value{
A \link[tibble:tibble-package]{tibble} listing the amino acids
substitutions.
}
\description{
This function reads a file with amino acid substitutions. The format of
should be the same one as requested by the web version of
\href{http://agvgd.hci.utah.edu/help.php}{Align-GVGD}.
}
\examples{
# "sub.txt" is an example file containing missense substitutions formatted
# according to the requirements indicated in http://agvgd.hci.utah.edu/help.php.
my_file <- system.file("extdata", "sub.txt", package = "agvgd")
cat(readLines(my_file), sep = "\n")

read_substitutions(file = my_file)

# lee2010_sub.txt is a file containing the missense variants studied by
# Lee et al. (2010): https://doi.org/10.1158/0008-5472.CAN-09-4563.
read_substitutions(file = system.file("extdata", "lee2010_sub.txt", package = "agvgd"))

}
