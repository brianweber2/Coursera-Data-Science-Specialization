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

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four 
## sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions 
## from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

subsetBalitmoreNEI <- NEI[NEI$fips == "24510", ]

totalByYearandType <- aggregate(Emissions ~ year + type, subsetBalitmoreNEI, sum)

png("plot3.png")
g <- ggplot(totalByYearandType, aes(year, Emissions, color = type))
g + geom_line() +
    labs(x = "Years", y = expression("Total PM"[2.5]*" Emissions")) +
    labs(title = expression("Total PM"[2.5]*" Emissions in Balitmore City from 1999 to 2008"))
dev.off()

