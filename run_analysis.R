# this particular script assumes that the original data is
# already downloaded and unzipped into the current directory

# a few constants
activity_labels_file <- "./UCI HAR Dataset/activity_labels.txt"
features_file <- "./UCI HAR Dataset/features.txt"
subject_test_file <- "./UCI HAR Dataset/test/subject_test.txt"
measures_test_file <- "./UCI HAR Dataset/test/X_test.txt"
activity_test_file <- "./UCI HAR Dataset/test/y_test.txt"
subject_train_file <- "./UCI HAR Dataset/train/subject_train.txt"
measures_train_file <- "./UCI HAR Dataset/train/X_train.txt"
activity_train_file <- "./UCI HAR Dataset/train/y_train.txt"

# our results will be placed somewhere specific
if (!file.exists("./UCI HAR Dataset")) { 
     # consider autodownload+autounzip someday
}
if (!file.exists("./resulting_data")) {
     dir.create("./resulting_data");
}

# step 1a: collapse training and test SUBJECTS into one, and rename
#    ... further, turn the subjects IDs into factors
subjects_of_tests <- read.table(subject_test_file)
subjects_of_training <- read.table(subject_train_file)
all_subjects <- rbind(subjects_of_tests, subjects_of_training)
names(all_subjects)[1] <- "subject" 
all_subjects$subject <- as.factor(all_subjects$subject)
rm(subjects_of_tests, subjects_of_training) # memory management

# step 1b: collapse training and test X measures into one
#    ... also, add 'test' or 'train'
measures_of_tests <- read.table(measures_test_file)
measures_of_tests$session <- as.factor("test")
measures_of_training <- read.table(measures_train_file)
measures_of_training$session <- as.factor("train")
all_measures <- rbind(measures_of_tests, measures_of_training)
rm(measures_of_tests, measures_of_training) # memory management

# step 1c: collapse training and test y activities into one, ane rename
activity_of_tests <- read.table(activity_test_file)
activity_of_training <- read.table(activity_train_file)
all_activity <- rbind(activity_of_tests, activity_of_training)
names(all_activity)[1] <- "activity_id"
rm(activity_of_tests, activity_of_training) # memory management

# step 1d: get the NAMES of the activity types and nix the IDs
#    ... yes, technically this is STEP 3
labels <- read.table(activity_labels_file)
names(labels) <- c("activity_id","activity")
all_activity <- merge(all_activity, labels, by.x="activity_id", by.y="activity_id")
all_activity$activity_id <- NULL
rm(labels) # memory management 

# step 2a: isolate 'std' and 'mean' columns from measures
#    ... BEFORE they get lost in a large horizontal merger
#    ... this assumes -std() and -stdFreq() are not both std
features <- read.table(features_file)
preserve_columns <- grepl("(std|mean)\\(", features$V2)
column_names <- grep("(std|mean)\\(", features$V2, value=TRUE)
column_names <- c(column_names, 'session')
all_measures <- all_measures[,preserve_columns]

# step 4a: get the NAMES of our columns in place
#    ... yes, sorry, steps 2, 3, and 4 all out of order
names(all_measures) <- lapply(column_names, function(n){ n })

# step 2c: now, lets put all the data together
all_data <- cbind(all_subjects, all_activity, all_measures)
rm(all_subjects, all_activity, all_measures) # memory management

# step 4a: now, we must narrow/melt this data heavily
all_data <- melt(all_data, id=c("subject","activity","session"), variable.name="measure_type", value.name="observation")

# step 4b: determine if each new row is std or mean
all_data$observation_type <- as.factor(ifelse(grepl("-std\\(",all_data$measure_type), "std", "mean"))


