df = data.frame(sex=c("M", "F", NA, "M", "F"),
                score=c(5, 4, 3, 4, NA))
df

is.na(df)  #결측치 확인

table(is.na(df))  #결측치 빈도 출력

table (is.na(df$sex))  #sex 결측치 빈도

mean(df$score)  #평균산출(결측치로 인해 안됨)

sum(df$score)  #합계산출(결측치로 인해 안됨)

#결측치 행 제거
library(dplyr)
df %>% filter(is.na(score))  #score NA만 출력(확인)

df_nomiss %>% df %>% filter(!is.na(score))  #제거

mean(df_nomiss$score)   #score 평균

sum(df_nomiss$score)   #score 합계


# 한꺼번에 처리
df_nomiss = df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss










