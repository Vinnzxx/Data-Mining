df3 = read.csv('Social_Network_Ads - na.csv')

df3$EstimatedSalary[is.na(df3$EstimatedSalary)] = 0
df3$Age[is.na(df3$Age)] = mean(df3$Age, na.rm = TRUE)

#mengubah variabel gender menjadi data kategorikal (data yang memiliki level, tergantung pengkategoriannya)
df3$Gender = as.factor(df3$Gender)
df3$Purchased = as.factor(df3$Purchased)

#mengecek ada berapa level dalam data
summary(df3$Gender)
levels(df3$Gender)

#ketika membuat data untuk train ML, dicoba saja penyekalaan data menggunakan normalisasi dan standarisasi lalu dilihat performa mana yang lebh baik dari modelnya
