# read full dataset
data_full <- read.table("household_power_consumption.txt", header = TRUE, 
                          sep =";", stringsAsFactors = FALSE)

# subset dataset (observations from 2007-02-01 and 2007-02-02)
data <- subset(data_full, Date %in% c("1/2/2007", "2/2/2007"))

# change local time to US for weekdays in English
Sys.setlocale("LC_ALL", "en_US")

# create new column (date.Time) and convert date and time to POSIXlt
data$date.Time <- paste(data$Date, data$Time, sep = " ")
data$date.Time <- strptime(data$date.Time, format = "%d/%m/%Y %H:%M:%S")

# convert columns 3 to 9 to numeric
data[, 3:9] <- sapply(data[, 3:9],as.numeric)

# plot histogram and save it to png
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.off()
