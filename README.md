How the script works
====================

1) Set the working directory
2) Load the datasets in the following order: testing data, training data, training activities, testing activities, features, training subjects, testing subjects
3) "Nice" names are given to the columns
4) Merge these datasets by row (training merged with testing)
5) Keeps only the mean or standard deviation data and store it in meanOrStdDS
6) Give "nice" names to activities
7) Merge the data, the activities and subjects by column
8) Aggregate the data by activity and subject, and take only the data mean
9) Export into the text file tidyAverageDS.txt, columns separated by tabs