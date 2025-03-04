## ----pkg
library(tidyverse)
library(sf)
library(rvest) # population data web scrapping
library(scrapeR) # population data web scrapping
library(polite) # population data web scrapping


## ---- datafilelinks
#https://data.humdata.org/dataset/sri-lanka-administrative-levels-0-4-boundaries
#Sri Lanka administrative 
#levels 0 (country), 
#1 (province),
#2 (district), 
#3 (divisional secretariat) and 
#4 (grama niladhari) boundary shapefiles, geodatabase, EMF files, and gazetteer

#These boundaries are suitable for database or GIS linkage to the Sri Lanka - Subnational Population Statistics tables.

## ----ad0:country
sf_sl_0 <- read_sf("data-raw/lka_adm_slsd_20200305_shp/lka_admbnda_adm0_slsd_20200305.shp") %>%
  select(ADM0_EN, geometry) # Select the level 0 country
sf_sl_0 <- sf_sl_0 %>% st_transform(5235)
sf_sl_0 <- sf_sl_0 %>% 
  mutate(COUNTRY = str_to_upper(ADM0_EN)) %>% 
  select(-ADM0_EN)
save(sf_sl_0, file="data/sf_sl_0.rda", compress='xz')
ggplot(sf_sl_0) + 
  geom_sf() 


## ----ad1:province
sf_sl_1 <- read_sf("data-raw/lka_adm_slsd_20200305_shp/lka_admbnda_adm1_slsd_20200305.shp") %>%
  select(ADM1_EN, geometry) # Select the level 1 districts (adm1)
sf_sl_1 <- sf_sl_1 %>% st_transform(5235)
class(sf_sl_1)
sf_sl_1 <- sf_sl_1 %>% 
  mutate(PROVINCE = str_to_upper(ADM1_EN)) %>% 
  select(-ADM1_EN)
#save(sf_sl_1, file="data/sf_sl_1.rda", compress='xz')
ggplot(sf_sl_1) + 
  geom_sf() 

pop_url <- "https://www.citypopulation.de/en/srilanka/prov/admin/"
pop_table <- bow(pop_url) %>% 
  scrape() %>% 
  rvest::html_table() %>% 
  purrr::pluck(1)
pop_data_province <- pop_table %>% 
  select(PROVINCE = Name, Status,
         population = `PopulationEstimate2020-07-01`) %>% 
  filter(Status == "Province") 
pop_data_province <- pop_data_province %>% 
  # use province name from sf_sl_1
  mutate(PROVINCE = case_when(
    PROVINCE == "Central (Madhyama)" ~ "Central",
    PROVINCE == "Eastern (Kilakku, Negenahira)" ~ "Eastern",
    PROVINCE == "North Central (Uturumeda)" ~ "North Central",
    PROVINCE == "Northern (Vatakku, Uturu)" ~ "Northern",
    PROVINCE == "North Western (Wayamba)" ~ "North Western",
    PROVINCE == "Sabaragamuwa" ~ "Sabaragamuwa",
    PROVINCE == "Southern (Dakunu)" ~ "Southern",
    PROVINCE == "Uva" ~ "Uva",
    PROVINCE == "Western (Basnahira)" ~ "Western",
    TRUE ~ PROVINCE)) %>% 
    mutate(PROVINCE = str_to_upper(PROVINCE))


province <- left_join(sf_sl_1, pop_data_province,
                       by = c("PROVINCE"))
province <- province %>% mutate(population = parse_number(population))
ggplot(province) + 
  geom_sf() 
save(province, file="data/province.rda", compress='xz')

## ----ad2:district
sf_sl_2 <- read_sf("data-raw/lka_adm_slsd_20200305_shp/lka_admbnda_adm2_slsd_20200305.shp") %>%
  select(ADM2_EN, geometry) # Select the level 2 districts (adm2)
