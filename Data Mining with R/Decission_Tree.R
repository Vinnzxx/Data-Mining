df4 = read.csv('Social_Network_Ads.csv')

df4$User.ID = NULL
#karena decision tree tidak bergantung dengan jarak, maka tidak perlu dilakukan penyekalaan terlebih dahulu

library(caTools)
set.seed(123)

split3 = sample.split(df4$Purchased, SplitRatio = 0.7)
training_set4 = subset(df4, split3 == TRUE)
test_set4 = subset(df4, split3 == FALSE)

#train decission tree
library(rpart)
#dalam decission tree maka targetnya harus dalam bentuk factor
classifier2 = rpart(formula = as.factor(Purchased) ~ ., data = training_set4)

classifier2

#jika type menggunakan class maka hasilnya nanti akan factor, jika menggunakan prob maka hasilnya probability
y_pred4 = predict(classifier2, newdata = test_set4[-3], type = 'class')

result4 = cbind(test_set4, y_pred4)
