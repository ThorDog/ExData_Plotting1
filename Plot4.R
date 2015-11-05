# This script creates a Plot4.png file from the Electric Power Consumption dataset.
# The dataset is stored in the household_power_consumption.txt file. 
# This dataset is available as a zip file from:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# To run this script, the unzipped household_power_consumption.txt file must be 
# present in your working directory.

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

# Setup the canvas to display 4 plots in a 2x2 grid
par(mfrow = c(2,2), pin = c(5,5), mar = c(4.5,4.5,2,2))
# Create the upper left plot - Global Active Powewr vs time
plot(power_consump$date_time, power_consump$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Create the upper right plot - Voltage vs Time
plot(power_consump$date_time, power_consump$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Create the lower left plot - Sub Metering
plot(power_consump$date_time, power_consump$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
points(power_consump$date_time, power_consump$Sub_metering_2, type = "l", col = "red")
points(power_consump$date_time, power_consump$Sub_metering_3, type = "l", col = "blue")

# Add the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1,1,1),
       cex = 0.5, text.width = strwidth("Sub_metering_1 "), y.intersp = 0.5, bty = "n" )

# Create the lower right plot - Global Reactive Power vs time
plot(power_consump$date_time, power_consump$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Copy the plot to a PNG file
dev.copy(png, file = "Plot4.png")
dev.off()
