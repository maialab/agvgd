test_that("case 1: no gaps", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', 'X', 'X',
                  'X', 'X', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 1')
})

test_that("case 2: one gap", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', '-', 'X',
                  'X', 'X', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 2')
})

test_that("case 2: one gap before two gaps (left)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', '-', 'X',
                  '-', '-', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 2')
})

test_that("one gap before two gaps (right)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', '-', 'X',
                  'X', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 2')
})

test_that("one gap before three gaps", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', '-', 'X',
                  '-', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 3')
})

test_that("two gaps (left) before two gaps (left)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', 'X',
                  '-', '-', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 2')
})

test_that("two gaps (right) before two gaps (right)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', '-', '-',
                  'X', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 2')
})

test_that("three gaps before one gap", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', '-',
                  'X', '-', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 2')
})

test_that("three gaps before two gaps (left)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', '-',
                  '-', '-', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 2')
})

test_that("three gaps before two gaps (right)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', '-',
                  'X', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 2')
})

test_that("three gaps before three gaps", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', '-',
                  '-', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_equal(gap_cases(m), 'case 3')
})
