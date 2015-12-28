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

#--------------------------------------------------
# Function for reading specified chunk of data frame
#
# input: sk - how much to skip
#	 size - size of chunk
#	 dataFileName 
#
# output: the chunk of data as a data frame
#
readChunk <- function(sk, size, dataFileName) {
    header = colnames(DataTrain)
    data_l = read.csv(dataFileName, header = F, skip = sk, nrows = size, sep = ",", dec = ".", col.names = header)

#FIXME: unambigous format error -------------------------------
#    data_l$time <- strftime(data_l$datetime, format="%h:%m:%s")
#    data_l$time <- as.posixct(data_l$time, format="%h:%m:%s")
#    data_l$time <- as.numeric(data_l$time)
#--------------------------------------------------------------

    print(data_l$time)
}
#--------------------------------------------------


# Number of iterations
k = 2

cnt <- countLines(trainDataFileName)  - 1 # number of rows in Training Data
skip <- 0

for (i in 1:k){
#   print(skip) #Debug
    chunk_size <- round((cnt - skip) / (k +1 - i) )

    #-----------------------------------------------------------------
    # creating train and testing data chunks from trainData 
    # for validation in a 7:3 proportions
    trainCnt = round(chunk_size*0.7)
    testCnt = chunk_size - trainCnt

    trainData <- readChunk(skip, trainCnt, trainDataFileName)
    trainData$time <- strftime(trainData$datetime, format="%h:%m:%s")
    trainData$time <- as.posixct(trainData$time, format="%h:%m:%s")
    trainData$time <- as.numeric(trainData$time)
    #print(trainData) #Debug

    testData <- readChunk(skip + trainCnt, testCnt, trainDataFileName)

    testTarget = DataTestLocal[, "target"]
    testHeader = colnames(DataTest)
    DataTestLocal = DataTestLocal[, testHeader]

    testData$time <- strftime(testData$datetime, format="%h:%m:%s")
    testData$time <- as.posixct(testData$time, format="%h:%m:%s")
    testData$time <- as.numeric(testData$time)
    print(testData) #Debug

    #------------------------------------------------------------------


#skip <- skip + chunk_size
#   print(chunk_size) #Debug
}

