test_that("single line", {

  alignment <- read_alignment('ATM')[1:2, 1:10]

  expect_invisible(print_align_mat(alignment))
  expect_output(print_align_mat(alignment))

  expect_invisible(print.align_mat(alignment))
  expect_output(print.align_mat(alignment))

  expect_output(print_align_mat(alignment, poi = 2))
  expect_error(print_align_mat(alignment, poi = 0))
  expect_error(print_align_mat(alignment, poi = ncol(alignment) + 1))
})

test_that("multiline", {

  alignment <- read_alignment('ATM')[1:2, 1:10]

  expect_invisible(print_align_mat(alignment, line_width = 5))
  expect_output(print_align_mat(alignment, line_width = 5))

  expect_invisible(print.align_mat(alignment, line_width = 5))
  expect_output(print.align_mat(alignment, line_width = 5))

  expect_output(print_align_mat(alignment, poi = 2, line_width = 5))
  expect_error(print_align_mat(alignment, poi = 0, line_width = 5))
  expect_error(print_align_mat(alignment, poi = ncol(alignment) + 1, line_width = 5))
})
