eng = c(90, 80, 60, 70) #영어점수
eng

math = c(50, 60, 100, 20) #수학점수
math

df_midterm = data.frame(eng, math)
df_midterm

class = c(1,1,2,2)
class

df_midterm = data.frame(eng, math, class)
df_midterm

#영어평균
mean(df_midterm$eng)

#수학평균
mean(df_midterm$math)

#한번에 데이터 프레임
df_midterm = data.frame(eng = c(90, 80, 60, 70), math = c(50, 60, 100, 20), class = c(1,1,2,2))
df_midterm


#엑셀 파일열기 설치
install.packages("readxl")
library(readxl)

df_exam = read_excel("excel_exam.xlsx")

mean(df_exam$english)

mean(df_exam$science)

#제목 행이 없는 경우
df_exam_notitle = read_excel("excel_exam_notitle.xlsx", col_names = F)
df_exam_notitle


#시트 3번째를 사용할 경우
#df_exam_sheet = read_excel("excel_exam_sheet.xlsx", sheet=3)


#csv 불러오기
df_csv_exam = read.csv("excel_exam.csv")
df_csv_exam


#R 형식으로 저장
saveRDS(df_csv_exam, file="df_midterm.rds")

#R 형식으로 불러오기
df_midterm = readRDS("df_midterm.rds")
df_midterm


exam = read.csv("excel_exam.csv")

head(exam)

head(exam,3)

tail(exam)

tail(exam,3)

View(exam)

dim(exam)
str(exam)
summary(exam)
