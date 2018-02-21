#Load Sequence R for Data set

#Load Chron package for time conversion
if (!require(chron)) {
  install.packages("chron")
  library(chron)
}

#Load data into pw1 and import all as text fields
pw1 <- read.csv2("household_power_consumption.txt")
pw1 <- data.frame(lapply(pw1 , as.character), stringsAsFactors=FALSE)

#convert fields from factors to proper data types
#rely on coercion with numeric conversion to convert non-numeric
#fields to NA
pw1$Date <- as.Date(pw1$Date,format = "%d/%m/%Y")
pw1$Time <- times(pw1$Time)
pw1$Global_active_power   <- as.numeric(as.character(pw1$Global_active_power  ))
pw1$Global_reactive_power <- as.numeric(as.character(pw1$Global_reactive_power))
pw1$Voltage <- as.numeric(as.character(pw1$Voltage))
pw1$Global_intensity <- as.numeric(as.character(pw1$Global_intensity))
pw1$Sub_metering_1 <- as.numeric(as.character(pw1$Sub_metering_1))
pw1$Sub_metering_2 <- as.numeric(as.character(pw1$Sub_metering_2))
pw1$Sub_metering_3 <- as.numeric(as.character(pw1$Sub_metering_3))

#create full date and time field
pw1$FullDate <- as.POSIXct(paste(pw1$Date, pw1$Time), format="%Y-%m-%d %H:%M:%S")

#subset data for selected dates into pw2
pw2 <- pw1[pw1$Date >= "2007-02-01" & pw1$Date <= "2007-02-02",]

#set grid to 1 x 1
par(mfrow=c(1,1))

#plot 2
plot(pw2$FullDate,pw2$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type = "l")
png("Plot_2.png", width = 480, height = 480)
plot(pw2$FullDate,pw2$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type = "l")
dev.off()