#apply,lapply,sapply functions
library(MASS)

dataframe<-birthwt

#row wise mean/median/mode for dataset
apl<-apply(dataframe,1,mean)
str(apl)
apl[1]
names(apl[1])

#col wise meanmean/median/mode for dataset

aplcol<-apply(dataframe,2,mean)
str(aplcol)
apl[1]
names(apl[1])

#lapply returns list in outputs same as apply funtion column wise but in list wise mean/median/mode

lappl<-lapply(dataframe,mean)
str(lappl)

lappl[1]
str(lappl[1])
names(lappl[1])

as.numeric(lappl[1:4])

#lapply we can also use at data normalization in knn 0 & 1
#Function for Normalization
data_norm<-function(x){((x-min(x))/(max(x)-min(x)))}
#Normalized data from given dataset
wdbc_norm<-as.data.frame(lapply(wdbc[,-1],data_norm))


#sapply wont return any list sapply returns dataframe and vectors mean/median/mode

sappl<-sapply(dataframe,mean)
str(sappl)

sappl[1]
str(sappl[1])
names(sappl[1])

as.numeric(sappl[1:4])
