# accelerometer-analysis
This little R project exists to `tidy` up data for smart phone accelerometers

# output schema

I really had to think about the data schema being outputted from this project, insofar as the highest criteria given was that the result be `tidy`.  In other words, it must adhere to the following stricture:

* Each variable forms a column
* Each observation forms a row
* Each type of observational unit forms a table

## possible inferred schema

If we were to follow `step 4` literally, we'd end up with a data.frame looking a bit like:

* subject, session, activity, measure1std, measure1mean, ..., measureNstd, measureNmean

But this is not tidy.  We are storing 1..N values for the TYPE of measure in the column names, and then duplicating that again between the `std` and `mean` observations for each.  Doubly untidy.

Note: I ADDED session (`test` vs. `train`) just for safety sake, otherwise the data would be lost.

## an intermediate schema

Tiding that up by one step, we can instead get:

* subject, session, activity, measure\_type, std\_measure, mean\_measure

This is a lot better, but...

## the submitted schema

So, here, I am going with the narrowest (and tidier) melt of this data

### activity_observations.txt

* `subject`: ID# of the individual involved in any given test
* `activity`: One of the six activities involved in any given test
* `session`: Some tests were done during `train`ing while others were part of official `test`s
* `measureType`: X, Y, Z, or Mag(nitude) for variables being tracked during a test
* `observation`: Float number value recorded for the given `measureType` calculation
* `observationType`: Indicates the `observation` is either of the `mean` or the `std` derivation

Such that one row might be:

* [1] 2 "test" "WALKING" "tBodyAccJerk" "std" -0.12345

### variable_averages.txt

And have added the required averages data set with the following:

* `measureType`: X, Y, Z, or Mag(nitude) for variables being tracked during a test
* `averageWhat`: Indicates whether these averages are grouped by `activity` or `subject` where the activity is one of the six previously mentioned, or the subject is the ID# of the individual taking the test
* `averageFor`: #ID of individual or name of activity
* `averageMean`: mean() of all observations of the mean for the given `measureType` for this activity or subject
* `averageStd`: mean() of all observations of the standard deviation for the given `measureType` for this activity or subject

Please note; I'm not 100% happy with this... I might FURTHER have melted this down by extracting the X, Y, Z, and Mag as yet another column, but I thought of that far too late to reverse direction... and this is still much better than the original.

Please see the CodeBook.md file for more about the data and original authors.

# Methodology

The process invented here to try to tidy this data could have been better and utilized `plyr` or `dplyr`, probably.  Still, it does work and a bit like this:

* Load up the original dataset
  * Read in the subject IDs from both the test and training data sets
  * Append the two together with a sensible column name
  * Read in the measurements from both the test and training data sets
  * Append the two together; column names come later
  * Read in the activities from both the test and training data sets
  * Append the two together with a sensible column name
* Begin to rearrange the data to be more `tidy`
  * Begin to dress up and stitch together the three sets of equal length columns into a single data set
  * Identify whether each row was from a `test` or a `train` session
  * Isolate only `std()` or `mean()` derivations for any given variable
    * Apply the name of these variables to their respective columns
    * NOTE: this precludes some variables containing similar to `stdFreq()`
  * Bind the columns together into a new data set
    * Clear out the remnants of the old sets to free up memory
  * `Melt` all the various measurement named columns down
    * Retain only the `subject`, `activity`, and `session` variables
    * Extend the rest into a new `measureType` variable using the `observation` column values
  * Add to a new column `observationType` either `std` or `mean` depending on presense of `-std(` or `-mean(` in the value of the the `measureType` field.
  * Change all the level labels for `measureType` to clear out rendundant and messy references to `-std()` or `-mean()`
* Write first dataset to file (turns out wasn't required by instructions!)
* Use first dataset to derive averages for `std()` and `mean()`
  * Since `measureType` is common to both groupings, we cycle through the possible values of these
  * Then, both by `subject` and `activity`, cycle again and extract all the `std()` and `mean()` values
  * Record the average of each to a new row in a new dataset
  * Each row's average values belong either to a `subject` or an `activity` for this `measureType`
* Write second/final dataset to file (also turns out wasn't actually required.)
