##Downloading File and Putting Raw Data into R (costs approximately 200 MB of memory)
my_data_download<-"exdata_data_household_power_consumption.zip"
if (!file.exists(my_data_download)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", mode="wb", destfile=my_data_download)
  my_data_unclean<-read.table(unzip(my_data_download),sep=";", header=TRUE)
}

##Setting the Date column as Dates in R
my_data_unclean$Date<-as.Date(my_data_unclean$Date, "%d/%m/%Y")

##Isolating Febuary 1st and 2nd of 2007
my_data_day1<-my_data_unclean[my_data_unclean$Date=="2007-02-01",]
my_data_day2<-my_data_unclean[my_data_unclean$Date=="2007-02-02",]
my_data_complete<-rbind(my_data_day1, my_data_day2)

##Opening Graphics Device to work with
png(file="plot2.png", width=480, height=480)

##Converting the appropriate column to appropriate time format
my_data_complete$Time<-paste(my_data_complete$Date, my_data_complete$Time)
my_data_complete$Time<-strptime(my_data_complete$Time, "%Y-%m-%d %H:%M:%S")

##Plotting the line Graph
plot(my_data_complete$Time, as.numeric(levels(my_data_complete$Global_active_power))[my_data_complete$Global_active_power], type="o", cex=0, ylab="Global Active Power (kilowatts)", xlab="")

##turning the graphics device off
dev.off()