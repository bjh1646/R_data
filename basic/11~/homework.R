install.packages("foreign")

library(foreign)  #SPSS 파일 불러오기
library(dplyr)    #전처리
library(ggplot2)  #시각화
library(readxl)   #액셀파일 불러오기

raw_welfare = read.spss(file = "Koweps_hpc10_2015_beta1.sav", to.data.frame = T)


# 복사본 만들기
welfare = raw_welfare
welfare