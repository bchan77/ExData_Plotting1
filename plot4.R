plot4 <- function()
{
	
	
#================================================
# Download data 
#================================================	
	# Check if there is a data directory
	if(!file.exists("data")) {
		dir.create("data")
	}

	path_to_zip <- "./data/household_power_consumption.zip"

	# Check if the data file is there. If not, download the file
	if(!file.exists(path_to_zip)){
	
		#download the file
		fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		download.file(fileUrl, destfile = path_to_zip, method = "curl")
	}
	
	path_to_data <- "./data/household_power_consumption.txt"
	
	#Check if the txt file is there, if not extract the file
	if(!file.exists(path_to_data)){
		#unzip the file
		unzip(path_to_zip, overwrite = TRUE, exdir = "./data/") 
	}
	
#================================================
# Read the actual txt file and load the data into memory
#================================================		

	#Load all the data into memory
	mydata <- read.csv(path_to_data, sep = ";", header=TRUE)
	#Take the subset of the data and look for date = 2007-02-01 and 2007-02-02
	small_data <- mydata[mydata$Date == '1/2/2007' | mydata$Date == '2/2/2007',]
	
	#Add one more DateTime column by combining Date + Time
	v <- strptime(paste(small_data$Date, small_data$Time), format = "%d/%m/%Y %H:%M:%S")
	small_data$DateTime <- v

#================================================
# Plot the Graph plot3
#================================================	

	#Load the library
	library(datasets)
	
	#Plot the graph. 
	#Reason for "as.numeric(as.character(small_data$*)) is to covert 
	#factor to numeric 

	
	
	par(mfrow = c(2,2))
	
	with(small_data, {
	   #Upper Left. 
	   plot(x=small_data$DateTime, y=as.numeric(as.character(small_data$Global_active_power)),type="l",xlab="", ylab="Global Active Power (kilowatts)")
	  lines(x=small_data$DateTime, y=as.numeric(as.character(small_data$Global_active_power)), type="l")
		
	   #Upper Right
	   plot(x=small_data$DateTime, y=as.numeric(as.character(small_data$Voltage)), xlab="datetime", ylab="Voltage", type ='l')
	   
	   #Botton Left
	   	plot(x=small_data$DateTime, y=as.numeric(as.character(small_data$Sub_metering_1)),ylab="Energy sub metering", xlab ="", type="l", col="black")
	lines(x=small_data$DateTime, y=as.numeric(as.character(small_data$Sub_metering_2)),ylab="Energy sub metering", xlab ="", type="l", col="red")
	lines(x=small_data$DateTime, y=as.numeric(as.character(small_data$Sub_metering_3)),ylab="Energy sub metering", xlab ="", type="l", col="blue")		
	legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))
	
		#Bottom Right
	    plot(x=small_data$DateTime, y=as.numeric(as.character(small_data$Global_reactive_power)),type="l",xlab="datetime", ylab="Global_reactive_power")
	  lines(x=small_data$DateTime, y=as.numeric(as.character(small_data$Global_reactive_power)), type="l")
		
		
	})
	
	dev.copy(png, file = "plot4.png",width=480,height=480)
	dev.off()	
}