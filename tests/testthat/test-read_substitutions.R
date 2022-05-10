test_that("basic usage", {

  my_file <- system.file("extdata", "sub.txt", package = "agvgd")
  ex01 <- read_substitutions(file = my_file)
  ex02 <- read_substitutions(file = my_file, amino_acid_code = 'three_letter')

  expected01 <-
    structure(
      list(
        res = c(2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                2L, 2L, 2L),
        poi = rep(NA_integer_, 19L),
        ref = c("P", "P", "P", "P", "P", "P", "P", "P", "P", "P", "P", "P", "P",
                "P", "P", "P", "P", "P", "P"),
        sub = c( "S", "R", "L", "T", "A", "V", "G", "I", "F", "Y", "C", "H",
                 "Q", "N", "K", "D", "E", "M", "W")
      ),
      row.names = c(NA, -19L), class = c("tbl_df", "tbl", "data.frame")
    )

  expected02 <-
    structure(
      list(
        res = c(2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L,
                2L, 2L, 2L),
        poi = rep(NA_integer_, 19L),
        ref = c("Pro", "Pro", "Pro", "Pro", "Pro", "Pro", "Pro", "Pro", "Pro",
                "Pro", "Pro", "Pro", "Pro", "Pro", "Pro", "Pro", "Pro", "Pro",
                "Pro"),
        sub = c("Ser",  "Arg", "Leu", "Thr", "Ala", "Val", "Gly", "Ile", "Phe",
                "Tyr", "Cys", "His", "Gln", "Asn", "Lys", "Asp", "Glu", "Met",
                "Trp")),
      row.names = c(NA, -19L),
      class = c("tbl_df", "tbl", "data.frame"))

  expect_equal(ex01, expected01)
  expect_equal(ex02, expected02)

})
