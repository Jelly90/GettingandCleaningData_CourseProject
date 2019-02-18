# CodeBook

## Input data

UCI HAR Dataset, as downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The dataset contains data collected from the accelerometers from the Samsung Galaxy S smartphone.It is divided into several files.

contains:
* activity_labels.txt, activity labels as encoded by nubers 1-6 (WALKING, WALKING-UPSTAIRS, WALKING-DOWNSTAIRS, SITTING, STANDING, LAYING)
* features.txt, all measured variables (561 variables)
* test folder 
  +  subjects_test.txt, defining which measuring window belongs to which subjects (30 subjects)
  +  X_test.txt, all measurements for the testset (2947 observations x 561 variables)
  +  y_test.txt, all activity assignments for the testset
* train folder 
  +  subjects_train.txt, defining which measuring window belongs to which subjects (30 subjects)
  +  X_train.txt, all measurements for the trainset (7352 observations x 561 variables)
  +  y_train.txt, all activity assignments for the trainset

all of the data mentioned was merged into on dataframe names **merged** containing:
1. 10299 observations (test and trainingset merged together by rbind())
2. 564 variables, 561 features + activity assignments + test_train assignment + subject assignment

Next, the dataset was reduced for variables reflecting the mean or the standard deviation of a variable resulting in the **merged_mean_std** dataframe.
This dataframe has 69 variables left

As a last step aggregate() was used to calculate the mean for each subject at each activity resulting in th **tidy** dataframe. This dataframe contains:
1. 180 rows (30 subjects x 6 activities)
2. 68 variables (the test_train assignment variable was ignored)

The **tidy** dataframe was saved as tidy_data.txt


