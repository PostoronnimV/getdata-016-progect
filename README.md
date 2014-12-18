Getting and Cleaning Data Course Project
===================

## Task

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## To reproduce results of this work 

1. Download the "run_analysis.R" script in your project on your local drive. 
2. Download data for the project from this link [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
3. Run source("run_analysis.R"), then it will make a "data_set_tidy.txt"" in your work directory.

## Additional librarys
"run_analysis.R" depends on dplyr and tidyr

