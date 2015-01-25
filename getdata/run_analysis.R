# First of all, this assumes your working directory is in the UCI HAR Dataset folder, with no changes made to it.
# Setup up
library(dplyr)
library(tidyr)

# Step 1 - Merge the training and the test sets to create one data set.
features<-read.table("features.txt") # With Step 4 in mind, read the column names into an object
Xtest<-read.table("./test/X_test.txt", col.names = features$V2) # read the testing data and add column names of measured variables
Xtrain<-read.table("./train/X_train.txt", col.names = features$V2) # read the training data and add column names of measured variables
all<-rbind(Xtest, Xtrain) # Create a merged data frame of the test and train data sets. not so bad so far. 

# Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
# I decided to only include those measurements that were the means and standard deviations of other measurements,
# therefore, those that contained mean() and std() at the end (which wasn't how it looked when read into a table,
# it changed into "mean..". Coding is fun!)
# So, need to extract those columns, which I did with dplyr
alltbl<-tbl_df(all) # convert to dplyr
means<-select(alltbl, contains(".mean...")) # get columns that are means
stds<-select(alltbl, matches(".std...")) # get columns that are standard deviations
extracted<-cbind(means, stds) # combine to one data frame of just means and stds. 

# Step 3 - Uses descriptive activity names to name the activities in the data set
# I extracted and combined the activity and subject information for both test and train data. 
testlabels<-cbind(read.table("./test/Y_test.txt"), read.table("./test/subject_test.txt")) # get test activity and subject data
trainlabels<-cbind(read.table("./train/Y_train.txt"), read.table("./train/subject_train.txt")) # get train activity and subject data
alllabels<-rbind(testlabels, trainlabels) # put test and train sets together, being careful to do so in the same order as Step 1
colnames(alllabels)<-c("Activity", "Subject") # give them column names
allLabels<-tbl_df(alllabels) # convert to dplyr, for the good times. 
# Now, to convert the numbers in the Activity column to descriptions of the Activity
allLabels$Activity[allLabels$Activity == 1] = "Walking" # turning the 1 into Walking, and so on...
allLabels$Activity[allLabels$Activity == 2] = "Walking Upstairs"
allLabels$Activity[allLabels$Activity == 3] = "Walking Downstairs"
allLabels$Activity[allLabels$Activity == 4] = "Sitting"
allLabels$Activity[allLabels$Activity == 5] = "Standing"
allLabels$Activity[allLabels$Activity == 6] = "Laying"
everything<-cbind(extracted, allLabels) # Put everything together. Now, step 3 done. 

# Step 4 - Appropriately labels the data set with descriptive variable names. 
# Since I did that in the first step, its done. Booyah. 

# Step 5 - From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
almostthere<-aggregate(Everything, list(Activity = Everything$Activity, Subject = Everything$Subject), FUN = mean)
# This neat little function does the trick. 
write.table(almostthere, file = "tidy.txt", row.names = FALSE)
# as per instructions, write to a text file. WOO! All done!
