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

## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

subsetNEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

totalByYearandOnRoadBaltimore <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot5.png")
g <- ggplot(totalByYearandOnRoadBaltimore, aes(factor(year), Emissions))
g + geom_bar(stat="identity") +
    labs(x = "Years", y = expression("Total PM"[2.5]*" Emissions")) +
    labs(title = "Total Emissions from Motor Vehicles in Baltimore City from 1999 to 2008")
dev.off()

