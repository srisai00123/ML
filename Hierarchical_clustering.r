
library("circlize")

iris_v3=iris[,-5]
iris_species_v3=iris[,5]

#getting the colors codes
library("colorspace")
species_col=rev(rainbow_hcl(3))[as.numeric(iris_species_v3)]

#Method used to find distance matrix
distance_iris=dist(iris_v3,method="euclidean")

#Hierarchical model
hc_iris=hclust(distance_iris,method = "complete")

iris_species_hc=rev(levels(iris[,5]))

library("dendextend")

iris_dend=as.dendrogram(hc_iris)

iris_dend=rotate(iris_dend,1:150)

iris_dend=color_branches(iris_dend,k=3)
labels_colors(iris_dend)=
rainbow_hcl(3)[sort_levels_values(as.numeric(iris[,5])[order.dendrogram(iris_dend)])]
labels(iris_dend)=paste(as.character(iris[,5])[order.dendrogram(iris_dend)],"(",labels(iris_dend),")",sep="")

iris_dend=set(iris_dend,"labels_cex",0.5)
par(mar=c(3,3,3,7))
plot(iris_dend,main="Cluster Iris data set(the labels give the true flower species)",horiz=TRUE,nodePar=list(cex=.007))

legend("topleft",legend=iris_species_hc,fill=rainbow_hcl(3))

par(mar = rep(0,4))
circlize_dendrogram(iris_dend)
