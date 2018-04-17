library(e1071)
weather=read.csv(file="weather_data.csv",header = TRUE)
set.seed(111)
weather_sampled = sort(sample(nrow(weather), nrow(weather)*.5))
weather_train<-weather[weather_sampled,]
weather_test<-weather[-weather_sampled,]

#naiveBayes
model=naiveBayes(Play~.,data=weather_train)
model

#type="raw"->probability values/,type="class"->predicted class values.
#pred.df=predict(model,weather_test[,-5],type="raw")
pred.df=predict(model,weather_test[,-5],type="raw")

#To get the probablity values with test data in data frame.
weather_pred.prob=data.frame(weather_test$Play,pred.df)

write.csv(weather_pred.prob,file="weather_pred50.csv",row.names = FALSE)
#confmat=table(pred,weather_test$Play)
#accuracy=sum(diag(confmat))/sum(confmat)


x=c(0,1,0,1,0,0)
y=c(0,1,1,1,0,0)


ks.test(as.numeric(weather_pred.prob$No),as.numeric(weather_pred.prob$Yes))

#D = 0.42857, p-value = 0.5412
#alternative hypothesis: two-sided
