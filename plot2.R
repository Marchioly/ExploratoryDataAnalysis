if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

library(lubridate)
#setwd("C:/Michael/Education/Data Analysis/DataSpec/4 Explore Data/Week 01/Project")
fileName<-"./data/household_power_consumption.txt"
myData<- read.csv(fileName, sep=";", na.strings = c("?"))
test<- subset(myData, dmy(myData$Date) <= as.Date("2007-02-02") & dmy(myData$Date) >= as.Date("2007-02-01"))
day<-paste(test$Date, test$Time )
day.time1=as.POSIXct(day,format="%d/%m/%Y %H:%M:%S")
test<-cbind(test, day.time1)
rm(myData)


######################## 2 ##############################################
plot(test$Global_active_power ~ test$day.time1,type="o", pch=NA , xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "./data/plot02.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
