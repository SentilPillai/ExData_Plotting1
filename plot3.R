#######################################################################
## Coursera: Exploratory Data Analysis ( Project 1)
## set working directory to where data set was unzipped
setwd("~/Desktop/ExploratoryDataAnalysis/Project_1")

## install and load "Defaults" library, if the not done previously 
## install.packages("Defaults")  
library(Defaults)

## Set the default format for date to be read 
setDefaults('as.Date.character', format = '%d/%m/%Y')

## data file name
fileName.EPC <- "Data/household_power_consumption.txt"

## set column names
colNames.EPC <- c("sourceDate","sourceTime","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

## set data types for columns, The first column is set as date and the format is set correctly %d/%m/%Y above
colClasses.EPC <- c("Date","character","numeric","numeric",
                    "numeric","numeric","numeric","numeric","numeric")

## dates to sub set, for filtering the required dates from the large file 
filter.date <- as.Date(c("1/2/2007","2/2/2007"))

## read data 2,075,259 records from file and subset 2880 to memory DF
data.EPC <-  subset(read.table(fileName.EPC, header = TRUE, sep = ";"
                               ,na.strings = "?"  , comment.char = "", 
                               ,col.names = colNames.EPC, colClasses = colClasses.EPC
),   sourceDate %in% filter.date );

dim(data.EPC) ## [1] 2880   9

## Concatenate the date and time columns
data.EPC$DateTime <- paste(data.EPC$sourceDate, data.EPC$sourceTime )

## re format it POSIX date
data.EPC$DateTime <- as.POSIXlt(data.EPC$DateTime , format="%Y-%m-%d %H:%M:%S")

## summary(data.EPC)
str(data.EPC)

#######################################################################

## Open PNG device; create 'plot3.png' in the working directory
## Create plot and send to a file (no plot appears on screen)
png(filename = "plot3.png",    width = 480, height = 480, units = "px", bg = "white")

## Create the plot, with annotates
plot( x=(data.EPC$DateTime), y=data.EPC$Sub_metering_1, col="black", type="l" ,xlab="", ylab="Energy sub metering")
lines(x=(data.EPC$DateTime), y=data.EPC$Sub_metering_2, col="red")
lines(x=(data.EPC$DateTime), y=data.EPC$Sub_metering_3, col="blue")

## Create legend 
legend.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend.col <- c("black","red","blue")
legend("topright", legend.txt, col=legend.col, lwd=1, cex=0.9)


## Close the PNG file device
dev.off()

## View the file 'plot3.png' on the computer 


## cleanUp
rm(filter.date); rm(colClasses.EPC); rm(colNames.EPC); rm(fileName.EPC)
rm(legend.txt); rm(legend.col); rm(data.EPC)