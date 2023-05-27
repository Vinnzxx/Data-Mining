data = read.csv('Timeseries Data.csv')

#melakukan prediksi terhadap data x berdasarkan waktu
#mengambil data x
x = data[,2]

library(forecast)
install.packages('forecast')

#melakukan plot
X_TS = ts(x, frequency = 12, start = c(2014,1))
plot(X_TS)

#melakukan prediksi berdasrkan data plot
mod = auto.arima(X_TS)
result = data.frame(mod$fitted)
#h = 13 merupakan periode yang ingin di forecast seberapa jauh kedepan
x_predict = forecast(mod, h = 13)

accuracy(x_predict)
plot(x_predict)

x_predict = data.frame(x_predict)
#lo merupakan batas bawah, hi merupakan batas atas