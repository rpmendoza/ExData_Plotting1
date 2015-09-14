## Author: Rolando Mendoza
## Date: 09/12/2015
## 
## this code plots the relevant data from "household_power_consumption.txt".
## the data are between 2007-02-01 and 2007-02-02.
## the txt file is required to be on the same folder as this code.

## unzip the file
## unzip("exdata-data-household_power_consumption.zip")

## load dplyr package which will be used later
library(dplyr)

## read the data
hpcData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings="?")

## convert to Date format
hpcData$Date <- as.Date(hpcData$Date, format="%d/%m/%Y")

## convert to Time format
#hpcData$Time <- strptime(hpcData$Time, format="%H:%M:%S")

## subset the data
beginDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")

hpcSubset <- hpcData[hpcData$Date >= beginDate & hpcData$Date <= endDate,]

## combine Date and Time columns to DateTime
hpcSubset <- hpcSubset %>% mutate(DateTime = paste(Date, Time, sep=" "))

## convert DateTime to date class
hpcSubset$DateTime <- strptime(hpcSubset$DateTime, format="%Y-%m-%d %H:%M:%S")

## create the png file
png(filename = "plot2.png", width=480, height=480)

## plot the graph
plot(hpcSubset$DateTime, hpcSubset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## close the file
dev.off()