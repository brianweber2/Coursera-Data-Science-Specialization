## Exploratory Data Analysis
## Week 1 Project

## Read in data set
#
# 2,075,259 rows and 9 columns of data; rough estimate
# of memory required is Nrow x Ncol x 8 bytes/numeric
# 2,075,259 x 9 x 8 bytes/numeric
# = 149418648 bytes / 2^20 bytes/MB
# 142.5 MB or 0.1425 GB

# Only read the dates we are interested in
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                   skip = 66636, nrows = 2880, col.names = c("Date","Time","Global Active Power",
                                                             "Global Reactive Power", "Voltage",
                                                             "Global Intensity", "Sub Metering 1",
                                                             "Sub Metering 2", "Sub Metering 3"))

# Read the in all data and subset the data to find the dates we want (slower)
# data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
# dataSubset <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Convert date column to date class and time column to time class
datetime <- strptime(paste(data$Date, data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

# Make sure to convert Global Active Power to numeric if it is not already
globalActivePower <- as.numeric(data$Global.Active.Power)

# Graph plot2 and save to a png file
png("plot2.png", width = 480, height = 480)
plot(datetime, globalActivePower, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
dev.off()


