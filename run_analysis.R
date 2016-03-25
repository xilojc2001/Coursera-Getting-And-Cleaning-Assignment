# Merges the training and the test sets to create one data set.

        #Read the train data from de x_train.txt
        trainData <- read.table("./data/train/X_train.txt")
        
        #Read the train labels from the y_train.txt
        trainLabel <- read.table("./data/train/y_train.txt")
        
        #Read the train subject
        trainSubject <- read.table("./data/train/subject_train.txt")
        
        #Read the test data from de x_train.txt
        testData <- read.table("./data/test/X_test.txt")
        
        #Read the test labels from the y_train.txt
        testLabel <- read.table("./data/test/y_test.txt") 
        
        #Read the test subject
        testSubject <- read.table("./data/test/subject_test.txt")
        
        #Merge the data frames of DATA
        mergeData <- rbind(trainData, testData)
        
        #Merge the data frames of LABELS
        mergeLabel <- rbind(trainLabel, testLabel)
        
        #Merge the data frames of SUBJECTS
        mergeSubject <- rbind(trainSubject, testSubject)


# Extracts only the measurements on the mean and standard deviation for each
# measurement. 

        #Read the Features      
        features <- read.table("./data/features.txt")
        
        #Clean Data Names
        meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
        mergeData <- mergeData[, meanStdIndices]
        names(mergeData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) 
        names(mergeData) <- gsub("mean", "Mean", names(mergeData)) 
        names(mergeData) <- gsub("std", "Std", names(mergeData)) 
        names(mergeData) <- gsub("-", "", names(mergeData)) 

# Uses descriptive activity names to name the activities in DS
     
        #Read activities labels
        activity <- read.table("./data/activity_labels.txt")
        
        #Clead Data
        activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
        substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
        substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
        activityLabel <- activity[mergeLabel[, 1], 2]
        mergeLabel[, 1] <- activityLabel
        names(mergeLabel) <- "activity"

# Appropriately labels the data set with descriptive activity names
        
        #Define the name of the vector cols
        names(mergeSubject) <- "subject"
        
        #Combine the data merged
        cleanedData <- cbind(mergeSubject, mergeLabel, mergeData)
        
        #Generate a phisycal file
        write.table(cleanedData, "data_merged.txt") 

# Creates a second data set with the average of each var for each activity 
# and each subject.

        #Identify the subject length
        subjectLen <- length(table(mergeSubject)) 
        
        #Identify the activity length
        activityLen <- dim(activity)[1]
        columnLen <- dim(cleanedData)[2]
        
        #Define a Matrix for storing
        result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
        result <- as.data.frame(result)
        colnames(result) <- colnames(cleanedData)

        #Fill the matrix
        row <- 1
        for(i in 1:subjectLen) {
                for(j in 1:activityLen) {
                        result[row, 1] <- sort(unique(mergeSubject)[, 1])[i]
                        result[row, 2] <- activity[j, 2]
                        bool1 <- i == cleanedData$subject
                        bool2 <- activity[j, 2] == cleanedData$activity
                        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
                        row <- row + 1
                }
        }

        #Generate a phisycal file
        write.table(result, "data_with_means.txt", row.names = FALSE) 