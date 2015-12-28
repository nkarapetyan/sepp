#!/usr/local/bin/Rscript

library(gbm)			# Load the gbm package
library(Metrics)		# Load Metrics for mae method
library(R.utils)		# for countLines

library(ggplot2)		
library(scales)

trainDataFileName = "train.csv"
testDataFileName = "test.csv"

# Load training set
DataTrain = read.csv(trainDataFileName, header = T, sep = ",", dec = ".", )
# Load testing set
DataTest = read.table(testDataFileName, header = T, sep = ",", dec = ".")	
#summary(DataTest)

DataTrain$time <- strftime(DataTrain$datetime, format="%H:%M:%S")
DataTrain$time <- as.POSIXct(DataTrain$time, format="%H:%M:%S")
DataTrain$time <- as.numeric(DataTrain$time)
#DataTrain$time #Debug
DataTrain$datetime <-NULL

# Train the model
gbm1 <- gbm(target ~ .,distribution="laplace", data=DataTrain, n.trees=3000, interaction.depth =6, shrinkage=0.05)	
##
### Predict the test set
DataTest$time <- strftime(DataTest$datetime, format="%H:%M:%S")
DataTest$time <- as.POSIXct(DataTest$time, format="%H:%M:%S")
DataTest$time <- as.numeric(DataTest$time)
DataTest$datetime <-NULL

Prediction <- predict.gbm(gbm1, DataTest, n.trees=3000)
##
Prediction <- round(Prediction, digits = 4)
write.table(Prediction, file = "submission.csv", sep = ",", qmethod = "double", row.names=FALSE)
#
