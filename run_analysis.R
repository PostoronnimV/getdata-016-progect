
require(dplyr)
require(tidyr)

unzip("getdata-projectfiles-UCI HAR Dataset.zip")

# Extracts only the measurements on the mean and standard deviation for each measurement. 
feat <- read.table("./UCI HAR Dataset/features.txt")
col <- grepl("mean()|std()",feat[,2])

# Train data set

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(x_train) <- feat[,1]
x_train <- x_train[,col] 
names(x_train) <- feat[col,2]

subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subj_train)<- c("subject")

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_train)<- c("activity")

train <- cbind(subj_train,y_train,x_train)
train$data_set <- "train"

# Test data set
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(x_test) <- feat[,1]
x_test <- x_test[,col] 
names(x_test) <- feat[col,2]

subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subj_test)<- c("subject")

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_test)<- c("activity")

test <- cbind(subj_test,y_test,x_test)
test$data_set <- "test"

# Merges the training and the test sets to create one data set.
data_set <- tbl_df(rbind(train,test))

# Uses descriptive activity names to name the activities in the data set
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(labels) <- c("activity","activity_desc")

data_set <- inner_join(labels,data_set,by="activity")
