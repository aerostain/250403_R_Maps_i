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
### Ejemplo
bd1 <- sheet(id = c(1, 2, 3, 4, 5), x = letters[1:5])
bd2 <- sheet(id = c(1, 2, 6, 7, 5), x = LETTERS[1:5])

inner_join(bd1, bd2, by = c("id"))
left_join(bd1, bd2, by = c("id"))
right_join(bd1, bd2, by = c("id"))
full_join(bd1, bd2, by = c("id"))

### ENAHO 2024
dir.create("./Files/ENAHO_2024")

#### Trimestre-I
dir.create("./Files/ENAHO_2024/Trimestre_I")
dir_orig_trim_1 <- file.path(choose.dir())
zip_files <- dir_orig_trim_1 %>% dir()
zip_files[-1] %>% sheet()

##### Listar archivos dentro de .zip
for (i in zip_files[-1]) {
  tmp <- file.path(dir_orig_trim_1, i)
  print(tmp)
  unzip(
    tmp,
    list = TRUE
  ) %>% print()
  cat("\n\n")
}

##### unzip
for (i in zip_files[-1]) {
  tmp <- file.path(dir_orig_trim_1, i)
  unzip(
    tmp,
    exdir = "Files/ENAHO_2024/Trimestre_I"
  )
}

##### Ubicar archivos .dta dentro de directorios
##### y generar los tibble's
dir_w_unzip <- "Files/ENAHO_2024/Trimestre_I"
dir_dta <- dir(dir_w_unzip)
dbs_creados <- character()

for (i in dir_dta) {
  tmp_files <- dir(file.path(dir_w_unzip, i))
  tmp_files_dta <- grep(".dta", tmp_files, value = TRUE)
  for (j in tmp_files_dta) {
    tmp_name_db <- gsub(".dta", "", j)
    tmp_name_db <- gsub("-", "_", tmp_name_db)
    tmp_read_dta_txt <- paste0(
      tmp_name_db,
      " <- read_dta('",
      file.path(dir_w_unzip, i, j),
      "')"
    )
    print(tmp_read_dta_txt)
    eval(parse(text = tmp_read_dta_txt))
    cat("Base de datos leída y almacenada\n\n")
    dbs_creados <- c(dbs_creados, tmp_name_db)
  }
}

dbs_creados %>% print()
eval(parse(text=dbs_creados[1]))
shell.exec("Files\\ENAHO_2024")




#### Trimestre-II
#### Trimestre-III
#### Trimestre-IV




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
