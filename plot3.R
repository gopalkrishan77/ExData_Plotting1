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

## Add new column DateTime to data which is combination of Date and Time column
## Paste function converts to char and then joins them with space in between
## data.table allows addition of new column as a calculated column
## Then convert it using as.POSIXct function to be able to use in plot

data[,DateTime:=paste(data$Date,data$Time)]
data$DateTime <- as.POSIXct(data$DateTime)

## Generate the plot 3 - Base plot with submetering 1 and then
## add 2 lines for submetering 2 and 3. Add Legend after that.

with(data, {
	plot(Sub_metering_1~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
	lines(Sub_metering_2~DateTime, col="Red")
	lines(Sub_metering_3~DateTime, col="Blue")
		}
	)
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))



## Copy to png file and save it
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
