#Plot3

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

# Make plot
plot(subset_data$Date_Time_n,subset_data$Sub_metering_1,type="l", ylab="Energy sub metering", xlab="")
lines(subset_data$Date_Time_n,subset_data$Sub_metering_2,col="red")
lines(subset_data$Date_Time_n,subset_data$Sub_metering_3,col="blue")
legend("topright", col = c("black","blue", "red"),lty=1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,'plot3.png')
dev.off()