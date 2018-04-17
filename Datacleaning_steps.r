#Data Cleaning Steps#
library(ggplot2)
#Step 1 Initial Exploratory Analysis
#Reading csv file data
data<-read.csv(file='events.csv',header = TRUE)
#display default starting 6 records
head(data)
head(data,10)

#Display default last 6 records
tail(data)

#str function which shows the structure of dataset column wise in the form of num/Factor columnwise.
str(data)

#summary function which shows the summary of each column (min,max,median,mean,q1,q3 etc) for numeric.
summary(data)

#Step2 Visual Exploratory Analysis

#There are 3 types of plots that you should use during your cleaning process - 
#The Histogram, The BoxPlot and the ScatterPlot.

#1.Histogram
#The histogram is very useful in visualizing the overall distribution of a numeric column. 
#We can determine if the distribution of data is normal or bi-modal or unimodal or any other kind of distribution of interest. 
#We can also use Histograms to figure out if there are outliers in the particular numerical column under study
hist(iris$Sepal.Length)

#2.Boxplot
#Boxplot's are super useful because it shows you the median, along with the first, second and third quartiles. 
#BoxPlot's are THE BEST way of spotting outliers in your data frame.

boxplot(iris$Sepal.Width)

#3. Scatterplot

#Scatter plots helps us visualize bi-variate and multi-variate relationships. 
#Why is this useful? Simple - We can determine how two or more variables are correlated. 
#We can also use these plots to visualize for outliers.

ggplot(data,aes(y = Global_Sales, x = NA_Sales)) + geom_point()


#STEP 3: Correcting the errors!

#http://lineardata.net/the-ultimate-guide-to-cleaning-data-in-r/

sapply(train.data, function(df) {
   sum(is.na(df)==TRUE)/ length(df);
   })
# PassengerId  Survived    Pclass      Name        Sex         Age
#0.000000000   0.000000000 0.000000000 0.000000000 0.000000000 0.198653199


