library(dplyr)

data = read.csv('K Means Data.csv')

#elbow method, digunakan untuk menentukan berapa cluster yang bisa digunakan
set.seed(6)
wcss = vector()
for(i in 1:10) wcss[i] = sum(kmeans(data,i)$withinss)
plot(1:10,wcss,type = 'b', main = paste('cluster of plg'), xlabs = 'number', ylabs = wcss)
  
#membuat kmeans dari cluster
set.seed(29) #bebas
kmeans6 = kmeans(data, 6, iter.max = 10, nstart = 10)
kmeans6$size #untuk mengetahui berapa jumlah dari setiap pengelompokkan
kmeans6$cluster #mengetahui label cluster yang dibuat
kmeans6$centers #center/titik" data, bisa digunakan untuk menentukan cluster data baru

kmeans4 = kmeans(data, 4, iter.max = 10, nstart = 10)
kmeans4$size

kmeans2 = kmeans(data, 2, iter.max = 10, nstart = 10)
kmeans2$size

kmeans10 = kmeans(data, 10, iter.max = 10, nstart = 10)
kmeans10$size



#melihat data berdasarkan clusternya
datafinal = cbind(data, kmeans6$cluster)


#memprediksi data baru
library(clue)
install.packages('clue')

#menemukan data baru
data_pred = read.csv('K Means Data.csv')
result = cl_predict(kmeans6, newdata = data_pred)
result
table(result)
