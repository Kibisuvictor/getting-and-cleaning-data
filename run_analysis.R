#load the tidyverse package
library(tidyverse)

# reading the datasets into r
features <- read.table("C:\\Users\\hope\\Documents\\R docs\\run analysis\\UCI HAR Dataset\\features.txt", col.names = c("n","functions"))
activities <- read.table("C:\\Users\\hope\\Documents\\R docs\\run analysis\\UCI HAR Dataset\\activity_labels.txt",
                         col.names = c("code", "activity"))
subject_test <- read.table("C:\\Users\\hope\\Documents\\R docs\\run analysis\\UCI HAR Dataset\\test\\subject_test.txt",
                           col.names = "subject")
xtest <- read.table("C:\\Users\\hope\\Documents\\R docs\\run analysis\\UCI HAR Dataset\\test\\X_test.txt",
                    col.names = features$functions)
ytest <- read.table("C:\\Users\\hope\\Documents\\R docs\\run analysis\\UCI HAR Dataset\\test\\y_test.txt",
                    col.names = "code")
subject_train <- read.table("C:\\Users\\hope\\Documents\\R docs\\run analysis\\UCI HAR Dataset\\train\\subject_train.txt", 
                            col.names = "subject")

xtrain <- read.table("C:\\Users\\hope\\Documents\\R docs\\run analysis\\UCI HAR Dataset\\train\\X_train.txt",
                     col.names = features$functions)
ytrain <- read.table("C:\\Users\\hope\\Documents\\R docs\\run analysis\\UCI HAR Dataset\\train\\y_train.txt",
                     col.names = "code")

# step 1. mearging the files
X <- rbind(xtrain,xtest)
Y <- rbind(ytrain,ytest)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, Y, X)

# step 2. extract mean and std from each measurement
mean_std <- merged_data %>% select(subject, code, contains("mean"), contains("std"))


# step 3. uses descriptive names to name the activities
mean_std$code <- activities[mean_std$code, 2]

# step 4. appropriately names the dataset with descriptive names
names(mean_std)[2] = 'activity'
names(mean_std) <- gsub('Acc', 'Accelerometer', names(mean_std))
names(mean_std) <- gsub('Gyro', 'Gyroscope', names(mean_std))
names(mean_std) <- gsub('BodyBody', 'Body', names(mean_std))
names(mean_std) <- gsub('Mag', 'Magnitude', names(mean_std))
names(mean_std) <- gsub('^t', 'Time', names(mean_std))
names(mean_std) <- gsub('^f', 'Frequency', names(mean_std))
names(mean_std) <- gsub('tBody', 'Timebody', names(mean_std))
names(mean_std) <- gsub('-mean()', 'Mean', names(mean_std), ignore.case = TRUE)
names(mean_std) <- gsub('-std()', 'STD', names(mean_std), ignore.case = TRUE)
names(mean_std) <- gsub('-freq()', 'Frequency', names(mean_std), ignore.case = TRUE)
names(mean_std) <- gsub('gravity', 'Gravity', names(mean_std))
names(mean_std) <- gsub('angle', 'Angle', names(mean_std))
mean_std %>% head()

# step 5. create a tidy dataset with the average of each variable for each activity and subject
clean_data <- mean_std %>% 
  group_by(subject, activity) %>% 
  summarise_all(funs(mean)) 
clean_data %>% head()

#tidy data
write.table(clean_data, "tidy_data.txt", row.names = FALSE)
str(clean_data)
clean_data %>% view()
