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

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

totalByYear <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png")
barplot(height = totalByYear$Emissions, names.arg = totalByYear$year, xlab = "Years", ylab = expression("Total PM"[2.5]*
                                        " Emission"), main = expression("Total PM"[2.5]*" Emissions at Various Years"))
dev.off()
