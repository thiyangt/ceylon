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
save(sf_sl_1, file="data/sf_sl_1.rda", compress='xz')
ggplot(sf_sl_1) + 
  geom_sf() 

## ----ad2:district
sf_sl_2 <- read_sf("data-raw/lka_adm_slsd_20200305_shp/lka_admbnda_adm2_slsd_20200305.shp") %>%
  select(ADM2_EN, geometry) # Select the level 2 districts (adm2)
sf_sl_2 <- sf_sl_2 %>% st_transform(5235)
class(sf_sl_2)
sf_sl_2 <- sf_sl_2 %>% 
  mutate(DISTRICT = str_to_upper(ADM2_EN)) %>% 
  select(-ADM2_EN)
save(sf_sl_2, file="data/sf_sl_2.rda", compress='xz')
ggplot(sf_sl_2) + 
  geom_sf() 

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

