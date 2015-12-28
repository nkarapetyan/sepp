#!/usr/local/bin/Rscript

library(Metrics)			# Load the gbm package
library(gbm)			# Load the gbm package
#library(R.utils) 		# for countLines

library(ggplot2)
library(scales)
#-----------------------------------------------------------------------
# Example 6. Functions in R
func <-function(arg1) {
    r <- arg1*10
    r
}

res <- func(1000)
res
#-----------------------------------------------------------------------
# Example 5. Optima minimization example
dat=data.frame(x=c(1,2,3,4,5,6), y=c(1,3,5,6,8,12))

min.RSS <- function( par) {
f<- sum((par[1] + par[2] * dat$x -dat$y)^2)
#  with(data, sum((par[1] + par[2] * x - y)^2))
#with(dat, f)
return	(f)

}

result <- optim(par = c(0, 1), min.RSS)
result


#-----------------------------------------------------------------------
# Example 4. Plotting datetime on x axis with target values
#date = read.csv("dummy.csv", header = T, sep = ",", dec=".")
#date
#date$datetime <- as.Date(date$datetime)
#theme_set(theme_bw()) # Change the theme to my preference
#dt <- ggplot(data = date, aes(x = datetime, y = target)) + geom_point()
#
## for scaling the x axis of datetime
#dt + scale_x_date(breaks = date_breaks("days"), labels = date_format("%m/%d"))

#///
#data.df <- data.frame(Plant = c("Plant1", "Plant1", "Plant1", "Plant2", "Plant2","Plant2"), Type = c(1, 2, 3, 1, 2, 3), Axis1 = c(0.2, -0.4, 0.8, -0.2, -0.7, 0.1), Axis2 = c(0.5, 0.3, -0.1, -0.3, -0.1, -0.8))
#
#g = ggplot(data.df, aes(x = Axis1, y = Axis2, shape = Plant, color = Type)) 
#print (g + geom_point())
#
#
#print(qplot (1 : 10, 1 : 10))
#///

#--- example from stackoverflow
#p = ggplot(mtcars, aes(wt, mpg))
#p = p + geom_point()
#print(p)

# -----------------------------------------------------------------------
# Example 3. Manipulating data 
#header = read.csv("a.csv", header = F, nrows = 1, sep = ",", dec=".")
#header = as.vector(t(header)[,1])
#header
#a = read.csv("a.csv", header = F, skip = 1,nrows = 3, sep = ",", dec=".", col.names = header)

# 1. names(dataFrame) returns the names of columns in the vector format

#a = read.csv("a.csv", header = T, nrows = 3, sep = ",", dec=".")
#header  = names(a)
#b = read.csv("a.csv", header = F, skip = 3, nrows = 2, sep = ",", dec=".", col.names = header)

# 2. eliminates "aaa" named column from data frame, only for one column
# this is for multiple columns dd[ ,!(colnames(dd) %in% c("A", "B"))]
#a = a[, colnames(a) != "aaa"]
#st = "-------"
#st
#a
#a$headeeeer  
 
#c = read.csv("a.csv", header = T, skip = 5, sep = ",", dec=".")

#a
#b
#c
#countLines("a.csv")

#---------------------------------------------------------------
# Example2: Didn't work 
#library(Metrics)			# Load the gbm package
#library(gbm)			# Load the gbm package
#
#arr1 <- c(3, 5, 7, 9, 13, 18, 19)
#arr2 <- c(6, 8, 10, 12, 19, 20, 22)
#trainData <- data.frame(a = arr1, b = arr2)
##el <- trainData$a
#
#testData <- c(6, 8, 10, 12, 19, 20, 22)
#
#res <- mae(trainData$a, testData)
#res

#--------------------------------------------------------------
# Example1: Mean Absolute Error 
#library(Metrics)			# Load the gbm package
#
#arr1 <- c(3, 5, 7, 9)
#arr2 <- c(6, 8, 10, 12)
#
#
#res <- mae(arr1, arr2)
#res
