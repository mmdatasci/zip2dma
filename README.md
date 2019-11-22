# zip2dma

This package is the rudamentary **first version** of a package allowing users to quickly join DMA information to any data containing zip codes:


Installation
-----------

```
library(devtools)
install_github("mmdatasci/zip2dma")
```

Note: This package requires you to use an API token from https://dataverse.harvard.edu/ - you can obtain one by signing up for Dataverse and requesting one.


Usage
-----

At current state, there are just two functions in this package. The first function initializes with the Dataverse and pulls in the translation table. The second merges that translation table to your dataframe.

1. Initialize with Dataverse

```r
mapping <- dvinit()
```

2. Join Data with zip2dma(). 

```r
sample_zips <- c("32180","59430","38281","12937","3043","05061","32505") %>% enframe()

sample_zips %>% zip2dma(dvdata=mapping, zip_col = "value")

>   value name  FIPS       COUNTY   ST DMA.CODE                          DMA.NAME
> 1 05061    6  <NA>         <NA> <NA>     <NA>                              <NA>
> 2 12937    4 36033     Franklin   NY      523            BURLINGTON-PLATTSBURGH
> 3  3043    5 33011 Hillsborough   NH      506                            BOSTON
> 4 32180    1 12127      Volusia   FL      534   ORLANDO-DAYTONA BEACH-MELBOURNE
> 5 32505    7 12033     Escambia   FL      686                  MOBILE-PENSACOLA
> 6 38281    3 47131        Obion   TN      632 PADUCAH-CAPE GIRARDEAU-HARRISBURG
> 7 59430    2 30027       Fergus   MT      755                       GREAT FALLS

```

Note that the source data is currently untouched and therefore, zipcodes without leading 0 will not have a match (see obs 3). This is something I intend to fix in a future state, however at this time I suggest using the `zipcode` package available on CRAN.
