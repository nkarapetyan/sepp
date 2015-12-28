#!/usr/local/bin/Rscript

library(gbm)			# Load the gbm package
library(Metrics)		# Load Metrics for mae method
library(R.utils)		# for countLines

library(randomForest)

library(ggplot2)		
library(scales)

trainDataFileName = "train.csv"
testDataFileName = "test.csv"

# Load training set
DataTrain = read.csv(trainDataFileName, header = T, sep = ",", dec = ".", )
# Load testing set
DataTest = read.table(testDataFileName, header = T, sep = ",", dec = ".")	
#summary(DataTest)

#For error rate testing part on tarining set
cnt <- countLines(trainDataFileName)
trainCnt = round(cnt*0.7)
testCnt = cnt - trainCnt

#trainCnt #Debug
#testCnt # Debug
testHeader = colnames(DataTest)
trainHeader = colnames(DataTrain)
#testHeader # Debug
#trainHeader# Debug
DataTrainLocal = read.csv(trainDataFileName, header = T, nrows = trainCnt, sep = ",", dec = ".", )
#DataTrainLocal #Debug

# another way to store only testHeader columns 
DataTestLocal = read.csv(trainDataFileName, header = F, skip = trainCnt, sep = ",", dec = "." , col.names = trainHeader)
testTarget = DataTestLocal[, "target"]
DataTestLocal = DataTestLocal[, testHeader]
#DataTestLocal #Debug
#testTarget #Debug
#names(DataTestLocal)#Debug
#DataTestLocal #Debug

DataTrainLocal$time <- strftime(DataTrainLocal$datetime, format="%H:%M:%S")
DataTrainLocal$time <- as.POSIXct(DataTrainLocal$time, format="%H:%M:%S")
DataTrainLocal$time <- as.numeric(DataTrainLocal$time)
#DataTrainLocal$time 
#DataTrainLocal$datetime <-NULL
#DataTrainLocal$datetime #Debug

# Date column
#DataTrainLocal$date <- strftime(DataTrainLocal$datetime, format="%d")
#DataTrainLocal$date <- as.POSIXct(DataTrainLocal$date, format="%d")
#DataTrainLocal$date <- as.numeric(DataTrainLocal$date)

a = "------------------"
a
DataTrainLocal$date 
a = "------------------"
a 
DataTrainLocal$datetime <-NULL
#DataTrainLocal$datetime #Debug

##
### Predict the test set
DataTestLocal$time <- strftime(DataTestLocal$datetime, format="%H:%M:%S")
DataTestLocal$time <- as.POSIXct(DataTestLocal$time, format="%H:%M:%S")
DataTestLocal$time <- as.numeric(DataTestLocal$time)
#DataTestLocal
#DataTestLocal$date <- strftime(DataTestLocal$datetime, format="%d")
#DataTestLocal$date <- as.POSIXct(DataTestLocal$date, format="%d")
#DataTestLocal$date <- as.numeric(DataTestLocal$date)


DataTestLocal$datetime <-NULL
# Train the model
	gbm1 <- gbm(target ~ . ,distribution="laplace", data=DataTrainLocal, n.trees=3000, interaction.depth =6, shrinkage=0.05)	


	rf <- randomForest(target ~ ., data = DataTrainLocal, ntrees = 3000)
#    Prediction <- predict(rf, DataTestLocal)
	Prediction <- predict.gbm(gbm1, DataTestLocal, n.trees=3000)
##
Prediction <- round(Prediction, digits = 2)
write.table(Prediction, file = "submission.csv", sep = ",", qmethod = "double", row.names=FALSE)
#


para <- rep(1, testCnt)
para

err <- mae(testTarget, Prediction)
err

comb <- rbind(testTarget, Prediction)

mea.opt <- function(param) {
	    mae(testTarget, Prediction*param[1])
}

result <- optim(par = para, mea.opt)
    "-------"
result <- as.numeric(result)
Prediction <- as.numeric(Prediction)

a <- Prediction*result
#err <- mae(testTarget, a)
#err
