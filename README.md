# GetCleanData
Getting and Cleaning data Project Assignment Repository


#Part 1. Merge the training and the test sets to create one data set.
Set the source directory for the files abd read into tables
Data is provided in files -
features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt

Assign column names 
Merge to create one data set (final_Data)

#Part 2. Extract only the measurements on the mean and standard deviation for each measurement.
- Create a logical vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others. 
- Subset this data to keep only the necessary columns.

#Part 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to inlude the descriptive activity names

#Part 4. Label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

#Part 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
Per the project instructions, we need to produce only a data set with the average of each veriable for each activity and subject
Create tidy_data_final with row.name=FALSE
