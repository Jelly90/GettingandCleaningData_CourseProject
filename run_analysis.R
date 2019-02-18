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
if (!file.exists(zipFile)) {
unzip("ProjectData.zip",exdir="ProjectData", mode = "wb")
}
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

activity.train <- read.table("ProjectData/UCI HAR Dataset/train/y_train.txt", 
                    header = FALSE, stringsAsFactors = FALSE)
activity.test <- read.table("ProjectData/UCI HAR Dataset/test/y_test.txt", 
                            header = FALSE, stringsAsFactors = FALSE)


# set column names to features
names(test) <- features
names(train) <- features

# set variable to differ between test and trainingset
train$test_train <- "train"
test$test_train <- "test"

# add known or predicted outcome to the dataset
test$activity <- activity.test$V1
train$activity <- activity.train$V1

# add subjects to the dataset
test$subject <- sub.test$V1
train$subject <- sub.train$V1

# merge test and trainingset
merged <- rbind(train,test)

################################################################################
# Extracts only the measurements on the mean and standard deviation for 
# each measurement.

mean_std <- grep("mean\\(\\)|std", features)

# add last two columns to selection vector (test_train, activity & subject)
vec <- c(mean_std, 562:564)
merged_mean_std <- merged[,vec]

################################################################################
# Uses descriptive activity names to name the activities in the data set

merged_mean_std$activity <- as.factor(merged_mean_std$activity)
levels(merged_mean_std$activity) <- factor(activity_labels)

################################################################################
# Appropriately labels the data set with descriptive variable names.

names(merged_mean_std) <- 
  gsub("^f", "frequencyDomain_", names(merged_mean_std)) %>%
  gsub("^t", "timeDomain_", .) %>%
  gsub("Gyro", "_gyroscope_", .) %>%
  gsub("Acc", "_accelerometer_", .) %>%
  gsub("Mag", "magnitude_", .)  %>%
  gsub("\\-mean\\(\\)", "mean", .) %>%
  gsub("\\-std\\(\\)", "standardDeviation", .) %>%
  gsub("Jerk", "Jerk_", .) 


################################################################################
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

## aggregate dataset as asked
tidy <- aggregate(merged_mean_std[1:66], 
                  c(list(merged_mean_std$subject), list(merged_mean_std$activity)),
                  mean)

# rename group variables
names(tidy)[1:2] <- c("subject", "activity")



################################################################################
write.table(tidy, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)