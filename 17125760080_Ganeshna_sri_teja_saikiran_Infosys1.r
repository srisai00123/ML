# Get quantmod
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}


INFY <- getYahooData("INFY.NS",20000101,20170531,freq = "daily",type = "price",adjust = FALSE)

summary(INFY)
head(INFY)

TCS <- getYahooData("TCS.NS",20000101,20170531,freq = "daily",type = "price",adjust = FALSE)

summary(TCS)
head(TCS)

NSEI <- getYahooData("^NSEI",20000101,20170531,freq = "daily",type = "price",adjust = FALSE)

summary(NSEI)
head(NSEI)


INFY<-na.omit(INFY)
TCS<-na.omit(TCS)
NSEI<-na.omit(NSEI)

#(1) Visualize the trend of these stocks from all the possible aspects (trend, seasonality etc) and report if any interesting pattern is observed.

#Financial data is often plotted with a Japanese candlestick plot, so named because it was first created by 18th century Japanese rice traders. Use the function candleChart() from quantmod 
#Candlestick chart, a black candlestick indicates a day where the closing price was higher than the open (a gain), while a red candlestick indicates a day where the open was higher than the close (a loss). 

#INFY
plot(INFY[, "Close"], main = "INFY")

candleChart(INFY, up.col = "black", dn.col = "red", theme = "white" ,name = 'Infosys Daily Trends')

#TCS
plot(TCS[, "Close"], main = "TCS")

candleChart(TCS, up.col = "black", dn.col = "red", theme = "white" ,name = 'TCS Daily Trends')

#NSE
plot(NSEI[, "Close"], main = "NSEI")

candleChart(NSEI, up.col = "black", dn.col = "red", theme = "white" ,name= 'NSE Monthly Trends')

#(2) Which frequency (daily, weekly, monthly, yearly) of the input data seems appropriate for the analysis? 
#    What is the trade-off you are observing by reducing the frequency (eg- daily to weekly)?

#Weekly
INFYWEEK <- getYahooData("INFY.NS",20000101,20170531,freq = "weekly",type = "price",adjust = FALSE)
TCSWEEK <- getYahooData("TCS.NS",20000101,20170531,freq = "weekly",type = "price",adjust = FALSE)
NSEIWEEK <- getYahooData("^NSEI",20000101,20170531,freq = "weekly",type = "price",adjust = FALSE)

candleChart(INFYWEEK,up.col='black',down.col='red',theme = 'white',name = 'Infosys weekly Trends')

candleChart(TCSWEEK,up.col='black',down.col='red',theme = 'white',name = 'TCS weekly Trends')

candleChart(NSEIWEEK,up.col='black',down.col='red',theme = 'white',name = 'NSE weekly Trends')

#Monthly
INFYMON <- getYahooData("INFY.NS",20000101,20170531,freq = "monthly",type = "price",adjust = FALSE)
TCSMON <- getYahooData("TCS.NS",20000101,20170531,freq = "monthly",type = "price",adjust = FALSE)
NSEIMON <- getYahooData("^NSEI",20000101,20170531,freq = "monthly",type = "price",adjust = FALSE)

candleChart(INFYMON,up.col='black',down.col='red',theme = 'white',name= 'Infosys Monthly Trends')
?addSMA(n = 20)

candleChart(TCSMON,up.col='black',down.col='red',theme = 'white',name= 'TCS Monthly Trends')

candleChart(NSEIMON,up.col='black',down.col='red',theme = 'white',name= 'NSE Monthly Trends')


#(3) Is there any structural break in any of these 3 series (Infosys, TCS & NSE)? 
#Is there any major impact of historical external or internal events on the stocks? Discuss the impacts and their effects.

start <- as.Date("2007-09-17")
end <- as.Date("2017-05-31")

getSymbols(c("INFY.NS","TCS.NS", "^NSEI"), src = "yahoo", from = start, to = end)
stocks <- as.xts(data.frame(INFY.NS = INFY.NS[, "INFY.NS.Close"], TCS.NS = TCS.NS[, "TCS.NS.Close"], 
                            NSEI = NSEI[, "NSEI.Close"]))
head(stocks)

plot(as.zoo(stocks), screens = 1, lty = 1:3, xlab = "Date", ylab = "Price")
legend("topleft", c("INFY", "TCS","NSE"), lty = 1:3, cex = 0.5)
