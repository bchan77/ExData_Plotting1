plot1 <- function()
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


#================================================
# Plot the Graph plot1 
#================================================	

	#Load the library
	library(datasets)
	
	#Plot the graph. 
	#Reason for "as.numeric(as.character(small_data$Global_active_power))" is to cover
	#factor to numeric as hist only takes numeric

	hist(as.numeric(as.character(small_data$Global_active_power)), xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")
	dev.copy(png, file = "plot1.png", width=480,height=480)
	dev.off()	
}