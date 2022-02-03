test_that("as.matrix.align_mat()", {

  alignment <- read_alignment('ATM')
  m <- as.matrix(alignment)

  expect_s3_class(alignment, 'align_mat')
  expect_false('align_mat' %in% class(m))
  expect_true('matrix' %in% class(m))
})
