## Getting-and-Cleaning-Data-Week-4-Assignment
This repository contains the submission for the assignment for week 4 of Getting and Cleaning Data Coursera course.
1. First, download and unzip the data file into your R working directory.
2. Load the R source code into your R working space.
3. Finally, execute R source code to generate tidy data file.

## Data description
The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. The variable in the data Y indicates activity type the subjects performed during recording.

## Code explanation
First I loaded the data into the environment using the read.table function.Then combined training data set and test data set, and extracted partial variables to create another data set called the mean_std with the averages and standard deviation of each variable for each activity.

## tidy dataset
The new generated data set contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

## The code was written based on the instruction of this assignment

The R script called run_analysis.R does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
