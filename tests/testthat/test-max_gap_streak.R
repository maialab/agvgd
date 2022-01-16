test_that("typical usage of `max_gap_streak()`", {
  expect_equal(max_gap_streak('Val'), 0L)
  expect_equal(max_gap_streak(c('Val', '-')), 1L)
  expect_equal(max_gap_streak(c('Val', '-', '-')), 2L)

})

test_that("picking the longest streak of gaps`", {
  expect_equal(max_gap_streak(c('-', 'Val', '-', '-')), 2L)
  expect_equal(max_gap_streak(c('-', 'Val', '-', '-', 'Pro', '-', '-', '-')), 3L)

})

test_that("empty inputs", {
  expect_equal(max_gap_streak(character()), 0L)
  expect_equal(max_gap_streak(NA_character_), 0L)
  expect_equal(max_gap_streak(c(NA_character_, NA_character_)), 0L)

})
