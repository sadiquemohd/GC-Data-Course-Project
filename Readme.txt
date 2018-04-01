run_analysis.R
---------------
run_analysis.R has the steps to tidy up the Wearable Monitored Human activity dataset

Pre-requisite : 
All the data set are  downloaded and unzipped and ready to load in the working directory
plyr package should be installed and loaded for using the Aggreate function 

First step - Merge training and test data set


All the Trainining and Test data sets are loaded in to Data Frame Objects

Combine Training and Test datasets for Subjects, Activities and Features

Set the column names for Subject and Activity dataframes.  This will be used for picking up the descriptive column names

Extract the Mean and Standard Deviation columns from the feature names data set. 

Change the Mean and Standard Deviation columns name to a meaning ful name

Set the columns names for Features dataframes

Combined all the datafreames i.e Subject  + Activity + Feature to forma combined data frame

Load the Activity lables 

Factorize the activity  with Activity labels 



Now the full data frame is created , aggregate the full data frame on Subject and Activity to find mean of all

Write  the tidied set to a .csv file, this is the final data set.