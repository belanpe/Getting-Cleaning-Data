##Coursera course: "Getting and Cleaning Data"

###Contents:
1. run_analysis.R: Instructions to retrieve a dataset in Zip file format, perform various operations on it, then create a tidy data set
  1. Edit these 4 parameters in 'run_analysis.R' file:
    1. inUrl: 		  URL of the source dataset
    2. workDir:  	  Root directory for the data cleaning work (initial value: "d:\\\\data")
    3. destFile: 	  Name of the source file, local to your computer (inital value: "\\\\Dataset.zip")
    4. stagingDir: 	Path value where data for processing is found (initial value: "\\\\UCI HAR Dataset\\\\")
    5. outFile:     Name of the file in which to write results (initial value: "\\\\tidyData.txt")
  2. Run the analysis in R as follows, where 'd:\\\\data' is the path where the run_analysis.R file is located:
  3. > source("d:\\\\data\\\\run_analysis.R")
  4. Note the double-backslash is for Windows compatible environment; running the script on Linux or MacOS, you'll need to use the traditional slash (ie, '/').
2. tidyData.txt: Formatted results, spreadsheet-ready, resulting from the script operation
3. CodeBook.md: Information about the variables, data and transformation to achieve the results displayed in 'tidyData.txt'
