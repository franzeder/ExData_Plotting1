# read full dataset
data_full <- read.table("household_power_consumption.txt", header = TRUE, 
                          sep = ";", stringsAsFactors = FALSE)

# subset dataset (observations from 2007-02-01 and 2007-02-02)
data <- subset(data_full, Date %in% c("1/2/2007", "2/2/2007"))

# change local time to US for weekdays in English
Sys.setlocale("LC_ALL", "en_US")

# create new column (date.Time) and convert date and time to POSIXlt
data$date.Time <- paste(data$Date, data$Time, sep = " ")
data$date.Time <- strptime(data$date.Time, format = "%d/%m/%Y %H:%M:%S", tz = "EST")

# convert columns 3 to 9 to numeric
data[, 3:9] <- sapply(data[, 3:9],as.numeric)


# save plot to png file
png("plot4.png", width = 480, height = 480)

# creating matrix (2x2) and fill by rows
par(mfrow=c(2,2))

# topleft
with(data, plot(date.Time, Global_active_power, type = "l",
                xlab = "", ylab = "Global Active Power"))

# topright
with(data, plot(date.Time, Voltage, type = "l",
                xlab = "datetime", ylab = "Voltage"))

# bottomleft
with(data, plot(date.Time, Sub_metering_1, type = "l",
                xlab = "", ylab = "Energy sub metering"))
with(data, lines(date.Time, Sub_metering_2, type = "l", col = "red"))
with(data, lines(date.Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, lwd = 1,  col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# bottomright
with(data, plot(date.Time, Global_reactive_power, type = "l",
                xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
