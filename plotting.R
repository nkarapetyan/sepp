#!/usr/local/bin/Rscript

library(ggplot2)		
library(scales)

trainDataFileName = "train.csv"
testDataFileName = "test.csv"

# Load training set
DataTrain = read.csv(trainDataFileName, header = T, sep = ",", dec = ".", )
# Load testing set
DataTest = read.table(testDataFileName, header = T, sep = ",", dec = ".")	
#summary(DataTest)

# >1<--------------->plot the train data : target on datetime<-----------------
pdf("plots/TrainPlot.pdf")
DataTrain$datetime <- as.POSIXct(DataTrain$datetime, format = "%Y-%m-%d %H:%M:%S")
theme_set(theme_bw()) # Change the theme to my preference
dt <- ggplot(data = DataTrain, aes(x = datetime, y = target)) + geom_point()
dt <- dt + scale_x_datetime(breaks = date_breaks("months"), labels = date_format("%m"))
print(dt)

#--------------->plot the train data : temperature on datetime<-----------------
dt <- ggplot(data = DataTrain, aes(x = datetime, y = temp)) + geom_point() + geom_point(colour = "red")

# for scaling the x axis of datetime
dt <- dt + scale_x_datetime(breaks = date_breaks("months"), labels = date_format("%m"))
print(dt)

#--------------->plot the train data : target on temperature <-----------------
dt <- ggplot(data = DataTrain, aes(x = temp, y = target)) + geom_point() + geom_point(colour = "blue")
print(dt)

#--------------->plot the train data : temp on time <-----------------
DataTrain$time <- strftime(DataTrain$datetime, format="%H:%M:%S")
DataTrain$time <- as.POSIXct(DataTrain$time, format="%H:%M:%S")

dt <- ggplot(data = DataTrain, aes(x = time, y = temp)) + geom_point() + geom_point(colour = "green")
dt <- dt + scale_x_datetime(breaks = date_breaks("3 hours"), labels = date_format("%H:%M"))
plot(dt)

#--------------->plot the train data : taget  on time <-----------------
dt <- ggplot(data = DataTrain, aes(x = time, y = target)) + geom_point() + geom_point(colour = "brown")
dt <- dt + scale_x_datetime(breaks = date_breaks("3 hours"), labels = date_format("%H:%M"))
plot(dt)

dev.off()
#--!--------------------------end of plotting---------------------------------

# >2<--------------->plot the test data : target on datetime<-----------------
pdf("plots/TestPlot.pdf")
DataTest$datetime <- as.POSIXct(DataTest$datetime, format = "%Y-%m-%d %H:%M:%S")
theme_set(theme_bw()) # Change the theme to my preference
dtest <- ggplot(data = DataTest, aes(x = datetime, y = temp)) + geom_point()
dtest <- dtest + scale_x_datetime(breaks = date_breaks("months"), labels = date_format("%m"))
print(dtest)

#--------------->plot the test data : temp on time <-----------------
DataTest$time <- strftime(DataTest$datetime, format="%H:%M:%S")
DataTest$time <- as.POSIXct(DataTest$time, format="%H:%M:%S")

dtest <- ggplot(data = DataTest, aes(x = time, y = temp)) + geom_point() + geom_point(colour = "green")
dtest <- dtest + scale_x_datetime(breaks = date_breaks("3 hours"), labels = date_format("%H:%M"))
plot(dtest)

dev.off()
#--!--------------------------end of plotting---------------------------------