sf_sl_2 <- sf_sl_2 %>% st_transform(5235)
class(sf_sl_2)
sf_sl_2 <- sf_sl_2 %>% 
  mutate(DISTRICT = str_to_upper(ADM2_EN)) %>% 
  select(-ADM2_EN)
#save(sf_sl_2, file="data/sf_sl_2.rda", compress='xz')
ggplot(sf_sl_2) + 
  geom_sf() 


pop_url <- "https://www.citypopulation.de/en/srilanka/prov/admin/"
pop_table <- bow(pop_url) %>% 
  scrape() %>% 
  rvest::html_table() %>% 
  purrr::pluck(1)
pop_data_district <- pop_table %>% 
  select(DISTRICT = Name, Status,
         population = `PopulationEstimate2020-07-01`) %>% 
  filter(Status == "District") %>% 
  mutate(DISTRICT = str_to_upper(DISTRICT)) %>% 
mutate(DISTRICT = ifelse(
  DISTRICT == "MONERAGALA", "MONARAGALA", DISTRICT))


district <- left_join(sf_sl_2, pop_data_district,
                                by = c("DISTRICT"))

district <- district %>% mutate(population = parse_number(population))

save(district, file="data/district.rda", compress='xz')

## ----ad3:divisional secratariat
sf_sl_3 <- read_sf("data-raw/lka_adm_slsd_20200305_shp/lka_admbnda_adm3_slsd_20200305.shp") %>%
  select(ADM3_EN, geometry) # Select the level 2 districts (adm2)
sf_sl_3 <- sf_sl_3 %>% st_transform(5235)
class(sf_sl_3)
sf_sl_3 <- sf_sl_3 %>% 
  mutate(DIVISIONAL.SECRETARIAT = str_to_upper(ADM3_EN)) %>% 
  select(-ADM3_EN)
save(sf_sl_3, file="data/sf_sl_3.rda", compress='xz')
ggplot(sf_sl_3) + 
  geom_sf() 

## ----ad4:gramaniladari
sf_sl_4 <- read_sf("data-raw/lka_adm_slsd_20200305_shp/lka_admbnda_adm4_slsd_20200305.shp") %>%
  select(ADM4_EN, geometry) # Select the level 2 districts (adm2)
sf_sl_4 <- sf_sl_4 %>% st_transform(5235)
class(sf_sl_4)
sf_sl_4
save(sf_sl_4, file="data/sf_sl_4.rda", compress='xz')
ggplot(sf_sl_4) + 
  geom_sf() 

## ---- population

pop_url <- "https://www.citypopulation.de/en/srilanka/prov/admin/"
pop_table <- bow(pop_url) %>% 
  scrape() %>% 
  rvest::html_table() %>% 
  purrr::pluck(1)
pop_data_district <- pop_table %>% 
  select(DISTRICT = Name, Status,
         population = `PopulationEstimate2020-07-01`) %>% 
  filter(Status == "District")
pop_sl_1 <- pop_data_district


## river network data (2023-12-26)
#https://blog.benthies.de/blog/mapping-streams-and-rivers-with-ggplot-sf/
# Packages
library(dplyr) # Data manipulation
library(ggplot2) # Plotting
library(sf) # Geometric operations
library(ceylon)
library(sp)

# Sri Lanka Rivers and Streams
#https://data.humdata.org/dataset/sri-lanka-water-bodies-0-0?#
#unzip("lka_rapidsl_rvr_250k_sdlka.zip")
#rivers <- st_read("lka_rapidsl_rvr_250k_sdlka.shp")
#saveRDS(rivers, "rivers.rds")
# Above code is from https://github.com/thiyangt/30DayMapChallenge/blob/main/17_day.R
#take rivers.rds from https://github.com/thiyangt/30DayMapChallenge/blob/main/17_day.R
rivers <- readRDS("~/Lecturer/ceylon/data-raw/rivers.rds")
rivers <- rivers |> st_transform(5235)
rivers <- rivers |>
  dplyr::select(CODE, NAME, geometry)
save(rivers, file="data/rivers.rda", compress='xz')
