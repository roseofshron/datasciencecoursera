# README
### So, the goal here to take the data in various files in the UCI HAR Dataset and produce one tidy data set showing the averages of certain measurements (those which themselves are means, or standard deviations) done in this study, broken down by activity and subject. 
#### In other words:  You should create one R script called run_analysis.R that does the following. 
#### 1. Merges the training and the test sets to create one data set.
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#### 3. Uses descriptive activity names to name the activities in the data set
#### 4. Appropriately labels the data set with descriptive variable names. 
#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
####  First of all, my code assumes your working directory is in the UCI HAR Dataset folder, with no changes made to it.
#### It starts by loading the dplyr and tidyr libraries. 
#### For Step 1 (Merge the training and the test sets to create one data set), I start by reading the testing and training data, and adding the column variable names (with Step 4 in mind). The description of what these mean is in the code book. Then I combine them to create one data frame with both testing and training data sets with column names. 
#### Step 2 (Extracts only the measurements on the mean and standard deviation for each measurement). I decided to only include those measurements that were the means and standard deviations of other measurements, therefore, those that contained mean() and std() at the end. I did this with dplyr, creating one data frame of 48 columns.
#### Step 3 (Uses descriptive activity names to name the activities in the data set). I extracted and combined the activity and subject information for both test and train data, being careful to do so in the same order as Step 1, and gave them column names. Then, I converted all the numbers in the Activity column to the descriptions of the Activity (Walking Upstairs, etc.). Then I put it all together.
#### Step 4 (Appropriately labels the data set with descriptive variable names.) Already done in the first step. Booyah. 
#### Step 5 (From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.) I use the aggregate function to do just that, and write it to a file named "tidy.txt". 
## All done!