library(e1071)
library(dplyr)
library(VIM)
library(lme4)
library(mice)
wm=read.csv(file="train_walmart_cluster.csv")
wmtest=read.csv(file="test_walmart_cluster.csv")
#wm=na.omit(wm)
mice_plot <- aggr(wm, col=c('navyblue','red'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(wm), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))
mice_plot <- aggr(wmtest, col=c('navyblue','red'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(wm), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))
wm <- mice(wm, m=5, maxit = 50, method = 'pmm', seed = 500)
wmtest <- mice(wmtest, m=5, maxit = 50, method = 'pmm', seed = 500)
for(i in 1:ncol(wm)){
  wm[,i]=as.numeric(wm[,i])
}

for(i in 1:ncol(wmtest)){
  wmtest[,i]=as.numeric(wmtest[,i])
}   
for (i in 1:ncol(wm))
{
  if(class(wm[,i])=="integer"){
    wm[,i][is.na(wm[,i])]<-median(wm[,i],na.rm = TRUE)
  }else{
    
    wm[,i]<-with(wm,impute(wm[,i],'random'))
  }
}
wm=wm%>%mutate(weekend=if_else(Weekday=="Saturday"|Weekday== "Sunday",1,0))

wm=wm%>%mutate(weekday=if_else(Weekday!="Saturday"&Weekday!= "Sunday",1,0))

wmtest=wmtest%>%mutate(weekend=if_else(Weekday=="Saturday"|Weekday== "Sunday",1,0))

wmtest=wmtest%>%mutate(weekday=if_else(Weekday!="Saturday"&Weekday!= "Sunday",1,0))

#naive bayes
wm$TripType=as.factor(wm$TripType)
model=naiveBayes(TripType~VisitNumber+DepartmentDescription+FinelineNumber+weekend+weekday,data=wm)
pred=predict(model,wmtest[,c(1,5,6,7,8)],type="raw")
pred
pred=as.data.frame(pred)
visitno=wmtest[,1]
pred=cbind(pred,visitno)
preds=pred%>%group_by(visitno)%>%summarise(TripType_3=mean(pred$'3'),TripType_4=mean(pred$'4'),TripType_5=mean(pred$'5'),TripType_6=mean(pred$'6')
                                           ,TripType_7=mean(pred$'7'),TripType_8=mean(pred$'8'),TripType_9=mean(pred$'9'),TripType_12=mean(pred$'12')
                                           ,TripType_14=mean(pred$'14'),TripType_15=mean(pred$'15'),TripType_18=mean(pred$'18'),TripType_19=mean(pred$'19')
                                           ,TripType_20=mean(pred$'20'),TripType_21=mean(pred$'21'),TripType_22=mean(pred$'22'),TripType_23=mean(pred$'23')
                                           ,TripType_24=mean(pred$'24'),TripType_25=mean(pred$'25'),TripType_26=mean(pred$'26'),TripType_27=mean(pred$'27')
                                           ,TripType_28=mean(pred$'28'),TripType_29=mean(pred$'29'),TripType_30=mean(pred$'30'),TripType_31=mean(pred$'31')
                                           ,TripType_32=mean(pred$'32'),TripType_33=mean(pred$'33'),TripType_34=mean(pred$'34'),TripType_35=mean(pred$'35')
                                           ,TripType_36=mean(pred$'36'),TripType_37=mean(pred$'37'),TripType_38=mean(pred$'38'),TripType_39=mean(pred$'39')
                                           ,TripType_40=mean(pred$'40'),TripType_41=mean(pred$'41'),TripType_42=mean(pred$'42'),TripType_43=mean(pred$'43')
                                           ,TripType_44=mean(pred$'44'),TripType_999=mean(pred$'999'))

write.csv(pred,"Gst_saikiran_walmart_kaggle1.csv")



