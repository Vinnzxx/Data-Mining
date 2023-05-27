library(stringr)
library(arules)
library(arulesViz)

install.packages('stringr')
install.packages('arules')
install.packages('arulesViz')

first_df = read.csv('Association Rule Data.csv')

#melihat korelasi antara toko (dalam 1 hari user membeli di toko apa, lalu dilanjutkan di toko apa lagi)
#1 tanggal = 1 keranjang yang sama

#paste untuk menggabungkan
#membuat basket/keranjang
first_df$key = paste(first_df$eff_dt, first_df$cust_no)
first_df = first_df[order(first_df$key),]

df = first_df[,c("cust_no", "merchant_nm", "key")]
tb_df = with(df, table(key, merchant_nm))
tb_df[tb_df>=1] = 1

df_merch = as.data.frame.matrix(tb_df)
df_merch





#membuat fungsi dalam R
recodelevel = function(x){
  x = as.numeric(x)
  #mengganti jika terdapat nilai 0 menjadi NA 
  x = gsub("0", NA, format(as.numeric(x)))
  factor(x)
}

#apply merupakan teknik mengaplikasikan fungsi kedalam array/matriks
df_merch = df_merch[apply(df_merch, 1, sum) >= 3,]

convertcols = names(df_merch)
for(i in convertcols)  df_merch[,i] = recodelevel(df_merch[,i])
for(i in 1:ncol(df_merch)) {df_merch[,i] = as.factor(df_merch[,i])}


df_merch = df_merch[,sapply(df_merch,nlevels) == 1]
df_merch

#making rules
mba_rules = apriori(df_merch, parameter = list(supp = 0.01, conf = 0.05, target = 'rules', minlen = 2))

mba_rules = sort(mba_rules,by = 'lift', decreasing = 1)
inspect(mba_rules)

summary(mba_rules)
plot(mba_rules, method = 'graph')

#merapihkan data
mba_df = as(mba_rules,"data.frame")

lhsrhs = strsplit(as.character(mba_df$rules), "=>")

#untuk memisahkan dan menjadikan dalam bentuk matriks
lhsrhsmat = matrix(unlist(lhsrhs), ncol = 2, byrow = TRUE)
lhsrhsdf = as.data.frame(lhsrhsmat)
colnames(lhsrhsdf) = c("LHS", "RHS")
mba_df_fin = cbind(mba_df,lhsrhsdf)

#pembersihan data
#str_replace_all merupakan fungsi untuk mengganti string
mba_df_fin$LHS = str_replace_all(mba_df_fin$LHS, "\\{", "")
mba_df_fin$LHS = str_replace_all(mba_df_fin$LHS, "=1\\}", "")
mba_df_fin$RHS = str_replace_all(mba_df_fin$RHS, "\\{", "")
mba_df_fin$RHS = str_replace_all(mba_df_fin$RHS, "=1\\}", "")


abs(1-*10)
