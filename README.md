# PathToTidyData

#Production of a clean dataset from the Human Activity Recognition Using Smartphones Dataset



This repository contains artefacts that indicate how to obtain a tidy data set out of the data at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Included  are:
- run_analysis.R: a script that will produce the tidy data set, provided that the initial data folder is located in the current working directory. The output file will be named: tidy_set.txt
- an instance of the tidy data set in a text file: tidy_set.txt
- a code book which describes in detail the variables retained for inclusion into the tidy data set: code book.md

In order to produce our tidy data set, we have:
- merged the test and train sets. This involved minor adjustments to the columns names.
- renamed the activity labels using their human-readable counterparts (for instance 1 was turned into 'WALKING')
- only kept the variable measurements that were related to mean and standard deviations. Of those, we also discarded variables that had been averaged over a signal sample window, as we could not ascertain what that means.
- taken the mean for each subject/activity sub-group.

Please note that the data is in "wide" format; there is a single row for each subject/activity pair, and a single column for each measurement.
