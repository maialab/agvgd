test_that("ref_sequence()", {

  alignment_ATM <- read_alignment('ATM')
  ref_seq <- ref_sequence(alignment_ATM)

  expect_true(is.atomic(ref_seq))
  expect_true(is.character(ref_seq))
})


