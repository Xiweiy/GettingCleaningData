##setup step: read the datasets in 

##from their README.TXT document in the folder, we know that 
	##x_test are the 561-dimensional vector that contain all the measurements for test group
	##y_test are the test labels (what activities they performed)
	##subject_test are the identity of the experimental subjects (who performed the specific activity )
	x_test = read.table("./test/X_test.txt")   ##though read.table() is a bit slow, fread() crashes always
	y_test = read.table("./test/y_test.txt")
	subject_test= read.table("./test/subject_test.txt")
	##similar content for train datasets
	x_train = read.table("./train/X_train.txt")
	y_train = read.table("./train/y_train.txt")
	subject_train= read.table("./train/subject_train.txt")

##step 1: merge the training datasets and test datasets into 1 dataset
	##merge the test dataset
	test = cbind(subject_test, y_test,x_test)
	colnames(test)[1:2] = c("subject","activity")
	##merge the train dataset
	train = cbind(subject_train, y_train,x_train)
	colnames(train)[1:2] = c("subject","activity")
	
	##merge test and train datasets together
	mergedata = merge(train,test,all=TRUE)

##Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
	##I decided to uee the some of the variables (tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyGyro-XYZ) as the measurements to be extracted.
	mergedata = mergedata[,c(1:8,43:48,123:128)]

##step 3: Uses descriptive activity names to name the activities in the dataset
	##According to the activity_labels.txt document, the detailed description of each activity levels is as below
	##1 WALKING
	##2 WALKING_UPSTAIRS
	##3 WALKING_DOWNSTAIRS
	##4 SITTING
	##5 STANDING
	##6 LAYING
	mergedata$activity =  factor(mergedata$activity, levels = c(1,2,3,4,5,6),labels = c("WALKING","WALKING_UPSTIARS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

##step 4: Appropriately labels the dataset with descriptive variable name
	##Column 3-5 are the means of signals of body acceleration on x/y/z axis
	##Column 6-8 are the standard deviations of signals of body acceleration on x/y/z axis
	##Column 9-11 are the means of signals of gravity acceleration on x/y/z axis
	##Column 12-14 are the standard deviations of signals of gravity acceleration on x/y/z axis
	##Column 15-17 are the means of signals of body angular velocity from gyroscope on x/y/z axis
	##Column 18-20 are the standard deviations of signals of body angular velocity from gyroscope on x/y/z axis
	colnames(mergedata)[3:20]=c("BodyAccelerationMean_X", "BodyAccelerationMean_Y", "BodyAccelerationMean_Z","BodyAccelerationStd_X","BodyAccelerationStd_Y","BodyAccelerationStd_Z","GravityAccelerationMean_X","GravityAccelerationMean_Y","GravityAccelerationMean_Z","GravityAccelerationStd_X","GravityAccelerationStd_Y","GravityAccelerationStd_Z","BodyAngularVelocityMean_X","BodyAngularVelocityMean_Y","BodyAngularVelocityMean_Z","BodyAngularVelocityStd_X","BodyAngularVelocityStd_Y","BodyAngularVelocityStd_Z") 
	
##step 5: From the dataset in step 4, creates a second independent tidy dataset with the average of each variable for each activity and each subject
	##In step 4, we have 30 subject, 6 activity levels, and 18 variables. To create the dataset with average of each variable for each subject-activity combinations, we will finally get a dataset that has shape 180*18. 180 is the number of subject-activity combinations (30*6), and 20 is the 18 variables + subject&activity columns.
	library(dplyr)
	newdata = group_by(mergedata,subject,activity)
	tidydata = summarize(newdata,BodyAccelerationMean_X = mean(BodyAccelerationMean_X),BodyAccelerationMean_Y = mean(BodyAccelerationMean_Y), BodyAccelerationMean_Z = mean(BodyAccelerationMean_Z),BodyAccelerationStd_X = mean(BodyAccelerationStd_X), BodyAccelerationStd_Y = mean(BodyAccelerationStd_Y),BodyAccelerationStd_Z = mean(BodyAccelerationStd_Z),GravityAccelerationMean_X = mean(GravityAccelerationMean_X), GravityAccelerationMean_Y = mean(GravityAccelerationMean_Y), GravityAccelerationMean_Z = mean(GravityAccelerationMean_Z), GravityAccelerationStd_X = mean(GravityAccelerationStd_X), GravityAccelerationStd_Y = mean(GravityAccelerationStd_Y), GravityAccelerationStd_Z = mean(GravityAccelerationStd_Z), BodyAngularVelocityMean_X = mean(BodyAngularVelocityMean_X), BodyAngularVelocityMean_Y = mean(BodyAngularVelocityMean_Y), BodyAngularVelocityMean_Z = mean(BodyAngularVelocityMean_Z), BodyAngularVelocityStd_X = mean(BodyAngularVelocityStd_X), BodyAngularVelocityStd_Y = mean(BodyAngularVelocityStd_Y), BodyAngularVelocityStd_Z= mean(BodyAngularVelocityStd_Z))
	
	
	##Alternative way to do that - melt and cast
	library(reshape2)
	meltdata = melt(mergedata, id = c("subject","activity"))
	dcastdata = dcast(meltdata, value ~ variable, fun.aggregate = mean)	
	##both way successfully generate our tidy dataset.

##Final step: export the tidy dataset
	write.table(dcastdata,"tidy dataset.txt",row.name=F)