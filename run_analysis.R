require(dplyr)
require(tidyr)

unzip("getdata-projectfiles-UCI HAR Dataset.zip")

# Extracts only the measurements on the mean and standard deviation for each measurement. 
feat <- read.table("./UCI HAR Dataset/features.txt")
col <- grepl("mean\\(|std\\(",feat[,2])

# Train data set

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")[,col]
names(x_train) <- feat[col,2]

subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subj_train)<- c("subject")

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_train)<- c("activity_id")

train <- cbind(subj_train,y_train,x_train)

# Test data set
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")[,col]
names(x_test) <- feat[col,2]

subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subj_test)<- c("subject")

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_test)<- c("activity_id")

test <- cbind(subj_test,y_test,x_test)

# Merges the training and the test sets to create one data set.
data_set <- tbl_df(rbind(train,test))

# Uses descriptive activity names to name the activities in the data set
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(labels) <- c("activity_id","activity_desc")

data_set <- inner_join(labels,data_set,by="activity_id")
names(data_set) <- gsub("\\(\\)","",names(data_set))
names(data_set) <- gsub("-","_",names(data_set))

# Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
data_set_tidy<- data_set %>%
    select(activity_id:subject,
           contains("mean"),
           contains("std")) %>%
    gather(str_var,value,contains("mean"),contains("std")) %>%
    group_by(activity_id,activity_desc,subject,str_var) %>%
    summarise(value_mean= mean(value)) %>%
    ungroup() %>%
    separate(str_var, into = c("variable", "measure","axe"), sep = "_",extra="drop")

data_set_tidy[is.na(data_set_tidy$axe),"axe"] <- ""

write.table(data_set_tidy,"data_set_tidy.txt",row.names=FALSE)

