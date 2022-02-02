test_that("check class & type", {
  alignment <- read_alignment('XRCC2')

  expect_s3_class(alignment, 'align_mat')
  expect_type(alignment, 'character')
})
