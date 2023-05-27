#dim untuk menunjukkan dimensi dari dataframe
#length menunjukkan panjang dataframe

data3 = read.csv('Salary_Data.csv')
#30 rows 2 variabel/cells
dim(data3)

#jika ditentukan cells nya maka akan menghitung kebawah
length(data3$Salary)
#jika tidak ditentukan cells nya maka akan menghitung kesamping/cells nya
length(data3)

#menunjukkan 6 data paling atas, untuk mendapatkan insight datanya seperti apa
head(data3)
#menunjukkan 6 data paling bawah
tail(data3)

#mengambil data salary dari baris yang ke 5 sampai ke 10
data$Salary[5:10]
#mengambil kolom 1 dan kolom2
data[1:2]

#mengambil data baris ke 5 sampai 10 di kolom 2
data[5:10,2]
#mengambil data baris ke 5 sampai 10 di kolom 1
data[5:10,1]

#memilih data yang memiliki sesuai dengan kondisi yang sudah ditentukan
data[data$Salary <= 100000,]

#menghitung rata" data
mean(data$YearsExperience)
#menghitung rata" data, namun sesuai dengan pengkondisian/subset yang sudah dilakukan
mean(data$YearsExperience[data$Salary <= 100000])

#memilih/subset data dengan 2 kondisi yang berbeda (sama seperti pengkondisian menggunakan and dan or pada if else)
data[data$Salary <= 100000 & data$YearsExperience < 3,]
data[data$Salary <= 100000 | data$YearsExperience < 3,]

#kondisi and, maka semua kondisi harus terpenuhi semua
#kondisi or, maka bisa salah satu/beberapa kondisi saja yang terpenuhi

#kondisi 1 dan 2 dahulu yang dibandingkan, baru dibandingkan lagi dengan kondisi 3, dst
data[data$Salary <= 100000 & data$YearsExperience < 3 & data$Salary <= 50000,]

#jika ada or di depan, maka yang and dibandingkan terlebih dahulu baru di bandingkan dengan or
data[data$Salary <= 100000 | data$YearsExperience < 3 & data$Salary <= 50000,]

#jika ingin mengutamakan kondisi or, maka solusinya diberi kurung
data[(data$Salary <= 100000 | data$YearsExperience < 3) & data$Salary <= 50000,]
