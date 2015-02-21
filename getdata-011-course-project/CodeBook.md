---
title: "CodeBook for Getting and Cleaning Data Course Project"
output: html_document
---
This document describes the transformations performed for getting and cleaning the following data sets per requirement for the getdata-011 course.

* Data
 1. Data was obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 2. Data zip file is located at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Transformations
 1. Download the zip file to data.zip.
 2. Unzip data.zip.
 3. Read training files (subject_train.txt, X_train.txt, y_train.txt) from "UCI HAR Dataset/train" into (subject_train, X_train, y_train) respectively.
 4. Read test files (subject_test.txt, X_test.txt, y_test.txt) from "UCI HAR Dataset/test" into (subject_test, X_test, y_test) respectively.
 5. Read feature names from "UCI HAR Dataset/features.txt" into features.
 6. Read activity labels from "UCI HAR Dataset/activity_labels.txt" into activity_labels.
 7. Combine training and test sets - i.e., concatenante subject_train and subject_test into subject, X_train and X_test into X and Y_train and Y_test into Y.
 8. Find "interesting" features with "mean" and "std" in their names and sort and save those indices into feature_indices.
 9. Extract the interesting columns from X into X_i.
 10. Set the "interesting" column names for X_i.
 11. Convert y from numeric to string data by replacing the number by the corresponding activity from activity_labels. 
 12. Set the column names for y.
 13. Create merged_data_set by combining subject, X_i and y.
 14. Create tidyset by aggregating the merged_dataset (columns corresponding to X_i) by the subject and activity, using function mean.
 15. Write out tidyset using write.table, excluding row names.
 
