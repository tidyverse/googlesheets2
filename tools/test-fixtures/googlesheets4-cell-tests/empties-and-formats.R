library(tidyverse)
devtools::load_all() # I assume we're in googlesheets4 source
library(googledrive)

gs4_auth_testing()

ss <- test_sheet_create()
gs4_browse(ss)

# TODO: I created this worksheet in the browser; add code here once possible

# I riffed on the original Sheet provided by @nadnudus in
# https://github.com/tidyverse/googlesheets4/issues/4
# ssid <- as_sheets_id("1UbdlyITXLvsxQt6kpszu5gfiDmF5Q-wOrNC7l4E9jOg")
# gs4_browse(ss)
# I copied the "legend" worksheet.
# Added a note to C1.
# Added a comment (as rstudio jenny) to C2.
