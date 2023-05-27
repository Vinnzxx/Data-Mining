df3 = read.csv('Social_Network_Ads.csv')

df3$User.ID = NULL

df3[,1:2] = scale(df3[,1:2])

library(caTools)
set.seed(123)

split2 = sample.split(df3$Purchased, SplitRatio = 0.7)
training_set3 = subset(df3, split == TRUE)
test_set3 = subset(df3, split == FALSE)

#train model svm, menggunakan fungsi svm
library(e1071)
install.packages('e1071')
#kernel merupakan garis untuk prediksinya
classifier1 = svm(formula = Purchased ~ ., data = training_set3, type = 'C-classification', kernel = 'linear')

y_pred3 = predict(classifier1, newdata = test_set3[-3])

result3 = cbind(test_set3, y_pred3)
