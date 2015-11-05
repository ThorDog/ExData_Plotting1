# This script creates a Plot2.png file from the Electric Power Consumption dataset.
# The dataset is stored in the household_power_consumption.txt file. 
# This dataset is available as a zip file from:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# To run this script, the unzipped household_power_consumption.txt file must be 
# present in your working directory.

# The plot created shows the Global Average Power variable
# plotted vs time for the dates 2007-02-01 and 2007-02-02

# Global_active_power: household global minute-averaged active power (in kilowatt)

library(dplyr)

# Read in the data
power_consump <- read.csv2("household_power_consumption.txt", na.strings = "?", dec = ".")

# Create a Posix date from the Date string so we can filter
power_consump$PosDate <- as.Date(power_consump$Date, format = "%d/%m/%Y")

# Filter to keep only the dates of interest
power_consump <- dplyr::filter(power_consump, PosDate == "2007-02-01" | PosDate == "2007-02-02")

# Create a date-time column so that we can plot the x-axis correctly
power_consump$date_time <- paste(as.character(power_consump$Date), as.character(power_consump$Time))
power_consump$date_time <- strptime(power_consump$date_time, format = "%d/%m/%Y %H:%M:%S")

# Create the plot as a line graph with no x axis label
par(mfrow = c(1,1), pin = c(5,5), mar = c(4.5,4.5,2,2))
plot(power_consump$date_time, power_consump$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Copy the plot to a PNG file
dev.copy(png, file = "Plot2.png")
dev.off()