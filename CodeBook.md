# Codebook

## Source Data
The source data was collected by a group of 30 volunteers. Each person performed six activities wearing a smartphone on the waist.
- [Source data can be found here (.zip)] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- [Description of original dataset] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Downloading the raw data
1. Download the data from by using download.file()
2. Use the unzip() function to unzip the downloaded file

## Reading raw data
1. Use the read.table() function to read the following files:
	1. X_train.txt
	2. X_test.txt
	3. subject_train.txt
	4 subject_test.txt
	5. Y_test.txt
	6. Y_train.txt
2. The train data tables were merged using cbind() into a single train data table
3. The test data tables were merged using cbind() into a single test data table
4. The merged train and merged test data tables were combined into single data frame by using rbind()

## Cleaning the data
Only the mean and standard deviation measurements were extracted.
In order to do so, the dplyr::select() function was used.

The names "walking", "walking upstairs", "walking downstairs", "sitting", "landing" and "laying" were used as descriptive activity names instead of numerical values.
The included "activity_labels.txt" file was used as a reference for the mapping.

The variable names were extracted from the file "features.txt" as described in "features_info.txt".

all of the files ("activity_labels.txt", "features.txt", "features_info.txt") are included in the original zip file.
