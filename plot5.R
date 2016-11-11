#################################################################################################
## Peer-graded Assignment: Course Project 2
## Course Project for Exploratory Data Analysis - Week 4
##
## plot5.R answers the following question
##  Q5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
##
## For that purpose, it does
## (0) downloads and reloads data if required
## (1) selects from measurement sources SCC the ones related to motor vehicle emissions from Baltimore
## (2) aggregates motor vehicle realted emission data per year
## (3) Generate a bar plot of motor vehicle related yearly emission aggregates into plot5.png
#################################################################################################

# /0/
source('download.R')
library(ggplot2)

# /1/ subsetting SCC by motor vehicle related sources
mmotor <- grepl("vehicle", SCC$Short.Name, ignore.case=TRUE)
motorRelated <- SCC[mmotor, ]

# /2/ pick dataframes
motorNEIinBA <- subset(NEI, fips == '24510' & SCC %in% motorRelated$SCC)
#    Aggregate tons of emissions from motor-related sources by year in Baltimore
motorEmissionsInBA <- aggregate(Emissions ~ year, motorNEIinBA, sum)
motorEmissionsInBA$year <- factor(motorEmissionsInBA$year, levels = unique(motorEmissionsInBA$year))

# /3/ Generate the graph
png(filename='plot5.png', width=800, height=600, units='px')

g <- ggplot(motorEmissionsInBA, aes(x=year, y=Emissions)) + 
      guides(fill=FALSE) +
      geom_bar(stat='identity', aes(fill=year)) +
      geom_text(aes(label=round(Emissions,2), size=1, hjust=0.5, vjust=-0.5)) + 
      ggtitle(expression(paste('Total Emissions of PM'[2.5], " from Motor Vehicle Sources in Baltimore(MD)"))) +
      theme(legend.position = 'none') +
      ylab('Tons') +
      xlab('Year') 
      
print(g)

dev.off()
