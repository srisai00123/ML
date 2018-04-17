#Kmeans Clustering Alogrithm model for iris dataset
iris_v2=read.csv(file="IRIS_v2.csv",header = TRUE)
set.seed(10)
library(ggplot2)

#Ploting ggplot using iris dataset for two variables
ggplot(iris_v2,aes(petalLength,petalWidth))+geom_point()

#Applying kmeans model for two valriable and 5 is no of clusters make and nstart=20 is cluster group making greaterthan 20

iriscluster=kmeans(iris_v2[,3:4],5,nstart=20)

#Making dataframe from model data cluster values

iris_clustered=data.frame(iris_v2[,3:4],iriscluster$cluster)

#finally ploting ggplot based on model data maked dataframe
ggplot(iris_clustered,aes(petalLength,petalWidth,color=iriscluster.cluster))+geom_point()

#KMean clustering for 4 variables
iris_cluster=kmeans(iris_v2,5,nstart=20)
print(iris_cluster)

iris_clustered = data.frame(iris_v2,
                            iris_cluster$cluster)
print(iris_clustered)

#Ploting the data from kmeans algorithm outas.factor(iris_cluster.cluster)))
plot(iris_clustered[,1:4],
     col = as.factor(iris_clustered$iris_cluster.cluster))
#Ploting ggplot with shapes colors and with all the 4 variables in dataset.
ggplot(iris_clustered,aes(x = petalLength,y = petalWidth,size = sepalWidth,
                          color = as.factor(iris_cluster.cluster),shape=as.factor(iris_cluster.cluster)))+ geom_point()
