#################################################################################################
## Peer-graded Assignment: Course Project 2
## Course Project for Exploratory Data Analysis - Week 4
##
## plot4.R answers the following question
##  Q4: Across the United States, how have emissions from coal combustion-related sources changed 
##      from 1999–2008?
##
## For that purpose, it does
## (0) downloads and reloads data if required
## (1) selects from measurement sources SCC the ones related to coal emissions
## (2) aggregates coal-realted emission data per year and convert values to KiloTons
## (3) Generate a bar plot of coal-related yearly emission aggregates into plot4.png
#################################################################################################

# /0/
source('download.R')
library(ggplot2)

# /1/ subsetting SCC by coal related sources
mcoal  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
coalRelated <- SCC[mcoal, ]

# /2/ pick dataframes
coalNEI <- subset(NEI, SCC %in% coalRelated$SCC)

#     aggregating coal-realted emission data per year, in KiloTons
coalEmissions <- aggregate(Emissions ~ year, coalNEI, sum)
coalEmissions$PM_KT <- round(coalEmissions$Emissions / 1000.0, 2)
coalEmissions$year <- factor(coalEmissions$year, levels = unique(coalEmissions$year))

# /3/ Generate the graph
png(filename='plot4.png', width=800, height=600, units='px')

g <- ggplot(coalEmissions, aes(x=year, y=PM_KT)) +
      guides(fill=FALSE) +
      geom_bar(stat='identity', aes(fill=year)) +
      geom_text(aes(label=PM_KT), size=4, hjust=0.5, vjust=-0.5) + 
      ggtitle(expression(paste('Total Emissions of PM'[2.5], " from Coal Sources"))) +
      ylab('KiloTons') +
      xlab('Year') 
      
print(g)

dev.off()
