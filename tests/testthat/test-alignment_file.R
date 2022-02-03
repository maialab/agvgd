test_that("alignment_file", {

  tbl <- alignment_file()
  col_names <- colnames(tbl)

  expect_identical(col_names, c('gene', 'file'))

})
