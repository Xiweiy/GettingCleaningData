#####1. The descriptive variable names have full description as below:
	subject - the identity of the experimental subject who carry the device and perform the activities
	activity - the different levels of activities performed by the subjects 
	BodyAccelerationMean_X - the means of signals of body acceleration on x axis
	BodyAccelerationMean_Y - the means of signals of body acceleration on y axis
	BodyAccelerationMean_Z - the means of signals of body acceleration on z axis
	BodyAccelerationStd_X - the standard deviations of signals of body acceleration on x axis
	BodyAccelerationStd_Y - the standard deviations of signals of body acceleration on y axis
	BodyAccelerationStd_Z - the standard deviations of signals of body acceleration on z axis
	GravityAccelerationMean_X - the means of signals of gravity acceleration on x axis
	GravityAccelerationMean_Y - the means of signals of gravity acceleration on y axis
	GravityAccelerationMean_Z - the means of signals of gravity acceleration on z axis
	GravityAccelerationStd_X - the standard deviations of signals of gravity acceleration on x axis
	GravityAccelerationStd_Y - the standard deviations of signals of gravity acceleration on y axis
	GravityAccelerationStd_Z - the standard deviations of signals of gravity acceleration on z axis	
	BodyAngularVelocityMean_X - the means of signals of body angular velocity from gyroscope on x axis
	BodyAngularVelocityMean_Y - the means of signals of body angular velocity from gyroscope on y axis
	BodyAngularVelocityMean_Z - the means of signals of body angular velocity from gyroscope on z axis
	BodyAngularVelocityStd_X - the standard deviations of signals of body angular velocity from gyroscope on x 
	BodyAngularVelocityStd_Y - the standard deviations of signals of body angular velocity from gyroscope on y
	BodyAngularVelocityStd_Z - the standard deviations of signals of body angular velocity from gyroscope on z


#####2. My work to clean up the dataset and create the 2nd independent tidy dataset is as follows:
	1) Read in the datasets contained in documents "X_test.txt","y_test.txt","subject_test.txt",  
"X_train.txt","y_train.txt","subject_train.txt"
	2) create 2 datasets: train and test. Each contain the subject, activity, and the 561-dimensional  
vectors for either the training dataset or the test dataset.
	3) merge these 2 datasets by subject and activity.
	4) select the specific variables that are direct measurements from the accelerometer and gyroscope.  
(The reason why chose these variables is stated in part 3 and 4)
	5) Use descriptive name for both the activity levels and all the variables
	6) For each subject-activity combination, calculate the average of each variable and create a   
new dataset based on that. This step can be approached by two different strategies:   
(a) use the"group_by" and "summarize" function in dplyr package,  
(b) use the "melt" and "dcast" functions in the reshape2 package. Both leads to the same tidy dataset at the end.
		
#####3. Why chose these specific variables?
	As according to their README.TXT document, “Using its embedded accelerometer and gyroscope,  
we captured 3-axial linear acceleration and 3-axial angular velocity”. 
	And according to the features_info.txt document, we can learn that the raw signals were   
filtered and noise was removed. Then the acceleration signal was separated into tBodyAcc-XYZ and   
tGravityAcc-XYZ. And, inferred by the naming rule, the tBodyGyro-XYZ variables should be the direct   
measurements from the gyroscope(though not explicitly written in the documentation). So I decided  
to uee the above-mentioned variables (tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyGyro-XYZ) as the measurements to be extracted.
	According to the features.txt document, we can find the indices of the mean and std   
of the variables of interest, which are 1-6, 41-46, 121-126

#####4. What about the rest of the variables?
	According to the features_info.txt document, the Jerk signals(tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ) and the Magnitude values(tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag) were derived from the body linear acceleration and augular velocity, so I did not count they as direct measurements to be extracted. Similarly, the fourier transform signals are just using another coordinate systems used, and is also derived rather than directly measured. 
	So I did not include any of the above-mentioned variables in my tidy dataset.

