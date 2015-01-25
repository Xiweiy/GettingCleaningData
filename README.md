# GettingCleaningData

1. What directory structure is my code based on?
#	I downloaded the "UCI HAR Dataset", and use that as my working directory. And I also keeps the subdirectory "test" and "train" without moving any of the document.
	
2. Why my dataset uploaded is tidy?
#	According to the definition of tidy dataset, each row represent a single observation, and each column represent a single variable. In my final version of dataset, each row stands for a differet subject-activity combination, and each column is a variable of interest.
	
3. Why are the descriptive names descriptive?
#	For the activity names, I used what is already written in their activity_labels.txt document.
#	For the variable names, I simply describe what the variable stands for and shorten the description a little bit. For example, tBodyAcc-Mean()-X stands for "the mean of the body acceleration signal on x-axis", and I named that column as "BodyAccelerationMean-X", which apprently announce what the variable is about.
For more detailed explanation of each variable name, please read the "CodeBook.md" document. And the code book also explains the reason why I chose these specific variables to extract.
	
