#준비
Audi = read.csv("audi.csv")

#히스토그램 기본
ggplot(Audi, aes(x = price)) +
  geom_histogram() +
  theme_classic()

#구간 수정
ggplot(Audi, aes(x = price)) +
  geom_histogram(bins = 100) +
  theme_classic()

#색, 축 수정
ggplot(Audi, aes(x = price, fill = transmission)) +
  geom_histogram(bins = 100) +
  theme_classic() +
  scale_y_continuous(expand = c(0,0)) +
  scale_x_continuous(expand = c(0,0))

#산점도 기본
ggplot(Audi, aes(x = mpg, y = price)) +
  geom_point() +
  theme_classic()


#색 수정
ggplot(Audi, aes(x = mpg, y = price, col = fuelType)) +
  geom_point() +
  theme_classic()

#산점도 + 비선형 회귀선
ggplot(Audi, aes(x = mpg, y = price)) +
  geom_point() +
  geom_smooth() +
  theme_classic()

#산점도 + 선형 회귀선
ggplot(Audi, aes(x = mpg, y = price)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

#박스플롯 기본
ggplot(Audi, aes(x = fuelType, y = price)) +
  geom_boxplot(outlier.colour = "red") +
  theme_classic()

#색지정
ggplot(Audi, aes(x = fuelType, y = price, fill = transmission)) +
  geom_boxplot(outlier.colour = "red") +
  theme_classic()

#선 그래프 오류
ggplot(Audi, aes(x = year, y = price)) +
  geom_line() +
  theme_classic()

#선 그래프를 위한 데이터 집계
Year_DF = Audi %>% 
  group_by(year) %>% 
  summarise(Price = mean(price))

Year_DF

#선 그래프의 기본
ggplot(Year_DF, aes(x = year, y = Price)) +
  geom_line() +
  geom_point() +
  theme_bw()

#선 그래프를 위한 데이터 집계
Year_DF2 = Audi %>% 
  group_by(year, fuelType) %>% 
  summarise(Price = mean(price))

Year_DF2

#선 그래프의 기본
ggplot(Year_DF2, aes(x = year, y = Price, col = fuelType)) +
  geom_line() +
  geom_point() +
  theme_bw()


#데이터 구조 변환 - 행/열 변환 
#cast(길게)/melt(아래로)
#reshape패키지

#데이터 준비
Audi_S = Audi %>% 
  group_by(model, year) %>% 
  summarise(Count = n())
Audi_S

install.packages("reshape")
library(reshape)

#옆으로
Audi_Cast = Audi_S %>% 
  cast(model~year, fill = 0, value = "Count")
Audi_Cast

#아래로
Audi_Melt = Audi_Cast %>% 
  melt(id.vars = c("model"))
Audi_Melt
