library(data.table) 
###read in the static label data 

ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
Features <- read.table("UCI HAR Dataset/features.txt")

###read in the training and test measures

TrainingSet <- read.table("UCI HAR Dataset/train/X_train.txt")
TrainingActivity <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors=FALSE)
TrainingSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
TestSet <- read.table("UCI HAR Dataset/test/X_test.txt")
TestActivity <- read.table("UCI HAR Dataset/test/y_test.txt")
TestSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

#add the column names to the Training Data
colnames(TrainingSet) <- as.character(Features[,2])
colnames(TrainingSubject) <- "Subject"
colnames(TrainingActivity) <- "Activity"
colnames(TestSet) <- as.character(Features[,2])
colnames(TestSubject) <- "Subject"
colnames(TestActivity) <- "Activity"


###Extract only columns with Mean and Standard Deviations
MeanTestSet <- TestSet[,grepl("mean",colnames(TestSet))]
StdTestSet <- TestSet[,grepl("std", colnames(TestSet))]
MeanTrainingSet <- TrainingSet[,grepl("mean",colnames(TrainingSet))]
StdTrainingSet <- TrainingSet[,grepl("std", colnames(TrainingSet))]

TestSet <- cbind(MeanTestSet, StdTestSet)
TrainingSet <- cbind(MeanTrainingSet, StdTrainingSet)

###Bind the Training data with Subject and Activity columns together
NewTrainingSet <- cbind(TrainingSet, TrainingSubject)
FinalTrainingSet <- cbind(NewTrainingSet, TrainingActivity)
NewTestSet <- cbind(TestSet, TestSubject) 
FinalTestSet <- cbind(NewTestSet, TestActivity)

###combine the completed tidy data set of Smart phone data measures Using Rbind
### Name the completed Tidy data set something readable

SmartPhoneData <- rbind(FinalTrainingSet, FinalTestSet)

###Now convert the Activity levels to their more readable Activity Labels
for (i in 1:nrow(SmartPhoneData)){
  SmartPhoneData$Activity[i] <- ActivityLabels[SmartPhoneData$Activity[i],2]
}

###########################Calculate the Averages for each Activity by Subject########################

ActivitySubject <- split(SmartPhoneData, list(SmartPhoneData$Activity, SmartPhoneData$Subject))
AverageByActivitySubject <- sapply(ActivitySubject, function(x) colMeans(x[,1:79]), simplify=TRUE)


######################Write the Data Set to CSV Files############################################

write.csv(AverageByActivitySubject, "SmartPhoneDatabyActivitySubject.csv")




