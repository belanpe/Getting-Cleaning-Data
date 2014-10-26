#
# R script to parse a large data set and produce a tidy data set
# 
# Script Parameters:
# inUrl: 		URL of the source dataset
# workDir:  	Root directory for the data cleaning work
# destFile: 	Name of the source file local to your computer
# stagingDir: 	Path value where data for processing is found
#

#  Initial capture data URL
inUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#  Edit path for local staging area:
workDir="d:\\data"
#  Local file, source of analysis:
destFile=paste(workDir,"\\Dataset.zip",sep="")
#  Output file, for tidied data
outFile=paste(workDir,"\\tidyData.txt",sep="")
stagingDir=paste(workDir,"\\UCI HAR Dataset\\",sep="")
#  Retrieve the file:
download.file(inUrl,destfile = destFile)

if (file.exists(destFile)) {
	#  Extract its contents - this creates the 'Dataset' subfolder:
	unzip(destFile,exdir=workDir)
	#  Allocate contents:
	feats <- read.table(paste(stagingDir,"features.txt",sep=""))
	#  dim: 561x2 - features
	activityLabels <- read.table(paste(stagingDir,"activity_labels.txt",sep=""))
	#  dim: 6x2 - activity labels
	xTest <- read.table(paste(stagingDir,"test\\X_test.txt",sep=""))
	#  dim: 2947x561 - test metrics
	yTest <- read.table(paste(stagingDir,"test\\y_test.txt",sep=""))
	#  dim: 2947x1 - test activities (1-6)
	sTest <- read.table(paste(stagingDir,"test\\subject_test.txt",sep=""))
	#  dim: 2947x1 - test subject IDs (1-24)
	xTrain <- read.table(paste(stagingDir,"train\\X_train.txt",sep=""))
	#  dim: 7352x561 - training metrics
	yTrain <- read.table(paste(stagingDir,"train\\y_train.txt",sep=""))
	#  dim: 7352x1 - training activities (1-6)
	sTrain <- read.table(paste(stagingDir,"train\\subject_train.txt",sep=""))
	#  dim: 7352x1 - training subject IDs (1-30)

	#  Setup libraries:
	library(plyr)
	library(dplyr)
	#----------------------------------------------
	#  Processing:
	#----------------------------------------------
	#  1. Merge data
	mergedData <- rbind(xTest,xTrain)
	#  dim: 10299x561

	#  1.1 Label merged data using the values (col. 2) of 'features.txt'
	#  Label data set - use feats (1..561)
	names(mergedData) <- feats[,2]

	#  2. Parse measurements: extract means and std devs for bodyAcc and GravityAcc
	#     It is not necessary to extract other means & std as they are derived or transformed from these master values.
	subSetData <- mergedData[,c(grep("tBodyAcc-mean",colnames(mergedData)),grep("tBodyAcc-std",colnames(mergedData)),grep("tBodyGyro-mean",colnames(mergedData)),grep("tBodyGyro-std",colnames(mergedData)))]
	# head(subSetData)
	#  Label data with significant names:
	cnames <- c("Mean X-axis Acceleration", "Mean Y-axis Acceleration", "Mean Z-axis Acceleration","X-axis Acceleration Standard Deviation","Y-axis Acceleration Standard Deviation", "Z-axis Acceleration Standard Deviation", "Mean X-axis Angular Velocity", "Mean Y-axis Angular Velocity", "Mean Z-axis Angular Velocity","X-axis Angular Velocity Standard Deviation","Y-axis Angular Velocity Standard Deviation","Z-axis Angular Velocity Standard Deviation")
	colnames(subSetData) <- cnames

	#  3. Add activity names on each observation:
	# Row-bind Activity & identify column:
	activityData <- rbind(yTest,yTrain); names(activityData) <- "Activity"
	# Row-bind Subject & identify column:
	subjectData <- rbind(sTest,sTrain); names(subjectData) <- "Subject"

	#  Update dataSet:
	dataSet <- cbind(subSetData,activityData,subjectData)

	#  5. Group data and report Mean:
	#  5.1 Group per subject ID, activity.
	#  5.2 Produce averages for metrics
	#  5.3 Strip 1st 2 columns (aggregate operations creates these)
	tidyData <- select(aggregate(dataSet,list(dataSet$Activity,dataSet$Subject),mean),-c(1:2))

	#  4. Label activity data set 
	# Convert the activity code to significant values; use values stored in activityLabels, in the 2nd column:
	tidyData$Activity = factor(tidyData$Activity,labels=activityLabels[,2] )
	
	#  5.4 Write to file:
	write.table(tidyData,file=outFile,row.name=FALSE)
}