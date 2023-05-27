df4 = read.csv('Social_Network_Ads.csv')

#menghilangkan data/kolom dari user id
df4$User.ID = NULL

#library untuk memisahkan data
library(caTools)

#mengintall packages caTools
install.packages('caTools')

#untuk melakukan pemilihan secara random, angka menunjukkan perbedaan ketika menggunakan random
set.seed(123)

#Y merupakan tagetnya, krn targetnya purcased maka kolom purcased yang digunakan, splitratio menggambarkan pembagian yang dilakukan yaitu 70% train, 30% test data
split = sample.split(df4$Purchased, SplitRatio = 0.7)

#proses membagi data menjadi training dan test
training_set = subset(df4, split == TRUE)
test_set = subset(df4, split == FALSE)

#mengecek proporsi pembagian target sama atau tidak
training_set$Purchased = as.factor(training_set$Purchased)
test_set$Purchased = as.factor(test_set$Purchased)

summary(training_set$Purchased)
summary(test_set$Purchased)
