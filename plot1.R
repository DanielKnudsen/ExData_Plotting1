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
par(mfrow = c(1, 1))
df <-
        read.table("household_power_consumption_sample.txt", header = T)
hist(
        df$Global_active_power,
        col = "red",
        main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)",
        ylab = "Frequency"
)
dev.copy(png,
         file = "plot1.png",
         height = 480,
         width = 480)
dev.off()

