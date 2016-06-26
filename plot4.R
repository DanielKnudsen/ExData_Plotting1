library(dplyr)
## check if sample data exists, otherwise create
if (!file.exists("household_power_consumption_sample.txt")) {
        unzip("household_power_consumption.zip", exdir = ".")
        mydf <-
                read.table(
                        "household_power_consumption.txt",
                        header = T,
                        sep = ";",
                        na.strings = "?",
                        colClasses = c(
                                "factor",
                                "factor",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric",
                                "numeric"
                        )
                )
        mydf$Date <- as.Date(mydf$Date, format = "%d/%m/%Y")
        dfDates <-
                filter(mydf, Date >= "2007-02-01", Date <= "2007-02-02")
        write.table(dfDates, "household_power_consumption_sample.txt")
}
## read sample data and create plot
df <-
        read.table("household_power_consumption_sample.txt", header = T)
par(mfrow = c(2, 2))
##top left plot
plot(
        x = df$Global_active_power,
        type = "l",
        ylab = "Global Active Power (kilowatts)",
        xlab = "",
        xaxt = "n"
)
v1 <- c(1, 1440, 2880)
v2 <- c("Thu", "Fri", "Sat")
axis(1, at = v1, labels = v2, las = 1)
##top right plot
plot(
        x = df$Voltage,
        type = "l",
        ylab = "Voltage",
        xlab = "datetime",
        xaxt = "n"
)
v1 <- c(1, 1440, 2880)
v2 <- c("Thu", "Fri", "Sat")
axis(1, at = v1, labels = v2, las = 1)
##bottom left plot
plot(
        x = df$Sub_metering_1 ,
        type = "l",
        ylab = "Energy sub metering",
        xlab = "",
        xaxt = "n"
)
lines(x = df$Sub_metering_2, col = "red")
lines(x = df$Sub_metering_3, col = "blue")
v1 <- c(1, 1440, 2880)
v2 <- c("Thu", "Fri", "Sat")
axis(1, at = v1, labels = v2, las = 1)
legend(
        "topright",
        cex = 1.0,
        text.width = 1400,
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = c(1, 1, 1),
        bty = "n",
        col = c("black", "red", "blue")
)
##bottom right plot
plot(
        x = df$Global_reactive_power,
        type = "l",
        ylab = "Global_reactive_power",
        xlab = "datetime",
        xaxt = "n"
)
v1 <- c(1, 1440, 2880)
v2 <- c("Thu", "Fri", "Sat")
axis(1, at = v1, labels = v2, las = 1)
dev.copy(png,
         file = "plot4.png",
         height = 480,
         width = 480)
dev.off()