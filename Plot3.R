# This script creates a Plot3.png file from the Electric Power Consumption dataset.
# The dataset is stored in the household_power_consumption.txt file. 
# This dataset is available as a zip file from:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# To run this script, the unzipped household_power_consumption.txt file must be 
# present in your working directory.

# The plot created shows the three different sub-metering variables
# plotted vs time for the dates 2007-02-01 and 2007-02-02

# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
# It corresponds to the kitchen, containing mainly a dishwasher, 
# an oven and a microwave (hot plates are not electric but gas powered).

# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
# It corresponds to the laundry room, containing a washing-machine, 
# a tumble-drier, a refrigerator and a light.

# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
# It corresponds to an electric water-heater and an air-conditioner.

library(dplyr)

# Read in the data
power_consump <- read.csv2("household_power_consumption.txt", na.strings = "?", dec = ".")

# Create a Posix date from the Date string so we can filter on the dates of interest
power_consump$PosDate <- as.Date(power_consump$Date, format = "%d/%m/%Y")

# Filter to keep only the dates of interest
power_consump <- dplyr::filter(power_consump, PosDate == "2007-02-01" | PosDate == "2007-02-02")

# Create a date-time column so that we can plot the x-axis correctly
power_consump$date_time <- paste(as.character(power_consump$Date), as.character(power_consump$Time))
power_consump$date_time <- strptime(power_consump$date_time, format = "%d/%m/%Y %H:%M:%S")

# Create the plot as a line graph with no x axis label
par(mfrow = c(1,1), pin = c(5,5), mar = c(4.5,4.5,2,2))
plot(power_consump$date_time, power_consump$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
points(power_consump$date_time, power_consump$Sub_metering_2, type = "l", col = "red")
points(power_consump$date_time, power_consump$Sub_metering_3, type = "l", col = "blue")

# Add the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                   col = c("black", "red", "blue"),
                   lty = c(1,1,1),
                   cex = 0.5, text.width = strwidth("Sub_metering_1"))

# Copy the plot to a PNG file
dev.copy(png, file = "Plot3.png")
dev.off()
