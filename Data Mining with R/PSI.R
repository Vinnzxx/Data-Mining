library(data.table)
library(creditmodel)
install.packages('creditmodel')

#menarik data train
data = fread("TrSet.csv", sep = ",", header = TRUE, 
             colClasses = list(
               numeric = c("EOP_BAL_CS","MTH_AVG_BAL_CS","MTH6_AVG_BAL_CS",
                           "DELTA_FUNDING_BALANCE","MTH_AVG_BAL_IDR","MTH6_AVG_BAL_IDR","DELTA_FUNDING_BALANCE_TD",
                           "AVG_CREDIT_3MTH","DELTA_CREDIT_MUTATION","AVG_DEBIT_3MTH"), character = c("CUST_NO"), factor = c(
                             "VTG","AGETIER","EDUCATION_DESC","GENDER","SUM_CREDIT_LESS_3MIL","SUM_CREDIT_ZERO","CUST_SEGMENT_AVG",
                             "DELTA_CUST_SEG","L_COLL","BAD_TAG")
             ))

data = as.data.frame(data)

#menarik data test
datatest = fread("tsSet.csv", sep = ",", header = TRUE, 
             colClasses = list(
               numeric = c("EOP_BAL_CS","MTH_AVG_BAL_CS","MTH6_AVG_BAL_CS",
                           "DELTA_FUNDING_BALANCE","MTH_AVG_BAL_IDR","MTH6_AVG_BAL_IDR","DELTA_FUNDING_BALANCE_TD",
                           "AVG_CREDIT_3MTH","DELTA_CREDIT_MUTATION","AVG_DEBIT_3MTH"), character = c("CUST_NO"), factor = c(
                             "VTG","AGETIER","EDUCATION_DESC","GENDER","SUM_CREDIT_LESS_3MIL","SUM_CREDIT_ZERO","CUST_SEGMENT_AVG",
                             "DELTA_CUST_SEG","L_COLL","BAD_TAG")
             ))

datatest = as.data.frame(datatest)

#hitung psi antar fitur berdasarkan targetnya (dalam kasus ini x digunakan sebagai target yang akan diukur, occur time merupakan variabel yang akan diukur psi nya)
get_psi(dat = data, dat_test = datatest, x = "BAD_TAG", occur_time = "MTH6_AVG_BAL_CS", bins_no = TRUE)

#PSI digunakan untuk antara data train dgn OOT stability sangat jauh, misal train menggunakan data 2019, maka harus mengukur PSI ke data terbaru yntuk meyakinkan bahwa variabel yang dipakai masih sama distribusinya
#dalam kasus ini, PSI antara 2 data sama karena data train dan data test merupakan stabil 