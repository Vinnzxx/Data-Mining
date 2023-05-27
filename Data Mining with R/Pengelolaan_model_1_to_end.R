library(data.table)
library(ROCR)
install.packages('ROCR')
library(caret)
install.packages('caret')
library(randomForest)
library(caTools)
library(sqldf)
install.packages('sqldf')

dataTrain = fread("TrSet.csv", sep = ",", header = TRUE, 
             colClasses = list(
               numeric = c("EOP_BAL_CS","MTH_AVG_BAL_CS","MTH6_AVG_BAL_CS",
                           "DELTA_FUNDING_BALANCE","MTH_AVG_BAL_IDR","MTH6_AVG_BAL_IDR","DELTA_FUNDING_BALANCE_TD",
                           "AVG_CREDIT_3MTH","DELTA_CREDIT_MUTATION","AVG_DEBIT_3MTH"), character = c("CUST_NO"), factor = c(
                             "VTG","AGETIER","EDUCATION_DESC","GENDER","SUM_CREDIT_LESS_3MIL","SUM_CREDIT_ZERO","CUST_SEGMENT_AVG",
                             "DELTA_CUST_SEG","L_COLL","BAD_TAG")
             ))

dataTrain = as.data.frame(dataTrain)

#menghapus cust no, karena bukan akan menjadi fitur, krn no plh tidak boleh dijadikan fitur untuk memprediksi, maka harus disimpan terlebih dahulu jika nanti ingin di cek
d_cust_no = dataTrain$CUST_NO
dataTrain$CUST_NO = NULL

#fungsi untuk melakukan normalisasi (sama seperti scaling, namun normalisasi menggunakan maksimum dan minimum)


normalize = function(x){
  if(max(x)-min(x) == 0){
    return(0)
  }
  else{
    return((x-min(x))/(max(x)-min(x)))
  }
}

summary(dataTrain$DELTA_CUST_SEG)
levels(dataTrain$DELTA_CUST_SEG) = c(-1,-2,-3,-4,0,1,2,3,4)

#mencari data numerik
colNamesNumeric = colnames(dataTrain[,sapply(dataTrain,is.numeric)])
#outlier
upperlimitlist = seq(colNamesNumeric)
lowerlimitlist = seq(colNamesNumeric)

#membersihkan data null
for (i in colNamesNumeric) {
  dataTrain[,i] = ifelse(is.na(dataTrain[,i]),0,dataTrain[,i])
}

#metode quartile
count = 1
for (i in colNamesNumeric) {
  upperLimit = summary(dataTrain[,i])[5]+1.5*IQR(dataTrain[,1])
  lowerLimit = summary(dataTrain[,i])[2]-1.5*IQR(dataTrain[,1])
  dataTrain[,i] = ifelse(dataTrain[,i]<lowerLimit,lowerLimit,ifelse(dataTrain[,i]>upperLimit,upperLimit,dataTrain[,i]))
  
  #mnyimpan upper limit dan lower limit
  upperlimitlist[count] = upperLimit
  lowerlimitlist[count] = lowerLimit
  count = count + 1
  
  gc()
  
}

#melakukan normalisasi
for (i in colNamesNumeric) {
  dataTrain[,i] = normalize(dataTrain[,i])
}

#random forest
modelRF = randomForest(BAD_TAG~., data = dataTrain, ntree = 100, cutoff = c(0.5,1-0.5))
#cara melihat variabel yang penting
varImpPlot(modelRF)

implotout = importance(modelRF)
class(implotout)
implotValue = as.data.frame.matrix(implotout)

#melakukan pembersihan pada data test (prosedurnya harus sama dengan data train)
datatest = fread("tsSet.csv", sep = ",", header = TRUE, 
                 colClasses = list(
                   numeric = c("EOP_BAL_CS","MTH_AVG_BAL_CS","MTH6_AVG_BAL_CS",
                               "DELTA_FUNDING_BALANCE","MTH_AVG_BAL_IDR","MTH6_AVG_BAL_IDR","DELTA_FUNDING_BALANCE_TD",
                               "AVG_CREDIT_3MTH","DELTA_CREDIT_MUTATION","AVG_DEBIT_3MTH"), character = c("CUST_NO"), factor = c(
                                 "VTG","AGETIER","EDUCATION_DESC","GENDER","SUM_CREDIT_LESS_3MIL","SUM_CREDIT_ZERO","CUST_SEGMENT_AVG",
                                 "DELTA_CUST_SEG","L_COLL","BAD_TAG")
                 ))

datatest = as.data.frame(datatest)

summary(datatest$EDUCATION_DESC)

summary(dataTrain$EDUCATION_DESC)

datatest_cust_no = datatest$CUST_NO

datatest$CUST_NO = NULL

#membersihkan data null
for (i in colNamesNumeric) {
  datatest[,i] = ifelse(is.na(datatest[,i]),0,datatest[,i])
}

#outlier data test
count = 1
for (i in colNamesNumeric) {
  datatest[,i] = ifelse(datatest[,i]<lowerlimitlist[count],lowerlimitlist[count],ifelse(datatest[,i]>upperlimitlist[count],upperlimitlist[count],datatest[,i]))
  count = count + 1
}

#melakukan normalisasi
for (i in colNamesNumeric) {
  datatest[,i] = normalize(datatest[,i])
}

levels(datatest$DELTA_CUST_SEG) = levels(dataTrain$DELTA_CUST_SEG)
levels(datatest$L_COLL) = levels(dataTrain$L_COLL)

#melakukan prediction hasil 1 dan 0
predictionRF = predict(modelRF, datatest, type = "response")

#melakukan prediction probability (angka)
predictionRFprob = predict(modelRF, datatest, type = "prob")

pred = prediction(predictionRFprob[,2], datatest$BAD_TAG)

#ROCTable
ROCTable = data.frame("Threshold"=pred@cutoffs[[1]], "False Positives"=pred@fp[[1]], "False Negatives" = pred@fn[[1]], 
                      "True Negatives" = pred@tn[[1]], "False Positive rate" = pred@fp[[1]]/pred@n.neg[[1]], "Precision" = pred@tp[[1]]/pred@n.pos.pred[[1]],
                      "Recall" = pred@tp[[1]]/pred@n.pos[[1]], "Rate of positive prediction" = (pred@tp[[1]]+pred@fp[[1]])/(pred@fp[[1]]+pred@tp[[1]]+pred@fn[[1]]+pred@tn[[1]]),
                      "Lift" = (pred@tp[[1]]/pred@n.pos[[1]])/(pred@tp[[1]]+pred@fp[[1]])/(pred@fp[[1]]+pred@tp[[1]]+pred@fn[[1]]+pred@tn[[1]]),
                      "AUC" = rep(performance(pred, "auc")@y.values[[1]],length(pred@cutoffs[[1]])))

ROCTable[,"F1"] = 2*ROCTable[,"Precision"]*ROCTable[,"Recall"]/(ROCTable[,"Precision"]+ROCTable[,"Recall"])

#AUC dan treshold optimal
cutoffoptimal = subset(ROCTable$Threshold, max(ROCTable$F1, na.rm = TRUE) == ROCTable$F1)
AUC = subset(ROCTable$AUC, max(ROCTable$F1, na.rm = TRUE) == ROCTable$F1)

#confusion matrix
y_pred = as.data.frame(predictionRFprob)
y_pred = y_pred[2]

y_pred$predicted = ifelse(y_pred$'1'>=0.5,1,0)
datatestpred = cbind(datatest,y_pred)

datatest_cust_no = as.data.frame(datatest_cust_no)
datatestResult = cbind(datatest_cust_no,datatestpred)
