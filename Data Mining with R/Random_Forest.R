df5 = read.csv('Social_Network_Ads.csv')

df5$User.ID = NULL
#karena decision tree tidak bergantung dengan jarak, maka tidak perlu dilakukan penyekalaan terlebih dahulu

#karena random forest dasarnya decission tree maka targetnya harus diubah menjadi factor terlebih dahulu
df5$Purchased = as.factor(df5$Purchased)

library(caTools)
set.seed(123)

split4 = sample.split(df5$Purchased, SplitRatio = 0.7)
training_set5 = subset(df5, split4 == TRUE)
test_set5 = subset(df5, split4 == FALSE)

#train radom forest
library(randomForest)
install.packages('randomForest')

classifier3 = randomForest(x = training_set5[-3], y = training_set5$Purchased, ntree = 10)

classifier3

y_pred5 = predict(classifier3, newdata = test_set5[-3])

result5 = cbind(test_set5, y_pred5)


#confusion matrix
#confusion matriks isinya merupakan targertnya dan prediksinya, case ini targetnya merupakan pada table test_set kolom ketiga dan prediksinya merupakan y_pred
cm2 = table(test_set5[,3], y_pred5)
cm2

#y_pred2
#   0  1
#0 71  6
#1  9 34

#AUC
y_pred_num2 = as.numeric(y_pred5)
colAUC(y_pred_num2, test_set5[,3], plotROC = TRUE)
#hasil AUC ada di console