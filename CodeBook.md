##Coursera: Getting & Cleaning Data
###Course Project 
Oct 25, 2014

##CodeBook - Acceleration and Gyroscopic study

###Description: 
Accelerometer and Gyroscopic measurements for a sample of 30 subjects performing 6 distinct activities (for a total of 180 rows).
These measurements are averages of means and standard deviations of linear acceleration and angular velocity, in 3 axis for each of these metrics. This yields 12 values per activity.

###Variables:

Mean X-axis Acceleration: 
	Purpose:	Mean X-axis acceleration reading
	Data Type: 	Double
	Range:		-1.0:1.0
Mean Y-axis Acceleration:
	Purpose:	Mean Y-axis acceleration reading
	Data Type: 	Double
	Range:		-1.0:1.0
Mean Z-axis Acceleration:
	Purpose:	Mean Z-axis acceleration reading
	Data Type: 	Double
	Range:		-1.0:1.0
X-axis Acceleration Standard Deviation:
	Purpose:	Std Deviation of X-axis acceleration
	Data Type: 	Double
	Range:		-1.0:1.0
Y-axis Acceleration Standard Deviation:
	Purpose:	Std Deviation of Y-axis acceleration
	Data Type: 	Double
	Range:		-1.0:1.0
Z-axis Acceleration Standard Deviation:
	Purpose:	Std Deviation of Z-axis acceleration
	Data Type: 	Double
	Range:		-1.0:1.0
Mean X-axis Angular Velocity:
	Purpose:	Mean X-axis angular velocity reading
	Data Type: 	Double
	Range:		-1.0:1.0
Mean Y-axis Angular Velocity:
	Purpose:	Mean Y-axis angular velocity reading
	Data Type: 	Double
	Range:		-1.0:1.0
Mean Z-axis Angular Velocity:
	Purpose:	Mean Z-axis angular velocity reading
	Data Type: 	Double
	Range:		-1.0:1.0
X-axis Angular Velocity Standard Deviation:
	Purpose:	Std Deviation of X-axis angular velocity
	Data Type: 	Double
	Range:		-1.0:1.0
Y-axis Angular Velocity Standard Deviation:
	Purpose:	Std Deviation of Y-axis angular velocity
	Data Type: 	Double
	Range:		-1.0:1.0
Z-axis Angular Velocity Standard Deviation:
	Purpose:	Std Deviation of Z-axis angular velocity
	Data Type: 	Double
	Range:		-1.0:1.0
Activity:
	Purpose:	Activity being performed
	Data Type: 	String
	Range:		WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
Subject:
	Purpose:	Subject ID
	Data Type: 	Integer
	Range:		1:30

###Data:

Measurements (other than Activity and Subject) consist of the average (mean) and standard deviations of both linear acceleration and angular velocity recorded from a smartphone, in all 3 axis (X, Y, and Z).  This produces 12 variables per activity, per subject.

**NOTE:**
For the purpose of the exercise, means and std devs for linear acceleration and angular acceleration were extracted exclusively: it is not necessary to extract other means & std deviations as they are derived or transformed from these master values.
	
###Transformations:
1. A Zip-compressed file was retrieved from the URL
  1. https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. The contents were extracted using the unzip command
3. The measurements (Test and Training data except activity and subject ID) were bound on rows
4. The linear mean and standard deviation accelerations, as well as angular mean and standard deviations were subset using 'grep' commands to target exclusively this information
5. Labels were added to the measurements using the 'colnames' command
6. The activity and subject information was added to the subset, using an 'rbind' operation and column name identifiers for each prior to bind these 2 items to the subset created in 4.
7. An 'aggregate' operation was performed to group the subset data into activities for each of the subjects, calculating the mean value for each of the 12 measurements, per activity and subject
8. The activity code was replaced with a significant activity name with a 'factor' command.
9. The resulting tidy data was written to a text file, for distribution, using the 'write.table' function
