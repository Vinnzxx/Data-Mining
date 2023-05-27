library(data.table)
library(imbalance)
install.packages('imbalance')

dataTrain = fread("TrSet.csv", sep = ",", header = TRUE, 
                  colClasses = list(
                    numeric = c("EOP_BAL_CS","MTH_AVG_BAL_CS","MTH6_AVG_BAL_CS",
                                "DELTA_FUNDING_BALANCE","MTH_AVG_BAL_IDR","MTH6_AVG_BAL_IDR","DELTA_FUNDING_BALANCE_TD",
                                "AVG_CREDIT_3MTH","DELTA_CREDIT_MUTATION","AVG_DEBIT_3MTH"), character = c("CUST_NO"), factor = c(
                                  "VTG","AGETIER","EDUCATION_DESC","GENDER","SUM_CREDIT_LESS_3MIL","SUM_CREDIT_ZERO","CUST_SEGMENT_AVG",
                                  "DELTA_CUST_SEG","L_COLL","BAD_TAG")
                  ))

dataTrain = as.data.frame(dataTrain)

#mengganti data numerik null menjadi 0
colNamesNumeric = colnames(dataTrain[,sapply(dataTrain,is.numeric)])

for (i in colNamesNumeric) {
  dataTrain[,i] = ifelse(is.na(dataTrain[,i]),0,dataTrain[,i])
}

summary(dataTrain$BAD_TAG)
#    0     1 
#42372  1254 



#oversampling tidak bisa dilakukan untuk data kategorikal/factor, maka data" tersebut harus dihapus terlebih dahulu

dataTrain$CUST_NO = NULL
dataTrain$VTG = NULL
dataTrain$AGETIER = NULL
dataTrain$EDUCATION_DESC = NULL
dataTrain$GENDER = NULL
dataTrain$SUM_CREDIT_LESS_3MIL = NULL
dataTrain$SUM_CREDIT_ZERO = NULL
dataTrain$CUST_SEGMENT_AVG = NULL
dataTrain$DELTA_CUST_SEG = NULL
dataTrain$L_COLL = NULL

#oversampling
#ratio merupakan seberapa banyak kita ingin melakukan oversampling
filtered = oversample(dataTrain, ratio = 0.5, method = 'SMOTE', classAttr = 'BAD_TAG')
summary(filtered$BAD_TAG)
