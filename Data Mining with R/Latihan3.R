data = read.csv('Salary_Data.csv')

#read table biasanya digunakan jika bentuknya bukan csv, sep = ',' karena dalam bentuk csv
data1 = read.table('Timeseries Data.csv', header = TRUE, sep = ',')

#dataframe (istilah R) sama dengan table
#fungsi class digunakan untuk tipe data/tipe table yang digunakan
class(data) #dataframe karena dalam 1 tabel bisa saja terdapat gabungan bbrp tipe data yang berbeda (int, string, dll)
x= 5
class(x)
