Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and any transformations or work that I did for cleaning up the data.  

* The data origin was:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* I got the data from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

* The file run_analysis.R performs the following procedure to clean the data:   
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in variables.       
 2. Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in variables as well.  
 3. Merge *testData* to *trainData* to generate a new data frame, *mergeData*
 4. Merge *testLabel* to *trainLabel* to generate new data frame, *mergeLabel*
 5. Merge *testSubject* to *trainSubject* to generate a new data frame, *mergeSubject*.  
 6. Read the features.txt file from the "/data" folder and store the data in a variable called *features*
 7. Extract the measurements on the mean and standard deviation. 
 8. Clean the column names of the subset.  (Remove spaces, symbols and put then on Title format)
 9. Read the activity_labels.txt file from the "./data"" folder and store the data in a variable called *activity*.  
 10. Clean the activity names. 
 
 11. Transform the values of *mergeLabel* according to the *activity* data frame.  
 12. Combine the *mergeSubject*, *mergeLabel* and *mergeData* by column to get a new data frame.
 13. Properly rename the columns, "subject" and "activity". 
 14. Generate the *cleanedData* on "data_merged.txt" file.  
 15. Generate a second file with the average of each measurement for each activity and each subject. 
 12. Write the *result* out to "data_with_means.txt" file. 
