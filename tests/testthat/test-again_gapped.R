test_that("no gaps", {
  m <- matrix(data =
                 c('X', 'X', 'X',
                   'X', 'X', 'X',
                   'X', 'X', 'X'),
                nrow = 3,
               byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("one gap", {
  m <- matrix(data =
                 c('X', 'X', 'X',
                   'X', '-', 'X',
                   'X', 'X', 'X'),
               nrow = 3,
               byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("one gap before two gaps (left)", {
  m <- matrix(data =
                 c('X', 'X', 'X',
                   'X', '-', 'X',
                   '-', '-', 'X'),
               nrow = 3,
               byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("one gap before two gaps (right)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', '-', 'X',
                  'X', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("one gap before three gaps", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', '-', 'X',
                  '-', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_true(again_gapped(m))
})

test_that("two gaps (left) before two gaps (left)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', 'X',
                  '-', '-', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("two gaps (right) before two gaps (right)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  'X', '-', '-',
                  'X', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("three gaps before one gap", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', '-',
                  'X', '-', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("three gaps before two gaps (left)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', '-',
                  '-', '-', 'X'),
              nrow = 3,
              byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("three gaps before two gaps (right)", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', '-',
                  'X', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_false(again_gapped(m))
})

test_that("three gaps before three gaps", {
  m <- matrix(data =
                c('X', 'X', 'X',
                  '-', '-', '-',
                  '-', '-', '-'),
              nrow = 3,
              byrow = TRUE)

  expect_true(again_gapped(m))
})
