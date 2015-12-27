# Getting and Cleaning Data - Week 3 Project
  
# How to Run
  
  ``` 
  source("analysis.R");
  runAnalysis();
  ``` 
# analysis.R
  This scrip contains  the following methods:
  1. downloadData - download the data (if the data not already exists)
  2. mergeData - read the measurements, subjects and activities train and test data
  3. extractMeanAndStd - take only measurements on the mean and standard deviation
  4. setActivityNames - set activity names
  5. setVariableNames - set descriptive variable names
  6. runAnalysis - orchestrates the previous methods, perform the analysis and save the result into tidy.txt