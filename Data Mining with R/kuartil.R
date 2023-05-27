library(data.table)

#fread fungsi untuk import csv yang lebih cepat dari read.csv
data = fread("TrSet.csv", sep = ",", header = TRUE, 
             colClasses = list(
               numeric = c("EOP_BAL_CS","MTH_AVG_BAL_CS","MTH6_AVG_BAL_CS",
                           "DELTA_FUNDING_BALANCE","MTH_AVG_BAL_IDR","MTH6_AVG_BAL_IDR","DELTA_FUNDING_BALANCE_TD",
                           "AVG_CREDIT_3MTH","DELTA_CREDIT_MUTATION","AVG_DEBIT_3MTH"), character = c("CUST_NO"), factor = c(
                             "VTG","AGETIER","EDUCATION_DESC","GENDER","SUM_CREDIT_LESS_3MIL","SUM_CREDIT_ZERO","CUST_SEGMENT_AVG",
                             "DELTA_CUST_SEG","L_COLL","BAD_TAG")
               ))

data = as.data.frame(data)

colNamesNumeric = colnames(data[,sapply(data,is.numeric)])

#seq untuk membuat regular sequences 
upperlimitlist = seq(colNamesNumeric)
lowerlimitlist = seq(colNamesNumeric)

for (i in colNamesNumeric) {
  data[,i] = ifelse(is.na(data[,i]),0,data[,i])
}

#metode quartile
count = 1
for (i in colNamesNumeric) {
  upperLimit = summary(data[,i])[5]+1.5*IQR(data[,1])
  lowerLimit = summary(data[,i])[2]-1.5*IQR(data[,1])
  data[,i] = ifelse(data[,i]<lowerLimit,lowerLimit,ifelse(data[,i]>upperLimit,upperLimit,data[,i]))
  
  #mnyimpan upper limit dan lower limit
  upperlimitlist[count] = upperLimit
  lowerlimitlist[count] = lowerLimit
  count = count + 1
  
  gc()
  
}