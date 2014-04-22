#########
## Please read README.md to understand all the steps
## from 1 to 9
#########

###### 1
#set the working directory
#to the directory UCI HAR Dataset
setwd("UCI HAR Dataset")

###### 2
#load the datasets
trainingDS<-read.table("train/X_train.txt")
testingDS<-read.table("test/X_test.txt")
trainingActivities<-read.table("train/y_train.txt")
testingActivities<-read.table("test/y_test.txt")
features<-read.table("features.txt")[,2]
trainingSubjects<-read.table("train/subject_train.txt")
testingSubjects<-read.table("test/subject_test.txt")

###### 3
#change the names
names(trainingDS)<-features
names(testingDS)<-features
names(trainingActivities)<-c("activityLabel")
names(testingActivities)<-c("activityLabel")
names(trainingSubjects)<-c("subject")
names(testingSubjects)<-c("subject")

#It is not really clear if only these data sets should be merged
#or if the other measurements datasets (such as the inertial signals)
#should be merged too
#I assumed we only care about these ones in this assessment, as
#its purpose is to test our basic R skills with merge, bind etc.

###### 4
#merge the datasets
mergedDS<-rbind(trainingDS,testingDS)
mergedActivities<-rbind(trainingActivities,testingActivities)
mergedSubjects<-rbind(trainingSubjects,testingSubjects)

###### 5
#keep only the mean and std measurements
#in features_info.txt it is said the mean and standard deviation
#are among the measurements containing
#"mean()": Mean value
#"std()": Standard deviation
meanOrStdIndexes<-grepl("std|mean",features)
meanOrStdDS<-mergedDS[,meanOrStdIndexes]

###### 6
#load the activities
activities<-read.table("activity_labels.txt")
#here we'll rename the activities numbers by descriptive labels
#found in the file activity_labels.txt
for(i in 1:dim(activities)[1]){
  activityName<-as.character(activities[i,2])
  mergedActivities[mergedActivities==activities[i,1]]<-activityName
}

###### 7
#final data set before averaging 
globalDS<-cbind(mergedDS,mergedActivities,mergedSubjects)

###### 8
#create independant data set with average of each variable
#for each subject and activity
tidyAverageDS <- aggregate(globalDS[,1:(ncol(globalDS)-2)], 
                     by =list(globalDS[,"subject"],globalDS[,"activityLabel"]), 
                     FUN = mean, na.rm = TRUE)
names(tidyAverageDS)[c(1,2)]<-c("subject","activityLabel")

###### 9
#saves the tidy data set expected
write.table(tidyAverageDS, "tidyAverageDS.txt", sep="\t")
