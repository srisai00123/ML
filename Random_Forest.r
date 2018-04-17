library(tree)
tree_data=read.csv(file="TitanicKaggle.csv",header=TRUE)
ggbbbbbbbbbbbvvvvvvvvvvv21qws#sampling the data 90%
sample_items=sort(sample.int(n=nrow(tree_data),size=floor(.80*nrow(tree_data)),replace = F))
sample_items

tree_data_train=tree_data[sample_items,] #train data 80%
tree_data_test=tree_data[-sample_items,] #test data 20%
#Type1:
-------
  library(randomForest)
class(tree_data_train$Survived)
tree_data_train$Survived<-as.factor(tree_data_train$Survived)
rf<-randomForest(Survived~Pclass+Sex+Age+SibSp+Parch+Embarked,data = tree_data_train)
print(rf)
attributes(rf)
library(caret)
p1<-predict(rf,tree_data_train)
confusionMatrix(p1,tree_data_train$Survived)

p2<-predict(rf,tree_data_test)
confusionMatrix(p2,tree_data_test$Survived)

#Error Rate:
  plot(rf)
  
#Mtry
  t<-tuneRF(tree_data_train[,-c(2,4)],tree_data_train[,2],
            stepFactor = 0.5,
            plot = TRUE,
            ntreeTry = 300,
            trace=TRUE,
            improve = 0.05)
  
  rf<-randomForest(Survived~Pclass+Sex+Age+SibSp+Parch+Embarked,data = tree_data_train,
                   ntree=300,
                   mtry=5,
                   importance=TRUE,
                   proximity=TRUE)
  print(rf)
  
  testtitanictree_data=read.csv(file="TestTitanicKaggle.csv",header=TRUE)
  model.prediction=predict(rf,testtitanictree_data)
  maxidx=function(arr){
    return(which(arr==max(arr)))}
  idx=apply(model.prediction,c(1),maxidx)
  modelprediction=c(0,1)[idx]
  Survived=modelprediction
  
  write.table(Survived, file = "SurvivedDatas.csv",row.names=FALSE, na="",col.names=TRUE, sep=",")
  
#Type2:

#model1 decision tree
tree.model1=tree(Play~.,data=tree_data_train)
tree.model1
summary(tree.model1)
plot(tree.model1)
text(tree.model1)

#model2 decision tree
tree.model2=tree(Play~Temperature+Humidity+Wind,data=tree_data_train)
tree.model2
summary(tree.model2)
plot(tree.model2)
text(tree.model2)

#model3 decision tree
tree.model3=tree(Play~Humidity+Outlook,data=tree_data_train)
tree.model3
summary(tree.model3)
plot(tree.model3)
text(tree.model3)

#prediction for first sample
for(i in 1:nrow(tree_data_test))
{
  modelprediction1=predict(tree.model1,tree_data_test[i,])
  print(modelprediction1)
  
  modelprediction2=predict(tree.model2,tree_data_test[i,])
  print(modelprediction2)
                        
  modelprediction3=predict(tree.model3,tree_data_test[i,])
  print(modelprediction3)
  readline(prompt = "Press[enter] to continue")
}  


