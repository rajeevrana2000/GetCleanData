######################################################################################################### 
## Coursera Getting and Cleaning Data Course Project 

# runAnalysis.r File Description: 
# This R script does following steps on the UCI HAR Dataset 
# Download source
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
# 1. Merge the training and the test sets to create one data set. 
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive activity names to name the activities in the data set 
# 4. Appropriately label the data set with descriptive activity names.  
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

########################################################################################################## 
# 1. Merge the training and the test sets to create one data set. 

#set working directory to the location where the UCI HAR Dataset was unzipped 
setwd('C://RajeevR/Coursera/Getting And Cleaning Data/Week 3 Project/UCI HAR Dataset'); 

# Read in the data from files 
features     = read.table('./features.txt',header=FALSE);
activityType = read.table('./activity_labels.txt',header=FALSE);  
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
xTrain       = read.table('./train/x_train.txt',header=FALSE); 
yTrain       = read.table('./train/y_train.txt',header=FALSE); 

# Assign column names to imported data - Training
colnames(activityType)  = c('activityId','activityType'); 
colnames(subjectTrain)  = "subjectId"; 
colnames(xTrain)        = features[,2];  
colnames(yTrain)        = "activityId"; 

# Create the final training set by merging yTrain, subjectTrain, and xTrain 
training_Data = cbind(yTrain,subjectTrain,xTrain); 

# Read in the test data 
subjectTest = read.table('./test/subject_test.txt',header=FALSE);
xTest       = read.table('./test/x_test.txt',header=FALSE);
yTest       = read.table('./test/y_test.txt',header=FALSE);

# Assign column names to imported data - Test
colnames(subjectTest) = "subjectId"; 
colnames(xTest)       = features[,2];  
colnames(yTest)       = "activityId"; 

# Create the final test set by merging the xTest, yTest and subjectTest data 
test_Data = cbind(yTest,subjectTest,xTest);  

# Combine training and test data to create a final data set 
final_Data = rbind(training_Data,test_Data); 

# Create a vector for the column names from the finalData 
col_Names  = colnames(final_Data);  

# 2. Extracts the measurements on the mean and standard deviation for each measurement.

# Create a Vector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others 
logical_Vector = (grepl("activity..",col_Names) | grepl("subject..",col_Names) | grepl("-mean..",col_Names) & !grepl("-meanFreq..",col_Names) & !grepl("mean..-",col_Names) | grepl("-std..",col_Names) & !grepl("-std()..-",col_Names)); 

# Subset finalData table based on the logical_Vector to keep only desired columns 
final_Data = final_Data[logical_Vector==TRUE]; 

# 3. Use descriptive activity names to name the activities in the data set 

# Merge the finalData set with the acitivityType table to include descriptive activity names 
final_Data = merge(final_Data,activityType,by='activityId',all.x=TRUE); 

# Updating the colNames vector to include the new column names after merge 
col_Names  = colnames(final_Data);  

# 4. Label the data set with descriptive activity names.  

# Cleaning up the variable names 
for (i in 1:length(col_Names))  
{ 
  col_Names[i] = gsub("\\()","",col_Names[i]) 
  col_Names[i] = gsub("-std$","StdDev",col_Names[i]) 
  col_Names[i] = gsub("-mean","Mean",col_Names[i]) 
  col_Names[i] = gsub("^(t)","time",col_Names[i]) 
  col_Names[i] = gsub("^(f)","freq",col_Names[i]) 
  col_Names[i] = gsub("([Gg]ravity)","Gravity",col_Names[i]) 
  col_Names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",col_Names[i]) 
  col_Names[i] = gsub("[Gg]yro","Gyro",col_Names[i]) 
  col_Names[i] = gsub("AccMag","AccMagnitude",col_Names[i]) 
  col_Names[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",col_Names[i]) 
  col_Names[i] = gsub("JerkMag","JerkMagnitude",col_Names[i]) 
  col_Names[i] = gsub("GyroMag","GyroMagnitude",col_Names[i]) 
}; 

# Reassigning the new descriptive column names to the final_Data set 
colnames(final_Data) = col_Names;   

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

# Create a new table, finalDataNoActivityType without the activityType column 
finalDataNoActivityType  = final_Data[,names(final_Data) != 'activityType']; 

# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject 
tidy_Data    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean); 

# Merging the tidyData with activityType to include descriptive acitvity names 
tidy_Data    = merge(tidy_Data,activityType,by='activityId',all.x=TRUE); 

# Export the tidyData set  
write.table(tidy_Data, './tidy_Data.txt',row.names=FALSE,sep='\t'); 
