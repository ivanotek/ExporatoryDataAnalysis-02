#################################################################################################
## Peer-graded Assignment: Course Project 2
## Course Project for Exploratory Data Analysis - Week 4
##
## download.R does the following.
##
## (0) Checks if ./data directory exists or creates it otherwise
## (1) Downloads the Environmental Protection Agency (EPA) database on emissions of PM2.5, a.k.a. 
##     National Emissions Inventory (NEI), if has not been previously downloaded, and unzips 
##     its contents
## (2) loads the data into the NEI and SCC master data frames, if required
#################################################################################################


#define target directory for dataset download
targetDir <- './data'               
#define dataset download URL
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists(targetDir) ) {
  dir.create(targetDir)
}
if(!file.exists("./data/exdata%2Fdata%2FNEI_data.zip")) {
  message("Downloading data, please be patient...")
  datasetZipFile <-file.path(targetDir, basename(fileURL))
  download.file(fileURL,destfile=datasetZipFile)
  # Unzip dataset to target directory
  unzip(zipfile=datasetZipFile,exdir=targetDir)
}

if(!exists("NEI") || !exists("SCC")) {
  message("Loading data will likely take a few seconds. Be patient!")
  NEI <- readRDS("./data/summarySCC_PM25.rds")
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}