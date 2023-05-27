df5 = read.csv('Social_Network_Ads.csv')

#menghilangkan data/kolom dari user id
df5$User.ID = NULL

#library untuk memisahkan data
library(caTools)

#untuk melakukan pemilihan secara random, angka menunjukkan perbedaan ketika menggunakan random
set.seed(123)

#Y merupakan tagetnya, krn targetnya purcased maka kolom purcased yang digunakan, splitratio menggambarkan pembagian yang dilakukan yaitu 70% train, 30% test data
split1 = sample.split(df4$Purchased, SplitRatio = 0.8)

#proses membagi data menjadi training dan test
training_set1 = subset(df4, split1 == TRUE) #nilai split1 == TRUE karena tabel df4 yang disimpan pada variabel training_set1 berisi 80% data
test_set1 = subset(df4, split1 == FALSE) #nilai split1 == FALSE karena tabel df4 yang disimpan pada variabel test_set1 berisi jumlah data yang tersisa setelah dilakukan split data sebelumnya yaitu sebanyak 20% data

#mengecek proporsi pembagian target sama atau tidak
training_set1$Purchased = as.factor(training_set1$Purchased)
test_set1$Purchased = as.factor(test_set1$Purchased)

summary(training_set1$Purchased)
summary(test_set1$Purchased)
