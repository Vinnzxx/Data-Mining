#contoh operasi matematika
(4+4)*2

x = c(0,1,2,3,4,4,4,4)
#data x dibah menjadi factor, memiliki level yang tergantung banyak isi
y = as.factor(x)
#mencari level y, khusus kategori factor
levels(y)
#tipe data factor bisa diisi jenjang pendidikan (sd, smp, sma), area (jakarta, bandung, dll), biasanya diberikan dalam bentuk teks
#menunjukkan distribusi banyak angka/jumlah data yang terdapat dalam vektor
summary(y)
