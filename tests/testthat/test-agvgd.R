test_that("agvgd errors", {

  alignment <- read_alignment('ATM')
  expect_error(agvgd(alignment = alignment, poi = letters[1:10]))
  expect_error(agvgd(alignment = alignment, poi = 1:10, sub = 'Ser'))

})

test_that("agvgd `mode` parameter", {

  alignment <- read_alignment('ATM')

  r_vec <- agvgd(alignment = alignment, poi = 3:4, sub = c('A', 'V'))
  expect_equal(r_vec$poi, 3:4)
  expect_equal(r_vec$sub, c('A', 'V'))

  r_expand_grid <- agvgd(alignment = alignment, poi = 3:4, sub = c('A', 'V'), mode = 'expand_grid')
  expect_equal(r_expand_grid$poi, c(3, 3, 4, 4))
  expect_equal(r_expand_grid$sub, c('A', 'V', 'A', 'V'))

})

test_that("agvgd `sort` parameter", {

  alignment <- read_alignment('ATM')

  r_vec <- agvgd(alignment = alignment, poi = 3:4, sub = c('A', 'V'), sort = TRUE)
  expect_equal(r_vec$gd, sort(r_vec$gd, decreasing = TRUE))

  r_expand_grid <- agvgd(alignment = alignment, poi = 3:4, sub = c('A', 'V'), mode = 'expand_grid', sort = TRUE)
  expect_equal(r_expand_grid$gd, sort(r_expand_grid$gd, decreasing = TRUE))

})

test_that("align01", {

  example <- '01'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

test_that("align02", {

  example <- '02'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

test_that("align03", {

  example <- '03'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

test_that("align04", {

  example <- '04'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

test_that("align05", {

  example <- '05'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

test_that("align06", {

  example <- '06'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

test_that("align07", {

  example <- '07'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

test_that("align08", {

  example <- '08'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

test_that("align09", {

  example <- '09'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- read_agvgdweb_results(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb[-2], agvgd[-2], tolerance = 0.001)
})

