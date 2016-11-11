#################################################################################################
## Peer-graded Assignment: Course Project 2
## Course Project for Exploratory Data Analysis - Week 4
##
## plot5.R answers the following question
##  Q6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
##      vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
##      greater changes over time in motor vehicle emissions?
##
## For that purpose, it does
## (0) downloads and reloads data if required
## (1) selects from measurement sources SCC the ones related to motor vehicle emissions from LA 
##     and Baltimore
## (2) aggregates motor vehicle realted emission data per year / city
## (3) Generate a bar plot of motor vehicle related yearly emission aggregates into plot6.png
#################################################################################################

# /0/
source('download.R')
library(ggplot2)

# /1/ subsetting SCC by motor vehicle related sources
mmotor <- grepl("vehicle", SCC$Short.Name, ignore.case=TRUE)
motorRelated <- SCC[mmotor, ]

# /2/ pick dataframes
motorNEIinLABA <- subset(NEI, (SCC %in% motorRelated$SCC) & (fips %in% c('24510','06037')))
#    Aggregate tons of emissions from motor vehicle related sources by year in Baltimore
motorEmissionsInLABA <- aggregate(Emissions ~ fips + year, motorNEIinLABA, sum)
motorEmissionsInLABA$city <- factor(motorEmissionsInLABA$fips, 
                                    levels = c('24510','06037'), 
                                    labels = c('Baltimore', 'Los Angeles'))
motorEmissionsInLABA$year <- factor(motorEmissionsInLABA$year, levels = unique(motorEmissionsInLABA$year))

# /3/ Generate the graph
png(filename='plot6.png', width=800, height=600, units='px')

g <- ggplot(data=motorEmissionsInLABA, aes(x=year, y=Emissions, group=city, color=city)) + 
      geom_line() +
      geom_point() +
      geom_text(aes(label=round(Emissions,2), vjust=-0.5)) +
      ggtitle(expression(paste('Total Emissions of PM'[2.5], " from Motor Vehicle Sources"))) +
      ylab('Tons') +
      xlab('Year') 
     
print(g)

dev.off()
