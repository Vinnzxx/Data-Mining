data = read.csv('TrSet.csv')

data = as.data.frame(data)

#meencari jika ada nilai null
data$EDUCATION_DESC = as.factor(data$EDUCATION_DESC)
summary(data$EDUCATION_DESC)

#sapply mengaplikasikan fungsi kedalam sebuah list/factor, dalam kasus ini maka akan di aplly mana kolom yang numerik
#colnames mengambil nama nama kolom dari data
#mengganti menjadi karakter dan factor
data$CUST_NO = as.character(data$CUST_NO)
data$BAD_TAG = as.factor(data$BAD_TAG)

#mengambil nama kolom yang  isinya numerik
colNamesNumeric = colnames(data[,sapply(data, is.numeric)])

#mengganti semua nilai null menjadi 0
for (i in colNamesNumeric) {
  data[,i] = ifelse(is.na(data[,i]),0,data[,i])
}

#mengganti semua nilai null menjadi mean
for (i in colNamesNumeric) {
  data[,i] = ifelse(is.na(data[,i]),mean(data[,i], na.rm = TRUE),data[,i])
}

#mengganti semua nilai null menjadi median
for (i in colNamesNumeric) {
  data[,i] = ifelse(is.na(data[,i]),median(data[,i], na.rm = TRUE),data[,i])
}