#################################################################################################
## Peer-graded Assignment: Course Project 2
## Course Project for Exploratory Data Analysis - Week 4
##
## plot1.R answers the following question
##  Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##      Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##      sources for each of the years 1999, 2002, 2005, and 2008.
##
## For that purpose, it does
## (0) downloads and reloads data if required
## (1) Aggregate tons of emissions by year, and convert to PM_KT (KiloTons)
## (2) Generate a bar plot of yearly aggreagates into plot1.png
#################################################################################################

# /0/
source('download.R')

# /1/ Aggregate tons of emissions by year, and convert to PM_KT (KiloTons)
Emissions <- aggregate(Emissions ~ year, NEI, sum)
Emissions$PM_KT <- Emissions[,2]/1000

# /2/ Generate the graph
png(filename='plot1.png', width=800, height=600, units='px')

barplot(Emissions$PM_KT, names.arg=Emissions$year, 
        main = expression('Total Emissions of PM'[2.5]),
        col = c('#F15854'),
        xlab = 'Year', 
        ylab = 'KiloTons')

dev.off()
