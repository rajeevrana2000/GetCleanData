# GetCleanData
Getting and Cleaning data Project Assignment Repository


# Part 1. Merge the training and the test sets to create one data set.
Set the source directory for the files abd read into tables

Read training data from files in variables- 
features    - Read and store feature data
activityType - Read and store activity type  
subjectTrain - Read and store subject Train 
xTrain      - Read and store xTrain 
yTrain      - Read and store y train 

training_Data - stores final training set of training data

Read and store Test Data

subjectTest - Read and store Subjet Test data
xTest      Read and store xTest
yTest      - Read and store y Test

test_Data- Stores final set of test Data

final_Data -Merge training and test data to create one data set (final_Data)
col_Names - vector for the column names from the final_Data


# Part 2. Extract only the measurements on the mean and standard deviation for each measurement.
logical_Vector - Vector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others 

- Subset this data to keep only the necessary columns.

# Part 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to inlude the descriptive activity names

# Part 4. Label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

# Part 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
finalDataNoActivityType - table, finalDataNoActivityType without the activityType column
tidy_Data- Tidy data set