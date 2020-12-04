
This contains the desciption of how the alalysis in run_analysis.R works to create the tidy dataset.

In lines 5-13 the data is loaded.

In lines 23-29 the descriptive variable names are loaded from the subject and features data.

In lines 39-50 the descriptive variable names are added for the 6 activities.

Lines 62 and 68 merge the data to one dataframe called "all data"

Lines 77-83 extracts only the measurements on the mean and standard deviation for each measurement.

Lines 94-143 create the tidy data set called "tidy".  
The 561 rows of 'tidy' are the means of the measurements.  
The first 6 columns are the activities.  The next 30 columns are the subjects

Lines 94-111 calculate and store the means for the activities

Lines 113-124 calculate and store the means for the subjects.

Lines 129-142 add the 36 column names.

