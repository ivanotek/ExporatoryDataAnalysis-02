#################################################################################################
## Peer-graded Assignment: Course Project 2
## Course Project for Exploratory Data Analysis - Week 4
##
## plot2.R answers the following question
##  Q2: Have total emissions from $PM_{2.5}$ decreased in the Baltimore City, Maryland 
##      (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering 
##      this question.
##
## For that purpose, it does
## (0) downloads and reloads data if required
## (1) Aggregate tons of emissions by year in Baltimore(MD)
## (2) Generate a bar plot of yearly aggreagates into plot2.png
#################################################################################################

# /0/
source('download.R')

# /1/ Aggregate tons of emissions by year in Baltimore
NEIinBA <- subset(NEI, fips == '24510')
EmissionsInBA <- aggregate(Emissions ~ year, NEIinBA, sum)

# /2/ Generate the graph
png(filename='plot2.png', width=800, height=600, units='px')

barplot(EmissionsInBA$Emissions, names.arg=EmissionsInBA$year,
        main = expression('Baltimore City (MD) Total Emissions of PM'[2.5]),
        col = c('#280353'),
        xlab = 'Year', 
        ylab = 'Tons')

dev.off()
