# CSV 불러오기(sep는 문서형식에 따라 기호를 다르게 한다.)
mydata4 = read.csv(file="sam4.csv", sep=":", header = F)
mydata4

# txt 불러오기
my_txt = read.delim(flie = "txt_sam.txt", sep=";", header = F, quote = " ")
my_txt

# csv 파일 저장
write.csv(df1, "df1.csv")

write.csv(mydata3, "rmydata3.csv")
