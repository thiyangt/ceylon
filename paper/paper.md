---
title: 'ceylon: An R package for plotting the maps of Sri Lanka'
tags:
- R
- maps
- shape files
- spatial mapping
- CRS
date: "26 December 2023"
output: pdf_document
authors:
- name: Thiyanga S. Talagala
  orcid: "0000-0002-0656-9789"
  affiliation: '1'
bibliography: paper.bib
affiliations:
- name: Department of Biostatistics, Harvard School of Public Health
  index: 1
---

# Summary

The rapid evolution in the fields of computer science, data science, and artificial intelligence has significantly transformed the utilisation of data for decision-making. Data visualisation plays a critical role in any work that involves data. Visualising data on maps is frequently encountered in many fields. Visualising data on maps not only transforms raw data into visually comprehensible representations but also converts complex spatial information into simple, understandable form. Locating the data files necessary for map creation can be a challenging task. Establishing a centralised repository can alleviate the challenging task of finding shape files, allowing users to efficiently discover geographic data. The ceylon [@talagala2023ceylon] R package is designed to make simple feature data related to Sri Lanka's administrative boundaries and rivers and streams accessible for a diverse range of R [@team2023r] users. With straightforward functionalities, this package allows users to quickly plot and explore administrative boundaries and rivers and streams in Sri Lanka.




# Statement of Need

The `ceylon` R package conveniently packages shape files corresponding to the geographic features of Sri Lanka, enhancing user friendliness for seamless integration and analysis. This allows for minimising the time spent on data searching and cleaning efforts. Hence, the package ceylon stands out as a catalyst for research efficiency. Furthermore, the package supports research reproducibility, allowing others to independently verify and build upon the work that utilised the data in this package. The data format easily integrates with tidyverse packages [@wickham2019welcome], fostering a smooth workflow.


# Datasets Available in the Package

The data were retrieved from the   @humdata. The Humanitarian Data Exchange is a platform that facilitates the sharing and collaboration of humanitarian data. The coordinate reference system (CRS) for the data is "Projected CRS: SLD99 / Sri Lanka Grid 1999 (CRS code 5234)". Table 1 provides a description of datasets.

| dataset  | description  |  data source  |
|---|---|---|
| sf_sl_0  |  country boundary | https://data.humdata.org/    |
|province   | province boundaries  | https://data.humdata.org/   |
|district   | district boundaries  | https://data.humdata.org/   |
|sf_sl_3   | divisional secretariat boundaries | https://data.humdata.org/   |
|rivers  |Sri Lanka rivers and streams shapefiles  | https://data.humdata.org/   |



Table 1: Description of data in the pacakge

# Usage



`ceylon` is available on [GitHub](https://github.com/thiyangt/ceylon), and can be installed and loaded into the R session using:

```r
install.packages("devtools")
devtools::install_github("thiyangt/ceylon")
library(ceylon)
```



The additional packages required for plotting are as follows:

```r
library(ggplot2)
library(sp)
library(sf)
library(viridis)
library(patchwork)
```

The package ggplot2 [@wickham2016ggplot2] is used for data visualization. The sp [@pebesma2005classes] provides tools for handling spatial data. The sf simple features [@pebesma2018simple]  builds upon the strengths of the sp package, introducing  efficient approach to handling spatial data. The viridis [@r2023viridis] package provides a collection of color palettes that are color blind friendly. The patchwork [@pedersen2023patchwork] package is used for the combination and arrangement of multiple plots. Figure 1 shows the visualizations of  Sri Lanka's administrative borders based on data available in the `ceylon` package. The codes to produce Figure 1 is given below.

```r
data(sf_sl_0)
a <- ggplot(sf_sl_0) + geom_sf() + ggtitle ("a: Country")
data(province)
b <- ggplot(province) + geom_sf() + ggtitle("b: Province")
data(district)
c <- ggplot(district) + geom_sf() + ggtitle("c: District")
data(sf_sl_3)
d <- ggplot(sf_sl_3) + geom_sf() + ggtitle("d: Divisional Secretariat")
(a|b|c|d)
```

![Maps of differnt administrative divisions in Sri Lanka \label{fig:img1}](Rplot1.png)



## Point Map: Adding a point to the map

The Global Positioning System (GPS) coordinates of Bandaranaike International Airport, Sri Lanka is Latitude: 7.1753 Longitude: 79.8835. The goal is to plot this point along with the province boundaries. The EPSG:4326 geographic CRS system gives latitude and longitude coordinates to specify a location on the surface of the earth. Hence, before plotting, first longitude and latitudes should be converted into sf object to the same coordinate reference system as the province data set. For this the sp [@pebesma2005classes] and sf [@pebesma2018simple] packages in R were used. In the following code `st_as_sf` specify the current coordinate reference system for longitude and latitude. The function `st_transform` converts the current CRS to the target CRS. The target CRS is the CRS associated with the province, which is defined as `crs = st_crs(province)` inside the'st_transform' function.

```r
airport <- data.frame(lng = 79.8835, lat = 7.1753)
airport.new <- airport |>
  st_as_sf(coords = c("lng", "lat"), crs = 4326) |>
  st_transform(crs = st_crs(province))
```

```r
point <- ggplot(province) + 
  geom_sf() + geom_sf(data = airport.new, size = 2, col = "darkred") + 
  ggtitle("a: Point")
```

## Line Map: Plot rivers and streams in Sri Lanka

This section illustrates an example of using the rivers dataset in the package ceylon.

```r
data("rivers")
line <- ggplot(data = sf_sl_0) +
  geom_sf(fill="#edf8b1", color="#AAAAAA") +
  geom_sf(data=rivers, colour="#253494") +
  labs(title =  "b: Line")
```

## Polygon Map: Creating a choropleth map

A Choropleth map shows different regions coloured according to the numerical values associated with each individual region.

```r
polygon <- ggplot(province) + 
  geom_sf(mapping = aes(fill = population)) + scale_fill_viridis() + 
  ggtitle("c: Polygon")
```

```r
(point|line|polygon)
```

Figure 2 shows the above point, line, and polygon maps created using the data available in the `ceylon` package.



![Illustration of point, line and polygon map  \label{fig: img2}](Rplot2.png)

The above examples illustrate the datasets available in the package, which are easily integrated with other companion packages that are widely used in spatial analysis and data visualisation.



# Acknowledgements

We extend our sincere gratitude to Stephanie Kobakian for her enlightening talk at the R-Ladies Colombo meetup. This package owes its inspiration to the valuable insights shared during Stephanie's presentation

# References
