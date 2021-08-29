# NA 는 결측치를 나타냄
df = data.frame(sex = c("M", "F", NA, "M", "F"),
                score = c(5, 4, 3, 4, NA))
df

# 결측치 확인 (TRUE가 결측치)
is.na(df)


# 결측치 빈도 확인
table(is.na(df$sex))
table(is.na(df$score))


# 결측치가 있는 경우 계산은 되지 않음
mean(df$score)
sum(df$score)


# 결측치가 있는 레코드
library(dplyr)
df %>% filter(is.na(score))


# 결측치 제거
df %>% filter(!is.na(score))  #내용확인
df_nomiss = df %>% filter(!is.na(score))  #제거
mean(df_nomiss$score)   #계산됨


# 여러개를 동시에
df_nomiss = df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss



# na.omit()를 사용하면 변수를 지정하지 않고
# 결측치가 있는 행을 한 번에 제거
df_nomiss2 = na.omit(df)
df_nomiss2



# 결측치를 제거하지 않고 하는 방법
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)


# 데이터를 호출해서 결측치를 처리하는 방법
exam = read.csv("csv_exam.csv") #데이터 불러오기
exam[c(3, 8, 15), "math"] <- NA  #3, 8, 15행 math에 NA할당
exam


# 수학 점수에 대한 평균 (안됨)
exam %>% summarise(mean_math = mean(math))  #math 평균

# 수학 평균을 결측치를 제거하고 계산
exam %>% summarise(mean_math = mean(math, na.rm = T))  

exam %>% summarise(mean_math = mean(math, na.rm = T),  #평균
                   sum_math = sum(math, na.rm = T),  #합계
                   median_math = median(math, na.rm = T))  #중앙값 



# 결측치를 제외한다는 것은 인원수를 제외한다는 것이다.
# 결측치에 대해서는 기본점수를 주는것으로 함.
# mat -> NA -> 55점을 수정 (최저점수 or 기본점수).
exam$math = ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))  #데이터가 많을 때 확인하는 방법
exam
mean(exam$math)


# 정상 범주에서 크게 벗어난 값을 '이상치(Outlier)'라고함.
outlier = data.frame(sex = c(1, 2, 1, 3, 2, 1),  #성별 1,2
                     score = c(5, 4, 3, 4, 2, 6))  #점수 1~5점
outlier


# 이상치 확인 (데이터 값의 범위)
table(outlier$sex)
table(outlier$score)


# 이상치를 결측치로 변경
outlier$sex = ifelse(outlier$sex == 3, NA, outlier$sex) #성별
outlier

outlier$score = ifelse(outlier$score > 5, NA, outlier$score)
outlier


# 이상치 -> 극단적인 값
boxplot(mpg$hwy)

# 상자 그림 통계치 출력 (다섯까지 범위)
boxplot(mpg$hwy)$stats

# 범위를 벗어난 데이터는 결측치로 처리
mpg$hwy = ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy)) #확인

# 결측치를 제외한 데이터 분석
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))












