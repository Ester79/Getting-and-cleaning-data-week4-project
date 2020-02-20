### Title: Getting and Cleaning Data_Week 4 Assignment
Author: Ester Ramos

### **Code Book Description**
Human Activity Recognition Using Smartphones Dataset

#### Data source
This is the data source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and
here we can find the description of the dataset http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


**The data set have included these files**
'README.txt'
'features_info.txt': Shows information about the variables used on the feature vector.
'features.txt': List of all features.
'activity_labels.txt': Links the class labels with their activity name.
'train/X_train.txt': Training set.
'train/y_train.txt': Training labels.
'test/X_test.txt': Test set.
'test/y_test.txt': Test labels.

**Description of each file**
'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


####**Objectives and information of in the script**
**1.	Merges the training and the test sets to create one data set**
Loaded the files. Some names of columns were changed before the merge
Then merge them with the cbind() and rbind() function.


**2.	Extracts only the measurements on the mean and standard deviation for each measurement**
Extracted only the measurements of 'mean' and 'std' from the 'features' file.
Then updated the file created before. 
Functions used, 'grep()' 


**3.	Uses descriptive activity names to name the activities in the data set**
Were merged the file 'activity_labels' with the data frame created before. The field in common was 'code_activity'
Some adjustment moving the last column added to the begining to have the file more clear. 
Functions used 'merge()', 'select()' and 'everything()'


**4.	Appropriately labels the data set with descriptive variable names**
Were reviewed the names of the columns and replaced the the 't' by 'Time', 'f' by 'Frequency' and changed to capital letters 'mean', 'std' and 'correlation' in order to have the data frame more easier to read. 
Functions used 'gsub()' and some regular expression


**5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
Calculated the mean by each variable and grouped by type of activity. Then writed an output to the local file with the name tidiData, format .txt
Functions used 'select()', 'groug.by()', 't()', 'write.table()'





 

