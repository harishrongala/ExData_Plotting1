## Find the observations of 1/2/2007 and 2/2/2007
date<-grep("^(1.2.2007|2.2.2007)",readLines("household_power_consumption.txt"))
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
png(filename = "plot1.png", width=480, height = 480)
## Set canvas
par(mfrow=c(1,1))
## Plot the histogram of 'Global Active Power'
hist(our_df$Global_active_power, col="red", main="Global Active Power", xlab='Global Active Power (kilowatts)')
## Close the device
dev.off()


