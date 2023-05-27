df = read.csv('Social_Network_Ads - na.csv')
dftest = read.csv('Social_Network_Ads - na.csv')

is.na(df$Age)

#subset/mengambil data dari df yang di age nya bukan NA (NA nya false)
#subset(nama tabel/dataframe, kriteria yang hendak di subset)
df1 = subset(df,is.na(df$Age) == FALSE)
#memilih data yang gendernya selain Female (akan yang ditampilkan yang hanya gendernya male)
dftest1 = subset(dftest,dftest$Gender != 'Female')

#mengganti data yang dianggap sampah/dianggap tidak masuk akal menjadi suatu data yang baru
#parameter: ifelse(nama kolom yang mau di ubah dan syaratnya, jika sesuai kondisi diubah menjadi apa, jika tidak sesuai kondisi maka tetap)
df1$EstimatedSalary = ifelse(df1$EstimatedSalary > 100000, 100000, df1$EstimatedSalary)
