## ----pkg
library(tidyverse)
library(sf)

## ---- datafilelinks
#https://data.humdata.org/dataset/sri-lanka-administrative-levels-0-4-boundaries
#Sri Lanka administrative 
#levels 0 (country), 
#1 (province),
#2 (district), 
#3 (divisional secretariat) and 
#4 (grama niladhari) boundary shapefiles, geodatabase, EMF files, and gazetteer

#These boundaries are suitable for database or GIS linkage to the Sri Lanka - Subnational Population Statistics tables.

## ----ad1:province
sf_sl_1 <- read_sf("data-raw/lka_adm_slsd_20200305_shp/lka_admbnda_adm1_slsd_20200305.shp") %>%
  select(ADM1_EN, geometry) # Select the level 1 districts (adm1)
sf_sl_1 <- sf_sl_1 %>% st_transform(5235)
class(sf_sl_1)
sf_sl_1 <- sf_sl_1 %>% 
  mutate(PROVINCE = str_to_upper(ADM1_EN)) %>% 
  select(-ADM1_EN)
save(sf_sl_1, file="data/sf_sl_1.rda")
ggplot(sf_sl_1) + 
  geom_sf() 
