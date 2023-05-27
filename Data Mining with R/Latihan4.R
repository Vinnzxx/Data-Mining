data2 = read.csv('Salary_Data.csv')

#view data dalam console
data2

#hanya menampilkan salah satu data, seperti select dalam mysql
var1 = data2$Salary
var1

#salary dengan pengkondisian, maka datanya akan di cek 1 per 1 dan menghasilkan output true or false
data2$Salary <=100000

#dalam var3, true or false akan di ubah menjadi 1 dan 0, karena di convert menjadi numeric
var3 = as.numeric(data2$Salary <=100000)
var3

#jika lupa fungsi bisa klik f1 sehingga muncul penjelasan tentang fungsi" nya 