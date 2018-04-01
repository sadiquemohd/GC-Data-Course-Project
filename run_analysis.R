# run_analysis.R has the steps to tidy up the Wearable Monitored Human activity dataset
#First step - Merge training and test data set
#Prerequisite :Data set is downloaded and unzipped and ready to load
fpath <- "F:/c3proj/gc_data/UCI HAR dataset/"
setwd(fpath)
#load the training data sets
subject_train <- read.table ("./train/subject_train.txt", header = FALSE)
feature_train <- read.table ("./train/X_train.txt", header = FALSE)
activity_train <- read.table ("./train/y_train.txt", header = FALSE)
#load the test data sets
subject_test <- read.table ("./test/subject_test.txt", header = FALSE)
feature_test <- read.table ("./test/X_test.txt", header = FALSE)
activity_test <- read.table ("./test/y_test.txt", header = FALSE)
#merge the data sets to make a combined & set the column names

#Combine the train and test Subjects
combined_subjects <- rbind(subject_train, subject_test)
colnames(combined_subjects) <- c("Subject")

#Combine the train and test Activities
combined_activities <- rbind(activity_train,activity_test)
colnames(combined_activities) <- c("Activity")

#Load features to extract the mean and SD
feature_names_list <- read.table ("features.txt", header = FALSE)
feature_mean_sd <- grep("mean\\(\\)|std\\(\\)" , as.character(feature_names_list$V2) , value = TRUE )

#Set meaningful names for the features
feature_names <- gsub("^t","Time",feature_mean_sd)
feature_names <- gsub("^f","FFT",feature_names)
feature_names <- gsub("\\(\\)","",feature_names)

#Combine the train and test Features
combined_features <- rbind(feature_train,feature_test)
colnames(combined_features) <- c(feature_names)

#Merge all together
combined_s_a <- cbind(combined_subjects,combined_activities)
combined_data <- cbind(combined_features,combined_s_a)

selected_data <- subset(combined_data, select = c("Subject","Activity", as.character(feature_names)))

#load activity labels
activity_labels <- read.table ("activity_labels.txt", header = FALSE)

selected_data$Activity <- factor(selected_data$Activity, levels = activity_labels[,1], labels = activity_labels[,2])

#Create average activity and average subject tidy data set

tidy <- aggregate( .~ Subject + Activity , data = selected_data , FUN="mean")


#write to the tidied dataset 
write.table(tidy, file="tidy_activity_monitor.txt" , append =  FALSE,
            quote = TRUE, sep = ",",
            eol = "\n", row.names = FALSE,
            col.names = TRUE)


