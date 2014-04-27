DataProject
===========

Samsung Galaxy data 

This analysis is based on data gathered from the accelerometers of the Samsung Galaxy S smartphone, obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  A more thorough explanation of the experimental design and range of variables collected is available within the downloaded README.txt file.  run_analysis.R assumes that the data has been downloaded and unzipped into the current working directory.

In short, 30 subjects performed a varety of activities (see codeBook.md, row 2) while wearing a Samsung Galaxy S attached at the waist. The data frames for subject_id, activity, and variables were collapsed into one data frame, based on trial. The groups orginially divided into training and testing have been further collapsed into a single group for the purposes of our analysis. A wide range of data was derived from the accelerometers and gyroscopes of said smartphone, and documented in an open-source data set.  These include accelerations and angular momentum of both the subjects body and gravity in three directions (X,Y,Z), and a whole series of transformations to determine more refined facets of the subject's movement.  The focus of this analysis was on the average(mean) and standard deviation (std) of each of these variables and was therefore extracted from the raw data set.  All variables included "mean()" and "std()" respectively were included, as well as a number of other higher level variables which calculated means across an angle (see codeBook.md, rows 68-75). 

After this data frame was created, the variable "activity" was reassigned to be a character factor, replacing a numerical variable with the common language representation of said activity.  The column names were then cleaned, utilizing the CamelCase convention for readability and eliminating particularly troublesome metacharacters, that is, () and - (replaced by the less obtrusive _ ).  

At the point, the data was subjected to further transformation.  The average of each measurement was determined by both subject and activity type.  That is, for each subject, an average of measurements was taken at each level of activity, resulting in 6 variables per subject.  This final data frame has been converted into a .txt file and made available, primed for further analysis as needed.

This dataset includes:  the R script used to create the final transformed data frame, the codeBook for exact representation of variables used, and this README.txt.  The data frame itself can be provided upon request.

  
