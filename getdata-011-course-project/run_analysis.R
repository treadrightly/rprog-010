# Copyright github.com/treadrightly

# download and unzip the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "data.zip"
outfile <- "output.txt"

download.file(url = url, destfile = destfile, mode = "wb", method = "wget")
unzip(zipfile = destfile)

# read training and test sets
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)

# read names of features
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)

# read activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)

# combine training and test sets
subject <- rbind(subject_train, subject_test)
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)

# get vector of interesting feature indices
features_with_mean <- grep("mean", features$V2)
features_with_std <- grep("std", features$V2)
feature_indices <- sort(c(features_with_mean, features_with_std))

# interesting features
features_text <- features[feature_indices,]
# extract interesting columns from X
X_i <- X[,feature_indices]
# set column names in X with descriptive names
colnames(X_i) <- features_text$V2

# label y with activity names
for (i in 1:length(activity_labels$V1))
{
  y[which(y$V1 == i),"V2"] <- activity_labels$V2[i]
}

# set column names for y
colnames(y) <- c("index","activity")

# merge subject, X and y to create one merged data set 
# with descriptive column names for X and activity name for y
merged_data_set <- cbind(subject=subject$V1, X_i, activity=y$activity)

from <- 2
to <- dim(merged_data_set)[2] - 1

tidyset <- aggregate(merged_data_set[,from:to], by=list(merged_data_set$subject, merged_data_set$activity), FUN=mean)
tidyset <- tidyset[order(tidyset$Group.1, tidyset$Group.2, decreasing=FALSE),]
colnames(tidyset)[1] <- "subject"
colnames(tidyset)[2] <- "activity"
# this is confusing. i remember reading on the forum that set col.names to FALSE when
# writing, but the assignment page just says this:
# Please upload your data set as a txt file created with write.table() using row.name=FALSE 
# hence keeping the column names
output <- write.table(x=tidyset, file=outfile, quote=FALSE, row.names=FALSE, col.names=TRUE)
