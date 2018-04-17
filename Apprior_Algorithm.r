# Load the libraries
library(arules)
library(arulesViz)
library(datasets)
data("Groceries")
# OR
Groceries<-read.transactions(file.choose())
# Create an item frequency plot for the top 20 items
itemFrequencyPlot(Groceries,topN=20,type="absolute")
# Get the rules support 0.1 indicates that transaction atleast happen 10% times.
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8))

# Show the top 5 rules, but only 2 digits
options(digits=2)
inspect(rules[1:5])

#Sorting stuff out
rules<-sort(rules, by="confidence", decreasing=TRUE)
inspect(rules[1:5])

rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8,maxlen=3))

rules<-apriori(data=Groceries, parameter=list(supp=0.001,conf = 0.08), 
               appearance = list(default="lhs",rhs="whole milk"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])

#Visualization
library(arulesViz)
plot(rules,method="graph",interactive=TRUE,shading=NA)
