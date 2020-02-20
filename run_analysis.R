# Directory
setwd("C:/Users/Ester/Desktop/R/Cursos/COURSERA/DATASCIENCE_Foundations using R/CURSO3_Getting and cleaning data/WEEK 4/UCI HAR Dataset")

# Libraries needed
library(dplyr)
library(data.table)

# These are the files to read
# features.txt
# activity_labels.txt
# X_train.txt
# y_train.txt
# X_test.txt
# y_test.txt
# subject_train.txt
# subject_test.txt

# Import the data, 'features' and 'activity_labels'
features <- read.table("features.txt", header = FALSE)
View(features)

activity_labels <- read.table("activity_labels.txt", header = FALSE)
View(activity_labels)
# change the original names of the columns in 'activity_labels'. I change 'V1' to 'Code_Activity' and 'V2' to 'Activity_type'
colnames(activity_labels) <- c("Code_Activity", "Activity_type")

# Reading the data Training
y_train <- read.table("y_train.txt", header = FALSE)
View(y_train)
dim(y_train)
# change the name of the name of the unic column in the object 'y_train', from 'V1' to 'Code_Activity'
colnames(y_train) <- "Code_Activity"

X_train <- read.table("X_train.txt", header = FALSE)
View(X_train)
dim(X_train)
# To change the name of the columns, I have considered the name of the 2nd column of 'features' table
# to have the description names in the columns instead of 'V1', 'V2' and so on
colnames(X_train) <- features[,2]

subject_train <- read.table("subject_train.txt", header = FALSE)
View(subject_train)
dim(subject_train)
# change the name of the unique column 'V1' to 'Code_ID'
colnames(subject_train) <- "Code_ID"


# Reading the data Test
y_test <- read.table("y_test.txt", header = FALSE)
View(y_test)
# change the name of the name of the unic column in the object 'y_test', from 'V1' to 'Code_Activity'
colnames(y_test) <- "Code_Activity"

X_test <- read.table("X_test.txt", header = FALSE)
View(X_test)
dim(X_test)
# I do the same than 'X_train'. I change the name of the columns like 'features', insteado of have 'V1', 'V2' etc.
colnames(X_test) <- features[,2]

subject_test <- read.table("subject_test.txt", header = FALSE)
View(subject_test)
# change the name of the unique column 'V1' to 'Code_ID'
colnames(subject_test) <- "Code_ID"



## Question 1. Merges the training and the test sets to create one data set.
# Merge all the training set, with the function 'cbind()'
set_training <- cbind(y_train, X_train, subject_train)
View(set_training)
dim(set_training)

# Merge all the test set, as well with the function 'cbind()'
set_test <- cbind(y_test, X_test, subject_test)
View(set_test)
dim(set_test)

# Merge both sets 'set_test' and 'set_training' in one global Data Set with the function 'rbind()'
Data_Set <- rbind(set_test, set_training)
View(Data_Set)
dim(Data_Set)


## Question 2.Extracts only the measurements on the mean and standard deviation for each measurement.
selection_mean_std <- features[grep("mean\\(\\)|std\\(\\)", features[,2]), ]
View(selection_mean_std)
dim(selection_mean_std)

# now I have updated the Data_Set with the new object, that include the features like 'mean' and 'std'
Data_Set <- Data_Set[,selection_mean_std[,1]]
dim(Data_Set)
View(Data_Set)


## Question 3. Uses descriptive activity names to name the activities in the data set
Data_Set <- merge(Data_Set, activity_labels, by.x = "Code_Activity", by.y = "Code_Activity")
dim(Data_Set)
# The new column by 'Activity_type' added is the end of the 'Data_Set', I have move it to the begining
Data_Set <- Data_Set %>% select(Activity_type, everything())


## Question 4. Appropriately labels the data set with descriptive variable names
# the names of the columns that we have in the Data_Set are the following
names(Data_Set)
# In the begining of each name by columns, there are charactar like 't' and 'f'
# The meaning of these characteres are 'Time' and 'Frequency'
# As well the characteres like 'mean', 'std', and 'correlation', which meaning is about a specific result
# In this case I have change thise format to a capital letters like MEAN, STD and CORRELATION
names(Data_Set) <- gsub("^t", "Time", names(Data_Set))
names(Data_Set) <- gsub("^f", "Frequency", names(Data_Set))
names(Data_Set) <- gsub("mean", "MEAN", names(Data_Set))
names(Data_Set) <- gsub("std", "STD", names(Data_Set))
names(Data_Set) <- gsub("correlation", "CORRELATION", names(Data_Set))
# Check the changes
names(Data_Set)


## Question 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Data_Set <- select(Data_Set, -Code_Activity)
Data_Tidy <- Data_Set %>% group_by(Activity_type) %>% summarize_each(funs(mean))
class(Data_Tidy)
dim(Data_Tidy)
View(Data_Tidy)
# Transponse the new 'Data_Tidy'
Data_Tidy <- t(Data_Tidy)
dim(Data_Tidy)
View(Data_Tidy)
# Write the new Data_Tidy in a file
write.table(Data_Tidy, file = "tidyData.txt", row.names = TRUE, col.names = TRUE)

