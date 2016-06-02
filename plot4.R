#Plot4

setwd("F:/CM-Groep/Cursussen/Data science/04_ExploratoryAnalysis/Week1/")

# Download, unzip and read data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header=T, sep=";")
unlink(temp)

# Data manipulation
data$Date_n <- as.Date(data$Date, "%d/%m/%Y") 
subset_data <- subset(data, data$Date_n == "2007-02-01" | data$Date_n == "2007-02-02")
subset_data$Date_Time <- paste(subset_data$Date, subset_data$Time)
subset_data$Date_Time_n <- strptime(subset_data$Date_Time, "%d/%m/%Y %H:%M:%S")
subset_data$Global_active_power_n <- as.numeric(subset_data$Global_active_power) / 1000
subset_data$Global_reactive_power_n <- as.numeric(subset_data$Global_reactive_power) / 1000
subset_data$Voltage_n <- as.numeric(subset_data$Voltage) / 1000

# Make plot
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(subset_data$Date_Time_n,subset_data$Global_active_power_n,type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(subset_data$Date_Time_n,subset_data$Voltage,type="l", ylab="Voltage", xlab="")
plot(subset_data$Date_Time_n,subset_data$Sub_metering_1,type="l", ylab="Energy sub metering", xlab="")
lines(subset_data$Date_Time_n,subset_data$Sub_metering_2,col="red")
lines(subset_data$Date_Time_n,subset_data$Sub_metering_3,col="blue")
legend("topright", col = c("black","blue", "red"),lty=1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(subset_data$Date_Time_n,subset_data$Global_reactive_power_n,type="l", ylab="Global_reactive_power", xlab="")
dev.copy(png,'plot4.png')
dev.off()

