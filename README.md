
<!-- README.md is generated from README.Rmd. Please edit that file -->

# agvgd <img src='man/figures/logo.svg' align="right" height="139" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/agvgd)](https://CRAN.R-project.org/package=agvgd)
[![Codecov test
coverage](https://codecov.io/gh/maialab/agvgd/branch/master/graph/badge.svg)](https://app.codecov.io/gh/maialab/agvgd?branch=master)
<!-- badges: end -->

The R package `{agvgd}` provides an R implementation of the
Align-GVGD<sup>[1](#1),[2](#2),[3](#3)</sup> (A-GVGD) method.

A-GVGD combines multiple sequence alignment of orthologous sequences
with the Grantham distance<sup>[4](#4)</sup> to classify missense
variants, i.e. to distinguish human disease susceptibility missense
changes from changes of little clinical significance.

## Installation

Install `{agvgd}` from CRAN:

``` r
install.packages("agvgd")
```

You can install the development version of `{agvgd}` like so:

``` r
# install.packages("remotes")
remotes::install_github("maialab/agvgd")
```

## Usage

Here is a minimal example using a dummy alignment constructed from an R
matrix:

``` r
library(agvgd)

# The alignment can be provided as a simple matrix:
alignment <- matrix(
  c('P', 'M', 'I',
    'P', 'I', 'I',
    'P', 'L', 'I'),
  nrow = 3,
  byrow = TRUE
)

# In this example we will interrogate changes to the second position in the
# alignment, i.e., changes to Methionine (M); therefore we set the position of
# interest (poi) to 2.
poi <- 2

# Here's a set of three possible missense changes (substitutions): Isoleucine
# (Ile, I), Leucine (Leu, L), and Tryptophan (Trp, W):
substitutions <- c('I', 'L', 'W')

# agvgd package's main function is `agvgd()` :)
agvgd(alignment = alignment, poi = poi, sub = substitutions)
#> # A tibble: 3 × 7
#>     res   poi ref   sub      gv    gd prediction
#>   <int> <int> <chr> <chr> <dbl> <dbl> <chr>     
#> 1     2     2 M     I      14.3   0   C0        
#> 2     2     2 M     L      14.3   0   C0        
#> 3     2     2 M     W      14.3  60.4 C35
```

This is another simple example but using one of the bundled alignments
with `{agvgd}`. This one is the alignment for the gene ATM. Let’s say
you are interested in position 16 of the alignment, and that you would
like to know the impact of all possible missense substitutions:

``` r
# `read_alignment()` either reads in one of the bundled alignments with
# `{agvgd}` by gene name or directly from a FASTA file.
alignment <- read_alignment(gene = 'ATM')

# For the sake of illustration, let us define a new alignment based on a narrow
# region of the original alignment by focusing only on the first 30 positions.
# Note: rows are protein sequences; columns are alignment positions.
narrow_alignment <- alignment[, 1:30]

# poi: position of interest
poi <- 16

# Print the alignment to the console and highlight the position of interest
# (POI). NB: The POI is not highlighted in GitHub's README but it is on the R
# console.
print(narrow_alignment, poi = poi)
#> Hsap_ATM_AAB65827.1  1 M-SLVLNDLLICCRQLEHDRATERKKEVEK
#> Mmus_ATM_NP_031525.2 1 M-SLALNDLLICCRQLEHDRATERRKEVDK
#> Sscr_ATM_AAT01608.1  1 M-SLALNDLLICCRQLEHDRATERRKAVEN
#> Mdom_ATM_IARC        1 M-SLALNDLLLCCRQLENDRATERRKEVEK
#> Ggal_ATM_edited      1 M-SLVLHDLLTCCRRLENERATERRNEIEN
#> Xlae_ATM_AAT72929.1  1 M-SLALHELLLCCRQIETDKATERKKEIVK
#> Drer_ATM_IARC_v2     1 M-SLALHELLVCCRGLENEKATERKKEVDR
#> Bflo_ATM_IARC        1 MTDLLTHDLRDCCCHLESDKVTERKKNAEK
#> Spur_ATM_ABY60856.1  1 MAEVLIP-LRTACGYLGSDKITERKKQIDI

# You may use `amino_acids()` to get a vector of all the 20 standard amino acids
# and hence easily get a vector of all possible substitutions:
all_substitutions <- amino_acids()

agvgd(alignment = narrow_alignment, poi = poi, sub = all_substitutions)
#> # A tibble: 20 × 7
#>      res   poi ref   sub      gv    gd prediction
#>    <int> <int> <chr> <chr> <dbl> <dbl> <chr>     
#>  1    15    16 L     S      4.86 142.  C65       
#>  2    15    16 L     R      4.86  97.6 C65       
#>  3    15    16 L     L      4.86   0   C0        
#>  4    15    16 L     P      4.86  95.4 C65       
#>  5    15    16 L     T      4.86  89.3 C65       
#>  6    15    16 L     A      4.86  93.7 C65       
#>  7    15    16 L     V      4.86  29.6 C15       
#>  8    15    16 L     G      4.86 135.  C65       
#>  9    15    16 L     I      4.86   0   C0        
#> 10    15    16 L     F      4.86  21.3 C0        
#> 11    15    16 L     Y      4.86  33.0 C25       
#> 12    15    16 L     C      4.86 197.  C65       
#> 13    15    16 L     H      4.86  94.3 C65       
#> 14    15    16 L     Q      4.86 109.  C65       
#> 15    15    16 L     N      4.86 149.  C65       
#> 16    15    16 L     K      4.86 102.  C65       
#> 17    15    16 L     D      4.86 168.  C65       
#> 18    15    16 L     E      4.86 134.  C65       
#> 19    15    16 L     M      4.86  10.1 C0        
#> 20    15    16 L     W      4.86  60.5 C55
```

## Disclaimer

The data and information contained herein and in the results of the
`{agvgd}` package are provided on an *as is* basis and the authors makes
no representations or warranties, either expressed or implied, as to
their accuracy, completeness or suitability for a particular purpose.
Similarly, authors make no representations or warranties with regard to
the non-infringement of third party proprietary rights. Thus, the
authors do not accept any responsibility or liability with regard to the
reliance on, and/or use of, such data and information.

## Logo

The `{agvgd}` logo, `agvgd.png`, is a derivative work of an illustration
of [“Globin Evolution”](https://pdb101.rcsb.org/motm/206) by David S.
Goodsell and the [RCSB PDB](https://www.rcsb.org/), used under
[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). `agvgd.png`
is licensed under CC-BY-4.0 by Ramiro Magno.

## Related software

-   Align-GVGD (A-GVGD) by [Sean
    Tavtigian](https://uofuhealth.utah.edu/huntsman/labs/tavtigian),
    provided as a web service and hosted by the [Huntsman Cancer
    Institute](https://healthcare.utah.edu/huntsmancancerinstitute/) at
    <http://agvgd.hci.utah.edu/>.
-   Multivariate Analysis of Protein Polymorphism
    (MAPP)<sup>[5](#5)</sup> by [Eric
    Stone](https://bdsi.anu.edu.au/people/professor-eric-stone) that had
    the same ideas as A-GVGD but in a more sophisticated framework. This
    used to be provided as a Java standalone application:
    <https://biology.anu.edu.au/research/research-groups/stone-group-quantitative-and-computational-biology/software>;
    however, the download link to MAPP has been down for a long while.
-   The [grantham](https://cran.r-project.org/package=grantham) package.

## Acknowledgements

The work on this package benefited greatly from the feedback of
Professor Sean Tavtigian, and Dr. Russell Bell.

## References

<a id="1">1.</a> Tavtigian, S.V., Deffenbaugh, A. M., Yin, L., Judkins,
T., Scholl, T., Samollow, P.B., de Silva, D., Zharkikh, A., Thomas, A.
*Comprehensive statistical study of 452 BRCA1 missense substitutions
with classification of eight recurrent substitutions as neutral*.
Journal of Medical Genetics 43, 295–305 (2006). doi:
[10.1136/jmg.2005.033878](https://doi.org/10.1136/jmg.2005.033878).

<a id="2">2.</a> Mathe, E., Olivier, M., Kato, S., Ishioka, C., Hainaut,
P., Tavtigian, S.V. *Computational approaches for predicting the
biological effect of p53 missense mutations: a comparison of three
sequence analysis based methods*. Nucleic Acids Research 34, 1317–1325
(2006). doi: [10.1093/nar/gkj518](https://doi.org/10.1093/nar/gkj518).

<a id="3">3.</a> Tavtigian, S.V., Byrnes, G. B, Goldgar, D. E., Thomas,
A. *Classification of rare missense substitutions, using risk surfaces,
with genetic- and molecular-epidemiology applications*. Human Mutation
29, 1342–1354. doi:
[10.1002/humu.20896](https://doi.org/10.1002/humu.20896)

<a id="4">4.</a> Grantham, R. *Amino acid difference formula to help
explain protein evolution*. Science 185, 862–864 (1974). doi:
[10.1126/science.185.4154.862](https://doi.org/10.1126/science.185.4154.862).

<a id="5">5.</a> Stone, E. A., Sidow, Arend. *Physicochemical constraint
violation by missense substitutions mediates impairment of protein
function and disease severity*. Genome Research 15, 978–986 (2005). doi:
[10.1101/gr.3804205](https://doi.org/10.1101/gr.3804205).
