\name{zip2dma}
\alias{zip2dma}
\title{Merges DMA information to target dataset}
\usage{
zip2dma(dataframe,dvdata,zip_col)
}
\arguments{
\item{dataframe}{The user's dataframe.}
\item{dvdata}{The dataframe with the stored information from Dataverse.}
\item{zip_col}{The column in the user's dataframe that has zip codes.}
}
\description{
A simple left merge process to join the data pulled from Dataverse to the user's dataset.
}
\examples{
\dontrun{
sample_zips <- c("32180","59430","38281","12937","3043","05061","32505") %>% enframe()
sample_zips %>% zip2dma(dvdata=mapping, zip_col = "value")
}
}
