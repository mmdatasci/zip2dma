
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'


# library(dataverse)




dvinit <- function(){

  # Set Dataverse Server to correct instance
  Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")

  # Check if a token already exists
  if(file.exists("~/.dvtoken")) {
   skip_init <- menu(c("Use existing token", "Enter a new token"), title="An existing Dataverse API token has been located. Would you like to use this token or initialize a new one?")
    if(skip_init == 1) {
      token <- readRDS(file = "~/.dvtoken")
      Sys.setenv("DATAVERSE_KEY" = token)
    }
    else {
      token <- readline("Please enter your Harvard Dataverse API Token:")
      token <- as.vector(token)
      Sys.setenv("DATAVERSE_KEY" = token)
    }
  }

  else {
    # Load Dataverse Credentials
    token <- readline("Please enter your Harvard Dataverse API Token:")
    token <- as.vector(token)
    Sys.setenv("DATAVERSE_KEY" = token)

    # If desired, the token can be stored in a file to circumvent having to run dvinit() multiple times
    storing <- menu(c("Yes", "No"), title="Store this token (Use carefully)?")

    if(storing==1) {

      if(file.exists("~/.dvtoken")) {
        overwrite <- menu(c("Yes", "No"), title="A token is already stored. Overwrite?")

        if(overwrite==1) {

        saveRDS(token, file = "~/.dvtoken")
        print("Your new token has been stored at ~/.dvtoken")

        }
        else {
          print("Your previously stored token will be used.")
        }
      }
      else {
        saveRDS(token, file = "~/.dvtoken")
        print("Your token has been stored at ~/.dvtoken")
      }
    }
  }


  # Get 2008 DMA-Zip Mapping from Harvard Dataverse
  f <- get_file("DMA-zip.tab", "doi:10.7910/DVN/IVXEHT")

  # Load it into memory
  tmp <- tempfile(fileext = ".csv")

  # Write tempfile
  writeBin(as.vector(f), tmp)

  # Read into env
  mapping <- read.csv(tmp, header = TRUE) %>%
    mutate_if(is.integer, as.character)

  # Rm temp file
  file.remove(tmp)

  # Return zip2dma_mapping
  return(mapping)

}



zip2dma <- function(dataframe, dvdata, zip_col){
  merge(dataframe, dvdata, by.x=zip_col, by.y="ZIPCODE", all.x = TRUE)
}




