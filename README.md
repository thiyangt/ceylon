
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ceylon

<!-- badges: start -->

<!-- badges: end -->

The goal of ceylon is to plot maps of Sri Lanka.

## Installation

You can install the released version of ceylon from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("ceylon")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("thiyangt/ceylon")
```

## Example

This is a basic example which shows you how to solve a common problem:

### 0\. Country level

``` r
library(ceylon)
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
#> ✓ tibble  3.0.5     ✓ dplyr   1.0.3
#> ✓ tidyr   1.1.2     ✓ stringr 1.4.0
#> ✓ readr   1.3.1     ✓ forcats 0.5.0
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
library(sp)
data(sf_sl_0)
ggplot(sf_sl_0) + geom_sf()
```

<img src="man/figures/README-example-1.png" width="100%" />

### 1\. Province level

``` r
data(sf_sl_1)
sf_sl_1
#> Simple feature collection with 9 features and 1 field
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: 362203.3 ymin: 380301.9 xmax: 621918.1 ymax: 813560.9
#> projected CRS:  SLD99 / Sri Lanka Grid 1999
#> # A tibble: 9 x 2
#>                                                             geometry PROVINCE   
#>                                                   <MULTIPOLYGON [m]> <chr>      
#> 1 (((498211.2 611042.6, 498401.7 610897.1, 498415.9 610886.3, 49862… CENTRAL    
#> 2 (((609877 559315.9, 609857.5 559313, 609845.2 559319.5, 609838.7 … EASTERN    
#> 3 (((501928.5 712099.6, 501970.4 712098.8, 502020 712108.4, 502064.… NORTH CENT…
#> 4 (((393087.5 629959, 393098.1 629956.7, 393103.2 629956.7, 393108.… NORTH WEST…
#> 5 (((405858.7 700083.7, 405855.3 700082, 405851.5 700082.9, 405800.… NORTHERN   
#> 6 (((432117.3 521875.5, 432083.5 521852.9, 432041.7 521860.8, 43204… SABARAGAMU…
#> 7 (((481925.5 381353.7, 481922.9 381350.3, 481919 381348.2, 481914.… SOUTHERN   
#> 8 (((522825 568220.9, 522872.6 568217.7, 522926.1 568222.5, 523017.… UVA        
#> 9 (((411888.2 438189.4, 411886.4 438182.3, 411881.7 438182.2, 41187… WESTERN
ggplot(sf_sl_1) + geom_sf(mapping = aes(fill = PROVINCE), show.legend = TRUE)
```

<img src="man/figures/README-example1-1.png" width="100%" />

### 2\. District level

``` r
data(sf_sl_2)
ggplot(sf_sl_2) + geom_sf(mapping = aes(fill = DISTRICT), show.legend = FALSE)
```

<img src="man/figures/README-example2-1.png" width="100%" />

### 3\. Divisional secretariat

``` r
data(sf_sl_3)
ggplot(sf_sl_3) + geom_sf()
```

<img src="man/figures/README-example3-1.png" width="100%" />
