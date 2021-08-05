df_raw = data.frame(var1 = c(1,2,1),
                    var2 = c(2,3,2))
df_raw

install.packages("dplyr")
library(dplyr)

df_new = df_raw  #데이터 프레임 복사
df_new

df_new = rename(df_new, v2=var2) #필드명 변경
df_new


df_raw  #필드명 확인
df_new


#데이터 프레임 생성
df = data.frame(var1 = c(4, 3, 8),
                var2 = c(2, 6, 1))
df

#행 합계
df$var_sum = df$var1 + df$var2
df


#행 평균
df$var_mean = (df$var1 + df$var2)/2
df


#도로 유형별 통합 연비
mpg$total = (mpg$cty + mpg$hwy)/2
head(mpg)


#20이상이면 pass, 그렇지 않으면 fail
mpg$test = ifelse(mpg$total >= 20, "pass", "fail")
head(mpg, 20)  #데이터 확인


table(mpg$test)  #연비 합계 빈도표
library(ggplot2)
qplot(mpg$test)  #시각화


#total을 기준으로 A,B,C,D등급 부여
mpg$grade = ifelse(mpg$total >= 30, "A", 
                   ifelse(mpg$total >= 25, "B", 
                          ifelse(mpg$total >= 20, "C", "D")))

head(mpg, 20)


table(mpg$grade)  #등급 빈도표 생성

qplot(mpg$grade)  #등급 막대 그래프


