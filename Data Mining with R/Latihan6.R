#cbind (column bind, menggabungkan 2 dataframe yang digabungkan merupakan column)
#rbind (row bind, 2 column digabungkan row nya (atas dan bawah))
#rbind dan cbind menggabungkan kolom dan baris tanpa memperhatikan key nya, dan row/barisnya urutannya tetap sama

data4 = read.csv('Salary_Data.csv')

data4$YearsExperience

#mengambil kolom years of expereince lalu di letakkan di variabel datates
datates = data4$YearsExperience

#setting data 4 (hasil export data), pada kolom years of experience menjadi null
data4$YearsExperience = NULL

#menggabungkan variabel datates dan data4 sehingga kolom years of experience dapat muncul lagi, penamaan variabel penampung juga hrus sesuai dengan tabel yang ingin dijoinkan
data4 = cbind(datates,data4)

#mengganti nama datates menjadi years of experience, karena nama yang digunakan tidak sesuai
#mengambil kolom years of expereince lalu di letakkan di variabel datates
YearsExperience = data4$datates

#setting data 4 (hasil export data), pada kolom years of experience menjadi null
data4$datates = NULL

#menggabungkan variabel datates dan data4 sehingga kolom years of experience dapat muncul lagi, penamaan variabel penampung juga hrus sesuai dengan tabel yang ingin dijoinkan
data4 = cbind(YearsExperience,data4)

#variabel tempat meletakkan kolom usahakan sama dengan nama kolomnya, agar tidak perlu mengubah" lagi
# Cth: YearsExperience = data4$YearsExperience
