library(dplyr);

runAnalysis <- function(){
  
  downloadData();
  data <- mergeData();
  data <- extractMeanAndStd(data)
  data <- setActivityNames(data)
  data <- setVariableNames(data)
   
  data <- group_by(data, subjectID, activityID)
  data <- summarize_each(data, funs(mean)) 
  data <- arrange(data, subjectID, activityID)
  
  write.table(data, "./tidy.txt", row.names=FALSE)
}

setVariableNames <- function(data){
  colnames(data) <- gsub("mean", "Mean", colnames(data))
  colnames(data) <- gsub("std", "Std", colnames(data))
  colnames(data) <- gsub("BodyBody", "Body", colnames(data))
  colnames(data) <- gsub("\\.", "", colnames(data))
  data
}

setActivityNames <- function(data){
  data$activityID[data$activityID == "1"] <- "walk"
  data$activityID[data$activityID == "2"] <- "walk upstairs"
  data$activityID[data$activityID == "3"] <- "walk downstairs"
  data$activityID[data$activityID == "4"] <- "sit"
  data$activityID[data$activityID == "5"] <- "stand"
  data$activityID[data$activityID == "6"] <- "lay"
  data
}

extractMeanAndStd <- function(data){
  data %>% select(subjectID, activityID, matches('mean|std')) -> data
}

mergeData <- function(){

  # Get measurements train and test data 
  measurementsTrain <- read.table ("./data/UCI HAR Dataset/train/X_train.txt")
  measurementsTest <- read.table ("./data/UCI HAR Dataset/test/X_test.txt")
  
  # Assign proper lables to the measurments data
  measurmentsLabels <- read.table("./data/UCI HAR Dataset/features.txt")
  measurmentsLabels <- make.names(as.list(as.character(measurmentsLabels$V2)), unique = TRUE, allow_ = TRUE)
  colnames(measurementsTrain) <- measurmentsLabels
  colnames(measurementsTest) <- measurmentsLabels;
  
  # Get subject train and test data 
  subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "subjectID")
  subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "subjectID")
    
  # Get activity train and test data 
  activityTest <- read.table ("./data/UCI HAR Dataset/test/Y_test.txt", header = FALSE, col.names = "activityID")
  activityTrain <- read.table ("./data/UCI HAR Dataset/train/Y_train.txt", header = FALSE, col.names = "activityID")
  
  # Merge data
  testData <- cbind(subjectTest, activityTest, measurementsTest)
  trainData <- cbind(subjectTrain, activityTrain, measurementsTrain)
  allData <- rbind(testData, trainData)
  
}

downloadData <- function(){
  
  if (!file.exists("data")) {
    dir.create("data")
  }
  if (!file.exists("./data/data.zip")) {
    sourceUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(sourceUrl, destfile = "./data/data.zip")
  }
  unzip("./data/data.zip", exdir = "./data")
}