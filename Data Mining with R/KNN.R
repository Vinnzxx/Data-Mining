df2 = read.csv('Social_Network_Ads.csv')

df2$User.ID = NULL

df2[,1:2] = scale(df2[,1:2])

library(caTools)
set.seed(123)

split1 = sample.split(df2$Purchased, SplitRatio = 0.7)
training_set2 = subset(df2, split1 == TRUE)
test_set2 = subset(df2, split1 == FALSE)

#membuat model knn
library(class)
#dalam knn, karena formulanya tidak di asosiasikan dari awal maka kolomnya harus di pilih" terlebih dahulu
#cl (classifier), untuk memberitahu bahwa kolom tsb digunakan untuk pembelajaran (case ini kolom 3 yang digunakan sebagai pembelajaran)
#k untuk mencari tetangga/nilai terdekatnya apa, jika banyak tetangga terdekat merupakan membeli maka akan set membeli
y_pred2 = knn(train = training_set2[,-3], test = test_set2[,-3], cl = training_set2[,3], k = 5)

summary(y_pred2)

result2 = cbind(test_set2,y_pred2)

#confusion matrix
#confusion matriks isinya merupakan targertnya dan prediksinya, case ini targetnya merupakan pada table test_set kolom ketiga dan prediksinya merupakan y_pred
cm1 = table(test_set2[,3], y_pred2)
cm1

#y_pred2
#   0  1
#0 70  7
#1  8 35

#AUC
y_pred_num1 = as.numeric(y_pred2)
colAUC(y_pred_num1, test_set2[,3], plotROC = TRUE)
#hasil AUC ada di console