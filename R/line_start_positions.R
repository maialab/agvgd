line_start_positions <- function(alignment, line_width) {

  (seq_len(nr_lines_per_seq(alignment, line_width = line_width)) - 1)*line_width + 1
}
