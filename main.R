# LoadLibrary
library(tidyverse)
library(magrittr)
library(ggdark)
library(expss)
library(lubridate)
library(haven)
library(leaflet)
library(sp)
library(terra)
library(raster)
library(sf)
library(pacman)

# .lintr
text <- c(
  "linters: linters_with_defaults(",
  "  assignment_linter(allow_pipe_assign = TRUE),",
  "  line_length_linter(Inf)",
  "  )"
)

pathfile <- file.path(getwd(), ".lintr")

writeLines(text, pathfile)

options("width" = 10000)
getOption("width")

# Directorios y Archivos
dir.create("Files")
file.create(".gitignore")
file.create("test.R")
file.create("informe.qmd")
file.create("readme.md")
file.create("notes.md")

# Procesamiento


options("width" = 10000)