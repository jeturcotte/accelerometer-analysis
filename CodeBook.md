# Human Activity Recognition Using Smartphones Dataset -- Mean and Standard Deviation Analyses

## Author

Joshua Eric Turcotte

## Based on work done on "Human Activity Recognition Using Smartphones Dataset" by

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

## Original Experiment

The original experiments had been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments had been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Extracted Variables

The features selected for this AND the original database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

# The dataset includes the following files

* `CodeBook.md`: This brief desciption
* `README.md`: github front page description of the project
* `run_analysis.R`: script necessary to render `./UCI HAR Dataset/` datasets into `./resulting_data/` datasets
* `./resulting_data/activity_observations.txt`: data set of all mean and std observations
* `./resulting_data/variable_averages.txt`: data set of average mean and average std per subject or activity type

## activity_observations.txt

The following schema can be found in the larger `activity_observations.csv` file that is either included or to be created after running `run_analysis.R`:

* `subject`: ID# of the individual involved in any given test
* `activity`: One of the six activities involved in any given test
* `session`: Some tests were done during `train`ing while others were part of official `test`s
* `measureType`: X, Y, Z, or Mag(nitude) for variables being tracked during a test
* `observation`: Float number value recorded for the given `measureType` calculation
* `observationType`: Indicates the `observation` is either of the `mean` or the `std` derivation

## activity_observations.txt

The following schema can be found in the smaller `variable_averages.csv` file that is either included or to be created after running `run_analysis.R`:

* `measureType`: X, Y, Z, or Mag(nitude) for variables being tracked during a test
* `averageWhat`: Indicates whether these averages are grouped by `activity` or `subject` where the activity is one of the six previously mentioned, or the subject is the ID# of the individual taking the test
* `averageFor`: #ID of individual or name of activity
* `averageMean`: mean() of all observations of the mean for the given `measureType` for this activity or subject
* `averageStd`: mean() of all observations of the standard deviation for the given `measureType` for this activity or subject

# License: 

* This work was derived as part of class work, and modifies open data from original authors that can be contacted at activityrecognition@smartlab.ws
* This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

## Use of the original dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

## Use of the resulting dataset in publications must be acknowledged by referencing the following publication [2]

[2] Joshua Eric Turcotte, Human Activity Recognition Using Smartphones Dataset -- Mean and Standard Deviation Analyses, via Coursera & https://github.com/jeturcotte/accelerometer-analysis, USA. Jan 2016
