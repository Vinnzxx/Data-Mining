df2 = read.csv('Social_Network_Ads - na.csv')

#mengubah data na menjadi 0 dengan menggunakan pengkondisian (jika estimated salary nya na maka set menjadi 0)
df2$EstimatedSalary[is.na(df2$EstimatedSalary)] = 0

#data bisa diubah menjadi 0 sesuai dngn intuisi bisnisnya (apakah jika di set 0 akan ttp relevan)
#na.rm untuk ignore nilai NA, karena jika ada NA maka tidak bisa dihitung rata" nya
max(df2$Age, na.rm = TRUE) #nilai maximum data
min(df2$Age, na.rm = TRUE) #nilai minimum data
mean(df2$Age, na.rm = TRUE) #nilai rata" data

#mengubah nilai data NA menjadi nilai rata" berdasarkan data
df2$Age[is.na(df2$Age)] = mean(df2$Age, na.rm = TRUE)

#data yang benar adalah data yang sesuai dari sistem (konteks database)
#data null, tidak sesuai maka tidak bisa diterima ML dan bisa mengakibatkan salah prediksi
#data dapat diubah agar ddapat masuk ke dalam ML dengan catatan tidak merubah data populasi yang ada
#nilai kontinyu, yaitu data numerik