# Creates a simple random forest benchmark

library(randomForest)
library(readr)

set.seed(0)

numTrain <- 10000
numTrees <- 25

trainMast <- read_csv("Data/train.csv")
test <- read_csv("Data/test.csv")

rows <- sample(1:nrow(trainMast), numTrain)
labels <- as.factor(trainMast[rows,1])
train <- trainMast[rows,-1]
trainAct <- trainMast[rows,1]

rf <- randomForest(train, labels, xtest=test, ntree=numTrees)
predictions <- data.frame(ImageId=1:nrow(test), Label=levels(labels)[rf$test$predicted])
head(predictions)

write_csv(predictions, "rf_benchmark.csv") 
