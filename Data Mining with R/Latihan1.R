#sama saja antara <- dan =
X <- 5
Y = 10
x = 'hello world'

#penambahan variabel
#bisa dilakukan di console langsung namun tidak ada catatan di text editornya

#penamaan variabel bebas namun tidak boleh ada angka didepan dan terdapat spasi
x1 = 200
x.1 = 200
x_1 = 200
#error karena ada angka di depan
#1x1 = 200
#error karena ada spasi
#x 1 = 200

#menggunakan karakter
xx = 'aa'
yy = '10'

#operasi langsung dijalankan
5+1
3+1
3*1

4*X #mengalikan dengan variabel yang sudah dibuat

5*yy #error karena yy bukan int

X*Y #mengalikan 2 variabel

#contoh fungsi
sqrt(X) #akar
abs(-5) #menghilangkan angka -
log(10) #logaritma
exp(10) #exponensial


X = 4 #langsung terganti hasilnya
vektor1 = c(1,3,5,7,9) #data disimpan di variabel
c(1,3,5,7,9) #hanya mencetak vektor

#contoh vektor lain
1:4 #menampilkan vektor dari angka 1 sampai 4
vektor2 = 1:4

#menampilkan vektor
vektor1
vektor2

vektor1[2:4] #menampilkan sebagian nilai

#vektor dan aritmatika
#semua angka akan dilakukan sesuai dengan operasi yang ditentukan
vektor1[2:4]*10
vektor1[2:4]-10
vektor1[2:4]/10
vektor1[2:4]+10

#vektor dengan string
gender = c('male', 'Female', 'other')
#dalam vektor yang ada string bisa ditambah angka namun angka tersebut akan di convert menjadi string juga
gender1 = c('male', 'Female', 4) 

#vektor dengan metode sequence
seq(from = 1, to = 7, by = 1)
seq(1, 7, 2)
#1 sampai 7 tapi naik secara 1/3
seq(from = 1, to = 7, by = 1/3)

#vektor dengan metode rep (seperti looping)
rep(1, times = 4)
rep(1, 4)

#penggabungan function
#hasil fungsi seq akan dilooping/diulang sebanyak 4 kali
rep(seq(from = 1, to = 7, by = 1/3), times = 4)

#aritmatika vektor (vektornya harus sama jumlahnya)
vektor1*4
vektor3 = c(3,4,5,6,7)
vektor1*vektor3
vektor1+vektor3
vektor1-vektor3
vektor1/vektor3


#matriks
#nrow merupakan pembagian baris, kolom mengikuti secara otomatis
matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3, byrow = TRUE)

#jika byrow diganti false maka pengurutan akan terbalik/tidak menyamping sesuai dengan row/barisnya
matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3, byrow = FALSE)

mat = matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3, byrow = TRUE)

#diambil angka dari baris 2 kolom 3
mat[2,3]

#diambil angka dari baris 1 dan 2 kolom 3
mat[c(1:2),3]

#operasi aritmatika matriks
mat*10 #semua angka di matriks dikali 10
mat+10 #semua angka di matriks ditambah 10
mat-10 #semua angka di matriks dikurangi 10
mat/10 #semua angka di matriks dibagi 10

mat1 = matrix(c(2,3,4,5,6,7,8,9,10), nrow = 3, byrow = TRUE)
mat1

#operasi aritmatika 2 matriks
mat*mat1 #perkalian 2 matriks
mat+mat1 #pertambahan 2 matriks
mat-mat1 #pengurangan 2 matriks
mat/mat1 #pembagian 2 matriks
