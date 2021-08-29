# 중고차 데이터를 활용한 데이터 전처리
# 데이터 불러오기
Audi = read.csv("audi.csv")
str(Audi)
head(Audi)

# 데이터 연산 동시 처리(apply())
Normalization = function(x) {
  
  y = (x-min(x))/(max(x)-min(x))
  
  return(y)
  
}

V = 1:10
Normalization


#여러개의 필드를 사용하면 잘못된 계산 결과가 나옴.
Audi_s = Audi[,c("year", "price", "mileage", "mpg")]
Audi_s2 = Normalization(Audi_s)
summary(Audi_s2)


# 올바른 계산을 위해서는 Matrix 사용
R_Matrix = matrix(data = 0,
                  nrow = nrow(Audi_s),
                  ncol = ncol(Audi_s))

for(k in 1:ncol(Audi_s2)) {
  
  R_Matrix[,k] = Normalization(Audi_s[,k])
  
}

R_DF = as.data.frame(R_Matrix)
summary(R_DF)


# 간결하게 처리
R_DF2 = apply(Audi_s2, MARGIN = 2, FUN = Normalization)
summary(R_DF2)

#lapply()는 apply의 결과를 list() 형태로 변환
lapply(Audi_s2, Normalization)

R_DF3 = as.data.frame(lapply(Audi_s2, Normalization))
summary(R_DF3)


#dply 패키지 활용
# %>% 파이프 연산자 사용가능
library(dplyr)

# 각 열에 대한 평균을 선택적으로 구할 수 있음.
colMeans(filter(.data = Audi, year > 2016)[,c("tax", "mpg", "engineSize")])


# 위의 내용을 %>% 로 변경
Audi %>% 
  filter(year>2016) %>% 
  select(tax, mpg, engineSize) %>% 
  colMeans()


# 데이터셋에 새로운 변수 추가
# mutate() 데이테 셋에 새로운 변수를 추가함
Audi2 = Audi %>% 
  mutate(tax2 = ifelse(tax > 100, 1, 0),
         engineSize2 = round(engineSize))
head(Audi2)


# 그룹간 빈도수 계산
Audi3 = Audi %>% 
  group_by(transmission) %>% 
  summarise(Count = n())

Audi3


# 평균, 표준편차
Audi4 = Audi %>% 
  group_by(transmission) %>% 
  summarise(Count = n(),
            Price_Mean = mean(price),
            Price_sd = sd(price))
Audi4


# 그룹 변수가 2개 일 때
Audi5 = Audi %>% 
  group_by(transmission, year) %>% 
  summarise(Count = n(),
            Price_Mean = mean(price))
Audi5


# 그룹 간 비융 계산
Audi6 = Audi %>% 
  group_by(transmission, year) %>% 
  summarise(Count = n(),
            Price_Mean = mean(price)) %>% 
  mutate(Perc = Count/sum(Count))

head(Audi6)


