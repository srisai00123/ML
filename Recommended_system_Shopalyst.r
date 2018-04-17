#Recommendations By Ganeshna sri teja saikiran

#Library
library("reshape2")
library("arules")
library("recommenderlab")

shopperlyst_rec=read.csv(file = "C:/Users/Administrator/Desktop/Shopperlyst/events.csv",header = TRUE)
set.seed(111)
ratingmatrix<-acast(testtree_data,shopper_id~category+sub_category+brand+gender)

class(ratingmatrix)
#convert it as a matrix
ratingmatrix<-as.matrix(ratingmatrix)


#Convert it into realratingmatrix data structure
#Realratingmatrix 
ratingmatrix<-as(ratingmatrix,"realRatingMatrix")

#Sample taken randomly 90% and 10%

#sample_movielense=sample.int(nrow(ratingmatrix),0.9*(nrow(ratingmatrix)))
#train_movielense=ratingmatrix[sample_movielense]
#test_movielense=ratingmatrix[-sample_movielense]

#Sample taken only regid=80 based on index
unique(train_data$Reg.Ids)->index
train_movielense=ratingmatrix[-c(35),]
test_movielense=ratingmatrix[c(35),]
recom_model_ML=Recommender(train_movielense,method="UBCF") # user based collabrative filtering

predit_ML=predict(recom_model_ML,test_movielense,n=3)# using model predict test data for top 3

as(predit_ML,"list")
as(test_movielense,"list")

