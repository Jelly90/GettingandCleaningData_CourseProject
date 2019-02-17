################################################################################
#Review criteria

#1. The submitted data set is tidy.
#2. The Github repo contains the required scripts.
#3. GitHub contains a code book that modifies and updates the available 
#   codebooks with the data to indicate all the variables and summaries 
#   calculated, along with units, and any other relevant information.
#4. The README that explains the analysis files is clear and understandable.
#5. The work submitted for this project is the work of the student who submitted it.

################################################################################
# Source of Project Dataset:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#download Project Dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "ProjectData.zip")

# unzip Folder
unzip("ProjectData.zip",exdir="ProjectData")

################################################################################
# libraries:
library(plyr)
library(dplyr)
library(tidyr)

################################################################################
# You should create one R script called run_analysis.R that does the following.
# Check

################################################################################
# Merges the training and the test sets to create one data set.

# load all data necessary
features <- read.table("ProjectData/UCI HAR Dataset/features.txt", 
                       header = FALSE, stringsAsFactors = FALSE)[,2]
activity_labels <- read.table("ProjectData/UCI HAR Dataset/activity_labels.txt", 
                              header = FALSE, stringsAsFactors = FALSE)[,2]

test <- read.table("ProjectData/UCI HAR Dataset/test/X_test.txt", 
                   header = FALSE, stringsAsFactors = FALSE)
sub.test <- read.table("ProjectData/UCI HAR Dataset/test/subject_test.txt", 
                       header = FALSE, stringsAsFactors = FALSE)

train <- read.table("ProjectData/UCI HAR Dataset/train/X_train.txt", 
                   header = FALSE, stringsAsFactors = FALSE)
sub.train <- read.table("ProjectData/UCI HAR Dataset/train/subject_train.txt", 
                       header = FALSE, stringsAsFactors = FALSE)

################################################################################
# Extracts only the measurements on the mean and standard deviation for 
# each measurement.

################################################################################
# Uses descriptive activity names to name the activities in the data set

################################################################################
# Appropriately labels the data set with descriptive variable names.

################################################################################
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

