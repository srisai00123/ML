#K-NEAREST NEIGHBOR

wdbc<-read.table(file.choose(),sep = ",")
View(wdbc)
wdbc<-wdbc[,-1]
#Function for Normalization
data_norm<-function(x){((x-min(x))/(max(x)-min(x)))}
#Normalized data from given dataset
wdbc_norm<-as.data.frame(lapply(wdbc[,-1],data_norm))
View(wdbc_norm)

summary(wdbc[,2:5])

#Data Normalized values should be 0 and 1
summary(wdbc_norm[,1:4])
ds<-sort(sample(nrow(wdbc),nrow(wdbc)*.8))
wdbctrain<-wdbc_norm[1:450,]
wdbctest<-wdbc_norm[451:569,]

library(class)
#k value will calculate based on square root of total observartions like 569 ->21
wdbc_predict<-knn(wdbctrain,wdbctest,wdbc[1:450,1],k=21)
perdictwdbc<-table(wdbc_predict,wdbc[451:569,1])
