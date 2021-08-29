library(data.table)
library(ggplot2)
library(dplyr)
library(reshape)
library(ggsci)

getwd()

DIR = "C:/Users/byonk/OneDrive/바탕 화면/BJH_data/git_data/R_data/bigdata/"

FILES = list.files(DIR)

for (k in 1:length(FILES)) {
  assign(gsub(".csv","",FILES[k]),
         fread(paste0(DIR, FILES[k])))
}

Total_DF = rbind('2019-Oct','2019-Nov','2019-Dec','2020-Jan','2020-Feb')

Customer_ID2 = unique(Total_DF$user_id)
