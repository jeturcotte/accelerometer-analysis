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

## an intermedia schema

Tiding that up by one step, we can instead get:

* subject, session, activity, measure\_type, std\_measure, mean\_measure

This is a lot better, but...

## the tidiest scehma

So, here, I am going with the narrowest (and tidiest) melt of this data

* subject, session, activity, measure\_type, observation\_type, observation

Such that one row might be:

* [1] 2 "test" "WALKING" "tBodyAccJerk" "std" -0.12345

# Methodology

(TBD)