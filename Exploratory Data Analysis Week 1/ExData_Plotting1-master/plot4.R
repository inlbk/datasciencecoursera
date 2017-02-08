# Exploratory Data Analysis - Week 1 Plot 4

# Load packages
# No packages needed - only the base graphics functions are used.

# Clean the environment.
remove(list=ls())

# Check which directory you are in and use setwd() and dir() as needed to 
# navigate to the directory you wish to work in.
getwd()

# The data is located at the following URL
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the zip file
temp <- tempfile()            # Create a temporary file into which to download
download.file(fileUrl, temp)  # Download the zip file into the temporary file
dateDownloaded <- date()      # Record the date and time of the download 
unzip(temp, list = TRUE)      # Return a list of file names in the zip file

# Specify column names
columns <- c("Date","Time","Global_active_power","Global_reactive_power",
             "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
             "Sub_metering_3")

# Unzip the zip file and extract the relevant lines of the file
Febdata <- read.table(unzip(temp,"household_power_consumption.txt"), 
                      skip=66637, nrows=2880, header=FALSE, sep = ";", 
                      col.names = columns, na.strings="?")

# Remove the downloaded zip file after the relevant data file is extracted
unlink(temp)

# Convert date and time variables to date/time classes in R
Febdata$DateTime <- as.POSIXct(paste(Febdata$Date, Febdata$Time), 
                               format="%d/%m/%Y %H:%M:%S")

# Open PNG device; create 'plot3.png' in working directory
png(filename = "plot4.png", width = 480, height = 480)

# Set graphics parameters
par(mfrow = c(2,2), oma = c(1,1,.5,1.5), pty="m")

# Create first plot
plot(Febdata$DateTime,Febdata$Global_active_power, type = "l", 
     xlab="",ylab="Global Active Power")

# Create second plot
plot(Febdata$DateTime,Febdata$Voltage, type = "l", 
     xlab="datetime",ylab="Voltage")

# Create third plot
plot(Febdata$DateTime, Febdata$Sub_metering_1, 
     xlab = "", ylab = "Energy sub metering", type = "n")
lines(Febdata$DateTime, Febdata$Sub_metering_1, type = "l", col="black")
lines(Febdata$DateTime, Febdata$Sub_metering_2, type = "l", col="red")
lines(Febdata$DateTime, Febdata$Sub_metering_3, type = "l", col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),cex=.9, bty="n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create fourth plot
plot(Febdata$DateTime,Febdata$Global_reactive_power, type = "l", 
     xlab="datetime",ylab="Global_reactive_power")

# Close the file device
dev.off()  

# You can now view the file 'plot4.png' on your computer.