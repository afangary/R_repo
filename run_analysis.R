### Get and Clean data course project - 
#####setwd("c:/studies/Get and Clean Data/WD")

#######------Step 1 Merge the training and the test sets to create one data set. -----

##-- Step 1.1 Read Data from Files
  #Read Subject Files
    SubjectTrain <- read.table("train/subject_train.txt") 
    SubjectTest <- read.table("test/subject_test.txt")
  #Read Activity Files
    TrainingLabels <- read.table("train/y_train.txt") 
    TestLables <- read.table("test/y_test.txt") 
  #Read Features Files
    TrainingFeat <- read.table("train/X_train.txt") 
    TestFeat <- read.table("test/X_test.txt") 
  #Read Feature names files
    FeatureNames <- read.table("features.txt")

##--Step 1.2-- Merge the training and test sets and name headers where required.
    #Bind & name headers of Feature sets
      FeatureData <- rbind(TrainingFeat, TestFeat)
      names(FeatureData) <- FeatureNames$V2

    #Bdind and name Subject Sets
      SubjectDS <- rbind(SubjectTrain, SubjectTest)
      names(SubjectDS) <- c("Subject")
    
    #Bind activity Labels Set
      LabelsDS <- rbind(TrainingLabels, TestLables)
 ##----------------------------------------------------------------------------------###

### --Step 2----Identify Columns with Mean / Standard (mean or std)
  #Extract names of cols only contraining mean and std
    FeatureNamesList <- FeatureNames$V2[grep("mean\\(\\)|std\\(\\)", FeatureNames$V2)]
    selectedNamesCols <- as.character(FeatureNamesList)
 
  # use Extracted Column list to subset the DF with only required columns.
     RequiredFeatureDS <- subset(FeatureData, select = selectedNamesCols)
  
    
#####--- STEP 3 --- 3.Uses descriptive activity names to name the activities in the data set
    #Read Activity labels File    
    ActivityLabelDS <- read.table("activity_labels.txt")
    #Properly name each activity (including remove "_", fix case
    ActivityLabelDS[, 2] <- gsub("_", " ", ActivityLabelDS[, 2])
    ActivityLabelDS[, 2] <- gsub("WALKING", "Walking", ActivityLabelDS[, 2])
    ActivityLabelDS[, 2] <- gsub("UPSTAIRS", "Upstairs", ActivityLabelDS[, 2])
    ActivityLabelDS[, 2] <- gsub("DOWNSTAIRS", "Downstairs", ActivityLabelDS[, 2])
    ActivityLabelDS[, 2] <- gsub("SITTING", "Sitting", ActivityLabelDS[, 2])
    ActivityLabelDS[, 2] <- gsub("STANDING", "Standing", ActivityLabelDS[, 2])
    ActivityLabelDS[, 2] <- gsub("LAYING", "Laying", ActivityLabelDS[, 2])
    
    #Bind the properly named labels to the Label Data set 
    LabelsDS[,1] = ActivityLabelDS[LabelsDS[,1], 2]
    names(LabelsDS) <- c("Activity")

#### merge subject 
#MasterDS  <- cbind(SubjectDS, LabelsDS)
#MasterDS <- cbind(MasterDS, FeatureData)

#### STep 4.--Appropriately labels the data set with descriptive variable names.
    names(RequiredFeatureDS) <- gsub("^t", "time", names(RequiredFeatureDS)) 
    names(RequiredFeatureDS) <- gsub("Acc", "Accelerometer", names(RequiredFeatureDS)) 
    names(RequiredFeatureDS) <- gsub("^f", "frequency", names(RequiredFeatureDS)) 
    names(RequiredFeatureDS) <- gsub("Gyro", "gyroscope", names(RequiredFeatureDS)) 

######5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  #Create new Tidy set with Subject, Activity and Required columns only
    CleanDS <- cbind(SubjectDS, LabelsDS, RequiredFeatureDS)
    #Get Average by each subject /activity combination
      AvgDF<-aggregate(. ~Subject + Activity, CleanDS, mean)
   
    #order DF by Subject then by Activity
      AvgDF<-AvgDF[order(AvgDF$Subject,AvgDF$Activity),]
    
    #Write Final DataFrame to file 
      write.table(AvgDF, file = "FinalClean.txt",row.name=FALSE)
     
