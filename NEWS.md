# agvgd 0.1.2

* Fixed a bug with `read_substitutions()` that would not parse positions correctly.
* Added a new substitutions example file `lee2010_sub.txt`.
* Added a new function `read_agvgdweb_results()` aimed at developers.

# agvgd 0.1.1

* The main function `agvgd()` had an alias, `align_agvgd()`, which is now removed to avoid confusion.
* A few more functions are now exported allowing access to low-level routines: `gd()`, `gv()` and `cpv_ranges()`.
* `alignment_pos_to_residue_pos()` has been renamed to `poi_to_res()` and `residue_pos_to_alignment_pos()` to `res_to_poi()`.
* Code coverage is now tracked.
* Added a `NEWS.md` file to track changes to the package.

# agvgd 0.1.0

* First version of `{agvgd}`.
