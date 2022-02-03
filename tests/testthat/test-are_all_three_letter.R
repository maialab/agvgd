test_that("are_all_three_letter()", {

  aa <- amino_acids('three_letter')
  aa2 <- c(aa, '-')
  aa3 <- c(aa, 'X')

  expect_true(are_all_three_letter(aa))
  expect_true(are_all_three_letter(aa2, exceptions = '-'))

  expect_false(are_all_three_letter(tolower(aa)))
  expect_true(are_all_three_letter(tolower(aa), ignore_case = TRUE))

  expect_true(are_all_three_letter(tolower(aa2), ignore_case = TRUE, exceptions = '-'))
  expect_true(are_all_three_letter(aa3, ignore_case = TRUE, exceptions = 'X'))
  expect_true(are_all_three_letter(aa3, ignore_case = TRUE, exceptions = 'x'))

})
