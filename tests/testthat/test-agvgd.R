test_that("align01", {

  example <- '01'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

test_that("align02", {

  example <- '02'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

test_that("align03", {

  example <- '03'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

test_that("align04", {

  example <- '04'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

test_that("align05", {

  example <- '05'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

test_that("align06", {

  example <- '06'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

test_that("align07", {

  example <- '07'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

test_that("align08", {

  example <- '08'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

test_that("align09", {

  example <- '09'
  agvgdweb_output_file <- paste0('alignments/agvgd', example, '.tsv')
  agvgdweb <- import_agvgdweb(agvgdweb_output_file)

  alignment_file <- paste0('alignments/align', example, '.fa')
  alignment <- read_alignment(file = alignment_file)
  poi <- res_to_poi(alignment, agvgdweb$res)
  agvgd <- agvgd(alignment = alignment, poi = poi, sub = agvgdweb$sub)

  # agvgd[-2]: drops col 2, i.e., the `poi` which is non-existent in the
  # agvgdweb output
  expect_equal(agvgdweb, agvgd[-2], tolerance = 0.001)
})

