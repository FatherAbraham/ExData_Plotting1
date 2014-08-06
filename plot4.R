##This script written by Father Abraham.
## should this be require?
require(sqdlf)

##set path to local directory using setwd(), then put this file in a function
##OR set full path in fn
fn <- "household_power_consumption.txt"

##read in with a quasi SQL function, so the data is already subsetted (bonus for performance!)
hpc_data <- read.csv.sql(fn, sep=";",sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"')

##fix the date & time so we can work with it.
hpc_data$dt <- paste(hpc_data$Date, hpc_data$Time, sep = " ")
hpc_data$dt <- strptime(hpc_data$dt, format="%d/%m/%Y %H:%M:%S")

##create the Png file
png(filename="plot4.png", 
    units="px", 
    width=480, 
    height=480, 
    pointsize=12, 
    res=72)

##plot 4
##partition the screen

par(mfrow=c(2,2))

##Plot 4a
##doesn't scale though
plot(hpc_data$dt, hpc_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")


##Plot 4b
plot(hpc_data$dt, hpc_data$Voltage, type = "l", xlab = "", ylab = "Voltage")


##Plot 4c
plot(hpc_data$dt, hpc_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(hpc_data$dt, hpc_data$Sub_metering_2, col ="red")
lines(hpc_data$dt, hpc_data$Sub_metering_3, col ="blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty =1:1, col = c("black", "red", "blue"), cex=0.5)

##Plot 4d
plot(hpc_data$dt, hpc_data$Global_reactive_power, type = "l", xlab = "", ylab = "Global reactive power")

##finish writing to the device
dev.off()

