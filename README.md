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

At current state, there are just two functions in this package. The first fuenction initializes with the Dataverse and pulls in the translation table. The second merges that translation table to your dataframe.

1. Initialize with Dataverse. When prompted, input your API token from Dataverse. Store the returned values in a object of your choosing. In this example, I'm storing the data in an object called `mapping`.

```r
mapping <- dvinit()
```

2. Let's create a pretend dataset with some random zip codes:

```r
sample_zips <- c("32180","59430","38281","12937","3043","05061","32505") %>% enframe()
```

3. Use `zip2dma()` to left join the object created in step 1 (`mapping`) to your dataset (`sample_zips`). Note that you'll have to define the column of your dataset that holds the zip codes. In our case, column `value` in `sample_zips` is the column with zipcodes.

```
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

Future Sprint Log
-----

1. Currently, the source dataframe is matched exactly and therefore, zipcodes with leading zeros will not have a match (see obs 3 in the example above). This is something I intend to fix in a future state, however at this time I suggest using the `zipcode` package available on CRAN to circumvent this issue.

2. Additional joins. In my immediate use-case (the reason why I wrote this package), the only join I would ever need was a left join. To make this more universal, I think implementing additional options for other joins should be preferable.

3. Optimize the way the package stores API tokens.
