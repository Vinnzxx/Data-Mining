library(data.table)

data = read.csv('TrSet.csv')

data = as.data.frame(data)

#tabel dimulai dari 1 indexnya (dalam R)
data[,6]

quantile(data[,6], c(0,.01,.10,.20,.50,.80,.90,.99,1))

#mengubah format numerik
options(scipen = 0)
