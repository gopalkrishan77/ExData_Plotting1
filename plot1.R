## load library to use fread function for reading the file
library(data.table)

## read the complete data set. File is in data directory within working folder
data_complete <- fread("./data/household_power_consumption.txt",na.strings="?")

## Convert the Date column to Date datatype for getting subset of data
## Used %Y in format for 4 digit year
data_complete$Date <- as.Date(data_complete$Date, format="%d/%m/%Y")

## subsetting the data between 2007-02-01 and 2007-02-02
## Delete the bigger dataset after subsetting

data <- subset(data_complete, (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_complete)

## Generate the plot 1 - Histogram with Red color and labels

hist(data$Global_active_power, main="Global Active Power", 
	xlab="Global Active Power (kilowatts)", col="Red")

## Copy to png file and save it
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
