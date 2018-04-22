# -*- coding: utf-8 -*-
"""
Created on Sun Apr 22 15:34:26 2018

@author: Administrator
"""
import numpy as np
import pandas as pd

label=['a','b','c']
my_data=[10,20,30]
arr=np.array(my_data)
d={'a':10,'b':20,'c':30} #Dictionary key value pairs

#Series can hold any data type of data

pd.Series(my_data) #auto created index

pd.Series(my_data,index=label)

pd.Series(arr,index=label)

ser1=pd.Series([1,2,3,4],['USA','GERMENY','CANADA','UK'])

ser2=pd.Series([1,2,5,4],['USA','GERMENY','ITALY','UK'])

ser2['UK']
ser2[0]

ser1+ser2

#Data frames
from numpy.random import randn

np.random.seed(101)

#Below data frame with random data and index and column names
df=pd.DataFrame(randn(5,4),['a','b','c','d','e'],['W','X','Y','Z']) 


df['X']

type(df['X'])
#o/p
#pandas.core.series.Series

df[['X','Z']]

#creating new column

df['new']=df['X']+df['Y']
df

#drop column
df.drop('new',axis=1,inplace=True) #by using inplace =True delete permanently


#Drop row
df.drop('e',axis=0) #row e wont delete permenently

df.shape #which gets shape of data frame

df[['Z','X']] #Column retrive from dataframe

df.loc['a'] #Row retrivel

df.iloc[2]#Index wise retrivel

#specific row and column

df.loc['b','Z']

#multiple rows and columns

df.loc[['b','c'],['Z','Y']]


df[(df['W']>0) | (df['Z']>0)]

df[(df['W']>0) & (df['Z']>0)]


df[df['W']>0][['Y','X']]



outside=['G1','G1','G1','G2','G2','G2']

inside=[1,2,3,1,2,3]

hier_index=list(zip(outside,inside)) # to make tuples

hier_index=pd.MultiIndex.from_tuples(hier_index)


#Missing Data 

d={'A':[10,np.nan,3],'B':[20,22,40],'C':[30,np.nan,np.nan]} # creating missing dataframe

df=pd.DataFrame(d)

#dropping row wise 

df.dropna() #drop default rows

df.dropna(axis=1) #drop column wise

#filling the value

df['A'].fillna(value=df['A'].mean())

#Group_by

data=pd.read_csv("E:/parliament.csv")

byyear=data.groupby('YEAR').sum()
byyear.mean()

byyear=data.groupby('YEAR').count()

#Mergeing,Joining,concatenation

#pd.concat([df1,df2,df3]) 

#pd.concat([df1,df2,df3],axis=1)

#Merge

#pd.merge(left,right,how='inner',on='key') 

#pd.merge(left,right,how='inner',on=['key1','key2']) 

#pd.merge(left,right,how='outer',on=['key1','key2']) 

#pd.merge(left,right,how='right',on=['key1','key2']) 
#pd.merge(left,right,how='left',on=['key1','key2']) 

#Joining

#left.join(right)

#left.join(right,how='inner')
#left.join(right,how='outer')

#operations

data['YEAR'].unique() #gives the unique values in column

data['YEAR'].nunique() #Which gives the count of unque values in column

data['YEAR'].value_counts() #counts the values year wise

