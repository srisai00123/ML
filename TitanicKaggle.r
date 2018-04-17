library(tree)
tree_data=read.csv(file="TitanicKaggle.csv",header=TRUE)
tree_data$Survived=as.factor(tree_data$Survived)
set.seed(111)
library(VIM)
library(mice)
mice_plot <- aggr(tree_data, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(tree_data), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))

dt = sort(sample(nrow(tree_data), nrow(tree_data)*.7))
traintree_data<-tree_data[dt,]
testtree_data<-tree_data[-dt,]


#Preparing model for train data#
tree_model=tree(Survived~Pclass+Sex+Age+SibSp+Parch+Embarked,data=traintree_data)
summary(tree_model)
plot(tree_model)
text(tree_model)

class(tree_data$Survived)
#prediting the model for test data#
model.prediction=predict(tree_model,testtree_data)
maxidx=function(arr){
  return(which(arr==max(arr)))}
idx=apply(model.prediction,c(1),maxidx)
modelprediction=c('0','1')[idx]
#confusion matrix for test data#

confmat=table(modelprediction,testtree_data$Survived)
#finding the accuracy of prediction#
accuracy=sum(diag(confmat))/sum(confmat)
accuracy

testtitanictree_data=read.csv(file="TestTitanicKaggle.csv",header=TRUE)
model.prediction=predict(tree_model,testtitanictree_data)
maxidx=function(arr){
  return(which(arr==max(arr)))}
idx=apply(model.prediction,c(1),maxidx)
modelprediction=c(0,1)[idx]
Survived=modelprediction

write.table(Survived, file = "SurvivedDatas.csv",row.names=FALSE, na="",col.names=TRUE, sep=",")
