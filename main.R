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
library(janitor)

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

## Join Enaho

## Widgets Quarto

## Formato Spss

## Janitor

options("width" = 10000)

mpg %>% str()
mpg %>% dim()
mpg %<>% mutate(across(where(is.character), as.factor))

mpg %>%
  dplyr::select(drv, fl, trans) %>%
  get_dupes()

mpg %>% cross_cases(fl, drv)

tmp <- sheet(x = 1:5, y = 11:15)
names(tmp) <- c("Alpha Beta", "Gamma Epsilon")

clean_names(tmp)

tmp <-
  mpg %>%
  xtabs(~ drv + fl, .) %>%
  prop.table() * 100

tmp %>%
  round(., 3) %>%
  addmargins()

## Maps Leaflet
sede_op <- read_sf(file.choose())
sede_op %>% str()

sede_op %>%
  leaflet() %>%
  addProviderTiles(as.character(providers[152])) %>%
  addPolygons(
    popup = ~ paste0("<b>", SEDEOPERAT, "</b><hr>", CODSEDE),
    color = "orange",
    opacity = .7
  )

sede_op %>% filter(SEDEOPERAT == "HUANUCO")
sede_op %>%
  dplyr::select(SEDEOPERAT, CODSEDE) %>%
  sheet()