library(ggplot2)

## Set working directory
setwd("Golden Ticket/Coursera/Data Science Specialization/Exploratory Data Analysis/Week 4/Programming Assignment/")

## Download data if it does not already exists
if(!file.exists("./data")) {dir.create("./data")}

filename <- "data/NEI_data.zip"

## Download and unzip the dataset
if (!file.exists(filename)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL, destfile = filename)
}
if (!file.exists("data/summarySCC_PM25.rds")) {
    unzip(filename, exdir = "./data")
}

## Read in data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Merge the NEI and SCC datasets (takes awhile to load)
if (!exists("NEISCC")) {
    NEISCC <- merge(NEI, SCC, by="SCC")
}

## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los 
## Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD", ]

totalByYearOnRoadAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)

## Add friendly name for fips
totalByYearOnRoadAndFips$fips[totalByYearOnRoadAndFips$fips=="24510"] <- "Baltimore City, MD"
totalByYearOnRoadAndFips$fips[totalByYearOnRoadAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width = 800, height = 480)
g <- ggplot(totalByYearOnRoadAndFips, aes(factor(year), Emissions))
g + facet_grid(.~fips) +
    geom_bar(stat="identity") +
    labs(x = "Years", y = expression("Total PM"[2.5]*" Emissions")) +
    labs(title = "Total Emissions from Motor Vehicles in Baltimore City and Los Angeles from 1999 to 2008")
dev.off()

