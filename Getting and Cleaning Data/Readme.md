# Getting and Cleaning Data - Course Project

This is the course project at the end of week 4 for the Getting and Cleaning Data Coursera course. The script 'run_analysis.R' performs the following operations:

1. Downloads the dataset if it does not already exists in the working directory. The zip file is downloaded and unzipped into the current working directory.
2. The activity labels and features are loaded into R.
3. Only the data containing the mean and standard deviation of the measurements are extracted.
4. Train and test datasets are loaded with only the features extracted in number 3.
5. All data is merged together and column names added.
6. Activities and subjects are converted to factors.
7. Tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The tidy dataset in a file named 'tidy.txt'.
