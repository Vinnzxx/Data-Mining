df1 = read.csv('Social_Network_Ads.csv')

#menghilangkan user id
df1$User.ID = NULL

#feature scaling, untuk melakukan penyekalaan fitur karena datanya merupakan numerik
df1[,1:2] = scale(df1[,1:2])
#prinsip standarisasi (nol nya ditengah, keatas = +, kebawah = -)
library(caTools)
set.seed(123)

#pemilahan data
split = sample.split(df1$Purchased, SplitRatio = 0.7)
training_set1 = subset(df1, split == TRUE)
test_set1 = subset(df1, split == FALSE)

#logistic regression, menggunakan fungsi glm
#glm(formula = Purchased ~ .) : titik menggambarkan bahwa targetnya kolom purchased sedangkan prediktornya semua kolom selain purchased
#family binomial karena prediksi yang dilakukan nantinya akan berbentuk 0 atau 1
classifier = glm(formula = Purchased ~ ., family = binomial, data = training_set1)

summary(classifier)

#prediksi
#test set yang dibuat harus dibuat diluar kolom untuk prediksi, test_set1[-3] (untuk memilih test set selain kolom 3)
prob_pred = predict(classifier, type = 'response', newdata = test_set1[-3])
#logistic hasilnya merupakan probabilitas, secara default dianggap 1 jika diatas 0.5
prob_pred
y_pred1 = ifelse(prob_pred>=0.5, 1, 0)
result1 = cbind(test_set1, y_pred1)

#confusion matrix
#confusion matriks isinya merupakan targertnya dan prediksinya, case ini targetnya merupakan pada table test_set kolom ketiga dan prediksinya merupakan y_pred
cm = table(test_set1[,3], y_pred1)
cm

#y_pred1
#   0  1
#0 69  8
#1 13 30

#AUC
y_pred_num = as.numeric(y_pred1)
colAUC(y_pred_num, test_set1[,3], plotROC = TRUE)
#hasil AUC ada di console