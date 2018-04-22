from __future__ import division
from itertools import combinations
import pandas as pd
import itertools
from operator import itemgetter 
import matplotlib.pyplot as plt
import datetime
from datetime import datetime
from pandas.tools.plotting import autocorrelation_plot
from matplotlib import pyplot
from pandas import datetime
from matplotlib import pyplot
from statsmodels.tsa.arima_model import ARIMA
from statsmodels.tsa.arima_model import ARMA
from sklearn.metrics import mean_squared_error
import statsmodels as sm
from scipy.optimize import brute
from statsmodels.tsa.arima_process import arma_generate_sample
import statsmodels.api as stm
from datetime import datetime, timedelta
import csv
from pandas import DataFrame

def sort(stocks,freq):#Sorting to stock list
    for i in range(0,len(stocks)-1):
        for j in range(i+1,len(stocks)):
            if(freq[i]<freq[j]):
                temp=freq[i]
                freq[i]=freq[j]
                freq[j]=temp
                
                temp=stocks[i]
                stocks[i]=stocks[j]
                stocks[j]=temp
                
def add_one_month(dt0):#Go to next month
    dt1 = dt0.replace(day=1)
    dt2 = dt1 + timedelta(days=32)
    dt3 = dt2.replace(day=1)
    return dt3

def get_safe_RSS(series, fitted_values):#find safe RSS
    fitted_values_copy = fitted_values  # original fit is left untouched
    missing_index = list(set(series.index).difference(set(fitted_values_copy.index)))
    if missing_index:
        nan_series = pd.Series(index = pd.to_datetime(missing_index))
        fitted_values_copy = fitted_values_copy.append(nan_series)
        fitted_values_copy.sort_index(inplace = True)
        fitted_values_copy.fillna(method = 'bfill', inplace = True)  # fill holes
        fitted_values_copy.fillna(method = 'ffill', inplace = True)
        return sum((fitted_values_copy - series)**2)

def iterative_ARIMA_fit(series):#find all possible models
    ARIMA_fit_results = {}
    results=[]
    for AR in range(1,4) :
        for MA in range(2) :
            for Diff in range(3):
                model = ARIMA(series, order = (AR,Diff,MA))#Trying different values of p,d,q
                fit_is_available = False
                results_ARIMA = None
                try:
                    results_ARIMA = model.fit(disp = -1, method = 'css')
                    fit_is_available = True
                    #print(results_ARIMA.aic)
                except:
                    continue
                if fit_is_available:
                    safe_RSS = get_safe_RSS(series, results_ARIMA.fittedvalues)
                    ARIMA_fit_results['%d-%d-%d' % (AR,Diff,MA)]=[safe_RSS,results_ARIMA]
                    results.append(results_ARIMA)

#    return ARIMA_fit_results
    return results

def bestFit(ts):#find model with best AIC
    answer=''
    aic=0
    for ele in ts:
        if(aic==0):
            aic=abs(ele.aic)
            answer=ele
        elif(abs(ele.aic)<aic):
            aic=abs(ele.aic)
            answer=ele
    return answer#Finding model with least possible absolute value of AIC

df=pd.read_csv('C:\\Users\\Sumit Kishore\\Desktop\\Online Retail.csv')#Read data from table
stock = df.groupby('StockCode')#Group table based on stock code

stocks=[]
freq=[]
for name, group in stock:
    stocks.append(name)
    freq.append(len(group))

#Finding 15 most frequently used stocks
sort(stocks,freq)    
stocks=stocks[:15]

for s in stocks:
    for name,group in stock:
        if(name==s):
            print(name)
            dates=group['InvoiceDate']
            for date in dates:
                start=date
                break
            for date in dates:
                end=date
            start = datetime.strptime(start, "%m/%d/%Y %H:%M").date()
            end = datetime.strptime(end, "%m/%d/%Y %H:%M").date()
            #Finding start and end dates of a stock
            trial=start
            myData=[['InvoiceDate','UnitPrice']]#List to add date and unit price to csv sheet
            while(trial<=end):
                unit=0
                count=0
                for g,u in zip(group['InvoiceDate'],group['UnitPrice']):
                    date=datetime.strptime(g, "%m/%d/%Y %H:%M").date()
                    if(date>=trial and date<=add_one_month(trial)):
                        unit+=u#Finding total unit cost for a month
                        count+=1
                avg=unit/count#Finding average unti cost
                list1=[]                
                list1.append(trial)
                list1.append(avg)
                myData.append(list1)#add date and average unit cost to a list
                trial=add_one_month(trial)#go to next month
            myFile = open('C:\\Users\\Sumit Kishore\\Desktop\\UnitPrice.csv', 'w')
            with myFile:
                writer = csv.writer(myFile)
                writer.writerows(myData)
            #Writing the list of invoice date and average cost to csv file
            print("Writing complete")
            myFile.close()
            
                        
            dateparse = lambda dates: pd.datetime.strptime(dates, '%Y-%m-%d')
            data=pd.read_csv('C:\\Users\\Sumit Kishore\\Desktop\\UnitPrice.csv', parse_dates=['InvoiceDate'],index_col='InvoiceDate',date_parser=dateparse) #Read data from table and specifying pars column for time series
            #Read data from table and specifying parse column for time series 
            ts=data['UnitPrice']
            #model=ARIMA(ts,order=(1,1,0)) 
            #model_fit=model.fit(disp=0)
            model_fit=bestFit(iterative_ARIMA_fit(ts))#Find best possible model
            print(ts[len(ts)-1])
            print(model_fit.summary())
            try:
                model_fit.plot_predict(start='01-2012',end='04-2012')
            except ValueError:
                print('Something wrong')
            #Finding future prediction and its graph
            break