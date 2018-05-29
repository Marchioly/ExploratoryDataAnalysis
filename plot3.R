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

######################## 3 ##############################################

plot(
  test$"Sub_metering_1" ~ test$day.time1,
  type = "l",
  lty = 1 ,
  xlab = "",
  ylab = "Energy sub metering"
)
points(test$"Sub_metering_2" ~ test$day.time1,
       type = "l",
       col = "red")
points(test$"Sub_metering_3" ~ test$day.time1,
       type = "l",
       col = "blue")
legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  lty = 1
)
dev.copy(png, file = "./data/plot03.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
