##Coursera-Peer-Assessment-Samsung
================================

###Final Project for "Getting and Cleaning Data" Course, offered by Coursera.

##R Script Details

The R script that is included, reads data from the UCI HAR Dataset directory, which includes the test and training measures gathered by the mobile devices.  It also grabs the static data, such as subject, activity and activity labels.

The script takes a series of steps to extract only the datapoints of interest (means and standard deviations) and then merge the datatets together first by columns (subject and activity) and then by rows (Training data sets + Testing data sets) to create one complete dataset called SmartPhoneData

After completing that task,  the script then takes the SmartPhoneData set and separates it by Activity within subjects so that it can calculate the averages of all measures.  Finally, it writes this tidy data set to a csv file.


