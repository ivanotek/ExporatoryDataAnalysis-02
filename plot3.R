#################################################################################################
## Peer-graded Assignment: Course Project 2
## Course Project for Exploratory Data Analysis - Week 4
##
## plot3.R answers the following question
##  Q3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
##      variable, which of these four sources have seen decreases in emissions from 1999–2008 for
##      Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 
##      plotting system to make a plot answer this question.
##
## For that purpose, it does
## (0) downloads and reloads data if required
## (1) Aggregate tons of emissions by year and type in Baltimore(MD), and convert aggregation dims to factor
## (2) Generate a bar plot of yearly aggregates faceted by type into plot3.png
#################################################################################################

# /0/
source('download.R')
library(ggplot2)

# /1/ Aggregate tons of emissions by year/type in Baltimore(MD), and convert aggregation dims to factor
NEIinBA <- subset(NEI, fips == '24510')
NEIinBA$year <- factor(NEIinBA$year, levels=unique(NEIinBA$year))
NEIinBA$type <- factor(NEIinBA$type, levels=unique(NEIinBA$type))
EmissionsInBA <- aggregate(Emissions ~ type + year, NEIinBA, sum)

# /2/ Generate the graph
png(filename='plot3.png', width=800, height=600, units='px')

g <- ggplot(EmissionsInBA, aes(x=year, y=Emissions)) + 
      facet_grid(. ~ type) + 
      geom_bar(stat='identity', aes(fill = type)) +
      ggtitle(expression('Baltimore City (MD) Total Emissions of PM'[2.5])) +
      ylab('Tons') +
      xlab('Year') 
      
print(g)

dev.off()
