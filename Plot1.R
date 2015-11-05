# This script creates a Plot1.png file from the Electric Power Consumption dataset.
# The dataset is stored in the household_power_consumption.txt file. 
# This dataset is available as a zip file from:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# To run this script, the unzipped household_power_consumption.txt file must be 
# present in your working directory.

# The plot created is a histogram of the Global Average Power variable

# Global_active_power: household global minute-averaged active power (in kilowatt)

library(dplyr)

# Read in the data
power_consump <- read.csv2("household_power_consumption.txt", na.strings = "?", dec = ".")

# Filter to keep only the dates of interest
power_consump$Date <- as.Date(power_consump$Date, format = "%d/%m/%Y")
power_consump <- dplyr::filter(power_consump, Date == "2007-02-01" | Date == "2007-02-02")

# Create the histogram
par(mfrow = c(1,1), pin = c(5,5), mar = c(4.5,4.5,2,2))
hist(power_consump$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Copy the plot to a PNG file
dev.copy(png, file = "Plot1.png")
dev.off()