gvgd_to_class <- function(gv, gd) {
  dplyr::case_when(
  gd >= 65 + tan(2*pi*(10 / 360))*(gv^2.50) ~ 'C65',
  gd >= 55 + tan(2*pi*(10 / 360))*(gv^2.00) ~ 'C55',
  gd >= 45 + tan(2*pi*(15 / 360))*(gv^1.70) ~ 'C45',
  gd >= 35 + tan(2*pi*(50 / 360))*(gv^1.10) ~ 'C35',
  gd >= 25 + tan(2*pi*(55 / 360))*(gv^0.95) ~ 'C25',
  gd >= 15 + tan(2*pi*(75 / 360))*(gv^0.60) ~ 'C15',
  gd <  15 + tan(2*pi*(75 / 360))*(gv^0.60) ~ 'C0',
  TRUE ~ NA_character_
  )
}
