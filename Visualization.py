# -*- coding: utf-8 -*-


#We will discuss visualization in python using Seaborn

import pandas as pd
from pandas import Series, DataFrame
import numpy as np
import matplotlib
import seaborn as sns
import bokeh as bk
import matplotlib.pyplot as plt

#Analysing univariate and bivariate data using seaborn
#Importing data
dm=pd.read_csv('DirectMarketing.csv')
#dm=pd.read_csv("C:\\aricent\\content\\day4\\ML Data Visualization\\DirectMarketingNull.csv")
#Data description 
dm.head(2)
# chechk null values
print(dm.isnull().sum())

## data imputation
i=dm.fillna(dm.mean(), inplace=True)
print(i)

## cross check impute values
print(dm.isnull().sum())

#We will use seaborn package to do plotting.The aim here is to be able to produce most commonly used plots. We will use tthe direct marketing data set and demonstrate the features of this library. Here is the agenda:
# Doing Univariate analysis
# Doing bivariate analysis
# Analyzing categorical data
# Faceting
# Controlling the pallets and other misc details

## 1. Univariate Analysis
#We will cover following:
# Creating a histogram
# Creating a density plot
# Creating joint density plots
# Creating joint bin plots, hexbins
# Creating smoothed versions of bivariate density and count plots

#We have two continous variables in our data:
    # Salary
    # AmountSpent
#We can understand the distribution of these two variables
dm=pd.read_csv('C:\\aricent\\content\\day3\\datalifecyleanalytics\\glawithid.csv')
#
sns.distplot(dm.Salary,kde=False, color='purple')
sns.distplot(dm.Salary,kde=True, color='purple')
sns.distplot(dm.Catalogs,kde=True,color='green')

#Imagine now we want to look at density estimates, distplot() will help us in doing the same!!!!
sns.distplot(dm.id,hist=True)
sns.distplot(dm.Salary,hist=False)
sns.distplot(dm.AmountSpent,hist=False,color='green')

#We can also try to look at the conditional plots, lets see what happens when we look at the distribution of the Salary and AmountSpent by Gender


sns.distplot(dm.Salary[dm.Gender=="Male"],kde=False,color='r',axlabel="Income Distribution of Males")

sns.distplot(dm.Salary[dm.Gender=="Female"],kde=False,color='g',axlabel="Income Distribution of Females")

#Ideally there should be a way to color by gender or to create a faceted plot, we will examine this in the last section of this session

### Creating a bivariate density plot
#We use jointplot() method to create joint density/count plots

sns.jointplot(x='Salary',y='AmountSpent',data=dm)#Notice the syntax
sns.jointplot(x='Salary',y='AmountSpent',data=dm,kind='hex')
sns.jointplot(x='Salary',y='AmountSpent',data=dm,kind='kde')

#Bivariate Correlation Plot

sns.heatmap(dm.corr())




dm.corr()













## 2. Bivariate Analysis
# Creating a simple scatter
# Conditioning a scatter by using hues
# Conditioning by using faceting

sns.lmplot(x='Salary',y='AmountSpent',data=dm)

#Lets resize and get  rid of the line
sns.lmplot(x='Salary',y='AmountSpent',aspect=1.5,fit_reg=False,data=dm)

#Let's try to get a conditional view, using Gender
sns.lmplot(x='Salary',y='AmountSpent',aspect=1.5,hue='Gender',data=dm,fit_reg=False)

#Let's try to get a conditional view, using Gender
sns.lmplot(x='Salary',y='AmountSpent',aspect=1.5,hue='Gender',data=dm,fit_reg=True)

#We can use faceting to bring in more variables
sns.lmplot(x='Salary',y='AmountSpent',hue='Gender',data=dm,aspect=1.5,col='Location',fit_reg=False)

sns.lmplot(x='Salary',y='AmountSpent',hue='Gender',data=dm,aspect=1.5,col='Location',row='Married',fit_reg=False)

##There are some options which can be used while faceting
sns.lmplot(x='Salary',y='AmountSpent',hue='Gender',col='Catalogs',aspect=1.5,data=dm,fit_reg=False)

#We can try to increase the size
sns.lmplot(x='Salary',y='AmountSpent',hue='Gender',col='Catalogs',aspect=1.5,data=dm,fit_reg=False,size=4)

#Or we can try to facet wrap around column
sns.lmplot(x='Salary',y='AmountSpent',hue='Gender',col='Catalogs',aspect=1.5,data=dm,fit_reg=False,col_wrap=2) #Better!!!

## 3. Analyzing Categorical Data
# countplot
# barplot: mean, median
# boxplot

sns.countplot(x='Gender',data=dm)

#Using barplot, notice the terminologies are a liitle different
sns.barplot(x='Gender',y='Salary',data=dm)

sns.barplot(x='Gender',y='Salary',data=dm,estimator=np.median)

#boxplot
sns.boxplot(x='Gender',y='AmountSpent',data=dm)

## 4 Faceting
# Using Facet_grid()to partition the plotting area
# Using map function to produce a trellis plots

#A simple example using sns.distplot
g=sns.FacetGrid(data=dm,hue='Gender',aspect=2)
g=g.map(sns.distplot,'AmountSpent',hist=True)
g=g.add_legend()

#A few tweaks that we can make in FacetGrid specification
g=sns.FacetGrid(data=dm,hue='Gender',aspect=2,size=5)
g.map(sns.distplot,'AmountSpent',hist=False)
g.add_legend()

#A few tweaks that we can make in FacetGrid specification
g=sns.FacetGrid(data=dm,hue='Gender',aspect=2,size=5,xlim=[0,200000])
g.map(sns.distplot,'Salary',hist=False)
g.add_legend()

#Another example checking distribution of amount spent over Gender and Location
g=sns.FacetGrid(dm,hue='Gender',size=5,col='Location') 
g.map(plt.hist,'AmountSpent',alpha=0.6)
g.add_legend()


## 4 Controlling pallete and other misc behaviour
# Adding titles 
# Adding x and y axis label
# Changing xlim and ylim
# Changing xticks and yticks
# Changing color pallete

#Adding Titles
g=sns.distplot(dm.Salary,kde=False)
#g.set_title('Histogram',size=20,color='b',alpha=0.4)
g.axes.set_title('Histogram',size=20,color='b',alpha=0.4)
g.axes.set_xlabel("Salary in $")
g.axes.set_ylabel("Amount Spent in $")


g=sns.lmplot(x='Salary',y='AmountSpent',data=dm,aspect=2)
g.ax.set_title('Scatter',size=20)
g.set_axis_labels('Salary in $','Amount Spent in $')

g=sns.jointplot(x='Salary',y='AmountSpent',data=dm,kind='kde')
g.ax_marg_x.set_title('Jointplot',size=20)
g.set_axis_labels("Salary in $","Amount Spent in $")

g=sns.FacetGrid(data=dm,hue='Gender',aspect=2,size=5,xlim=[0,200000])
g.map(sns.distplot,'Salary',hist=False)
g.add_legend()
g.ax.set_title("Hue Faceted",size=20)
g.ax.set_xlabel("Salary in $")
g.ax.set_ylabel("Density")

#Again a strightforward case
g=sns.countplot(x='Gender',data=dm)
g.axes.set_title('Countplot',size=20)
g.axes.set_ylabel("Counts")

#Faceted along column
g=sns.FacetGrid(dm,hue='Gender',size=5,col='Location') 
g.map(plt.hist,'AmountSpent',alpha=0.6)
g.add_legend()
g.fig.suptitle("Column Facets",size=20)
g.set_axis_labels("Amount Spent in Dollars","Count")
