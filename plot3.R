## URL of data file
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## Download the data file
if(!file.exists("./data.zip"))
        download.file(url,"./data.zip")
## Unzip the file
unzip("./data.zip")
## Find the observations of 1/2/2007 and 2/2/2007
date<-grep("^(1.2.2007|2.2.2007)",readLines("./household_power_consumption.txt"))
## Read the header line
sav<-readLines("household_power_consumption.txt")[1]
## Read filtered data and append it to header data 
sav<-append(sav,readLines("household_power_consumption.txt")[date])
## Write this data to a text file
writeLines(sav,"filtered_household_power_data.txt")
## Read the data into a data frame
our_df<-read.table("filtered_household_power_data.txt",header=TRUE,sep=";", na.strings = "?")
## Convert 'Date' variable into date class
our_df$Date<-as.Date(our_df$Date,"%d/%m/%Y")
## Create 'datetime' variable merging date and time
our_df$datetime<-strptime(paste(our_df$Date,our_df$Time),"%Y-%m-%d %H:%M:%S")
## Open PNG device and set file name, width and height
png(filename = "plot3.png", width=480, height = 480)
## Set canvas
par(mfrow=c(1,1))
## Start the plot with type="n"
plot(our_df$datetime, our_df$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
## Connect dots to draw lines
lines(our_df$datetime, our_df$Sub_metering_1)
## Connect dots to draw lines
lines(our_df$datetime, our_df$Sub_metering_2, col="red")
## Connect dots to draw lines
lines(our_df$datetime, our_df$Sub_metering_3, col="blue")
## Legend
legend("topright", lty=1, col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## Close the device
dev.off()