library(data.table)
library(ggplot2)
library(dplyr)
library(reshape)

womens = read.csv("Womens Clothing E-Commerce Reviews.csv")
str(womens)

#연속형 변수의 범주화 - cut()
Age_G = cut(as.numeric(womens$Age),
            break = seq(10, 100, by = 10),
            include.lowest = TRUE,
            right = FALSE,
            lables = paste0(seq(10,90,by=10), "th"))
Age_G