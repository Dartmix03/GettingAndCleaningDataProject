
### 
#All data Saved

X_test <- read.table("test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("test/y_test.txt", quote="\"", comment.char="")
subject_test <- read.table("~/Desktop/WorkingDirectory/test/subject_test.txt", quote="\"", comment.char="")

X_train <- read.table("~/Desktop/WorkingDirectory/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("~/Desktop/WorkingDirectory/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("~/Desktop/WorkingDirectory/train/subject_train.txt", quote="\"", comment.char="")

features <- read.table("features.txt", quote="\"", comment.char="")
###

#####################$$$$$$##################

###
#4 Appropriately labels the data set with descriptive variable names and
# First step to 1. Merge the training and the test sets to create one data set.  Merge the Xs and Subjects
####

names(subject_train)<-"Subject"

X_data<-rbind(X_test,X_train)
names(X_data)<-features$V2

Subject_data<-rbind(subject_test,subject_train)
names(Subject_data)<-"Subject"

###

#####################$$$$$$##################

###
# Second step to 1. Merge the training and the test sets to create one data set. Merge the ys.
# 3 Give Descriptive names to activities and label variable. 

t1= rbind(y_test,y_train)  #Note: Test data before train data

names(t1)<-"Activity"
t1$t2=gsub(1,"WALKING",t1$Activity)
t1$t3=gsub(2,"WALKING_UPSTAIRS",t2)
t1$t4=gsub(3,"WALKING_DOWNSTAIRS",t3)
t1$t5=gsub(4,"SITTING",t4)
t1$t6= gsub(5,"STANDING",t5)
t1$t7 = gsub(6,"LAYING",t6)
names(t1)[7]<-"DesciptiveActivity"

t1<-t1[-c(2:6)]
#View(t1)
#t1$DesciptiveActivity
###

#####################$$$$$$##################


###
# 1 Merge Data
# Final step to 1.Merge the training and the test sets to create one data set.  Merge all columns


alldata<-cbind(X_data,t1,Subject_data)  
#Note:  Last column is subject, 
#second to last column is descriptive activity, 
#third to last column is original activity.

#summary(alldata$Subject)
#summary(alldata$DesciptiveActivity)
alldata$DesciptiveActivity<-as.factor(alldata$DesciptiveActivity)
#alldata$DesciptiveActivity[4]
#summary(alldata$DesciptiveActivity)
###




###2  
# For each activity calculate the mean and standard deviation.  Note the last 3 columns are not activities
n<-length(alldata)
means<-c()
sds<-c()
for(i in 1:(n-3)){
x<-alldata[i]
means<-c(means, sum(x)/length(x))
}





### Build another tidy data set.
#### Rows are measurements
#### Columns are 6Activities and then 30 Subjects


a1<-subset(alldata[1:(n-3)],alldata$Activity==1)


means=c()
for(i in 1:length(a1)){
  means=c(means, sum(a1[i])/length(a1[i]))
}

tidy=data.frame(means)  #Start the dataframe with 561 rows.  First column is the means for activity 1

for( j in 2:6){   #ADD activities 2-4
means=c()
aj<-subset(alldata[1:(n-3)],alldata$Activity==j)

for(i in 1:length(aj)){
means=c(means, sum(aj[i])/length(aj[i]))
}
tidy[j]<-means
}

l<-min(Subject_data)
h<-max(Subject_data)
## Repeat with subjects
for( j in l:h){   #ADD subjects 1-30
  means=c()
  aj<-subset(alldata[1:(n-3)],alldata$Subject==j)
  
  for(i in 1:length(aj)){
    means=c(means, sum(aj[i])/length(aj[i]))
  }
  tidy[j+6]<-means   #first 6 columns are used for activities
}


#### GIVE GOOD COLUMN NAMES

names(tidy)[1]<-"WALKING"
names(tidy)[2]<-"WALKING_UPSTAIRS"
names(tidy)[3]<-"WALKING_DOWNSTAIRS"
names(tidy)[4]<-"SITTING"
names(tidy)[5]<-"STANDING"
names(tidy)[6]<-"LAYING"

SubjectID=1:30
for(i in 1:30){
  SubjectID[i]<- paste("Subject", i, sep = " ")
}
SubjectID

for(i in 7:36){names(tidy)[i]<-SubjectID[i-6]}



write.table(tidy, sep = ",", "tidydata.csv", row.name=FALSE ) 

