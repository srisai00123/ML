train_data=read.csv(file="Recommended_system_train_v2.csv",header=TRUE)

train_data=train_data[,-1]

head(train_data)

library("reshape2")

ratingmatrix<-acast(train_data,user~movie)

class(ratingmatrix)
#convert it as a matrix
ratingmatrix<-as.matrix(ratingmatrix)
library("arules")
library("recommenderlab")

#Convert it into realratingmatrix data structure
#Realratingmatrix 
ratingmatrix<-as(ratingmatrix,"realRatingMatrix")


as(ratingmatrix,"list") #A list

as(ratingmatrix,"matrix") #A sparse Matrix

