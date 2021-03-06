# Load package required
library(dplyr)

# Set working directory
setwd("C:/Users/jfku/Documents")

# Unzip the downloaded file and store the unzipped file in specific folder
unzip("C:/Users/jfku/Documents/exdata_data_household_power_consumption.zip",exdir = "data_household_power_consumption")

# Read data into R
data <- read.table("data_household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

# reformat the columns with dates (character) to Date format
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

# Make new column with concatenation of Date & Time 
data$DateTime <- paste(data$Date, data$Time, sep = " ")

# Format new DateTime column 
data$DateTime <- strptime(data$DateTime, format="%Y-%m-%d %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

# subset with only data from the two dates in Feb 2007
data_feb <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Make plot2 and print it as png file with 480*480 format
png("plot2.png", 480, 480)
plot2 <- plot(data_feb$DateTime, data_feb$Global_active_power, type = "l", ylab = "Global Active Power (Kilowatts)"
              ,xlab = " ",xaxt=weekdays(data_feb$Date))
dev.off()