df = read.csv('Salary_Data.csv')

library(caTools)
set.seed(123)

#pemilahan data
split = sample.split(df$Salary, SplitRatio = 0.7)
training_set = subset(df, split == TRUE)
test_set = subset(df, split == FALSE)

#linear reggression menggunakan fungsi lm
#formula yaitu untuk menunjukkan kepada model mana target dan prediktornya
#variabel regressor yaitu untuk membuat modelnya yang nanti bisa di predict
reggresor = lm(formula = Salary ~ YearsExperience, data = training_set)

#untuk prediksi data, maka menggunakan fungsi predict dan dalam fungsi tersebut akan dibandingkan anatar variabel regressor yang sudah menjadi model dengan test set
y_pred = predict(reggresor, newdata = test_set)

#untuk melihat hasil prediksi
result = cbind(test_set, y_pred)
