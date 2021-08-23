#데이터 불러오기
Audi = read.csv("audi.csv")
head(Audi, 3)
#환경설정(라이브러리)


#데이터 정렬
Audi17 = Audi %>% 
  arrange(price)  #오름차순 - 가장 낮은 가격

head(Audi17)

Audi19 = Audi %>% 
  arrange(-price)  #내림차순 - 가장 높은 가격

Audi20 = Audi %>% 
  arrange(-price) %>% 
  top_n(n=5, wt=price)  #top_n
Audi20

Audi21 = Audi %>% 
  filter(year>2016)
Audi21

#그룹 생성 및 결합합
Audi22 = Audi %>%      #A그룹 생성
  #group_by(model) %>% 
  #summarise(Count = n()) %>% 
  filter(model %in% c("A1", "A2", "A3", "A4"))
head(Audi22)

#Audi23 = Audi %>%
  #filter(model %in% c("A1", "A2", "A3", "A4"))
#Audi23



#year_G year기준에서 2000년 이전은 1990년대로
#그 이후는 2000년대로 변환된 데이터를 생성
#Count: 개수, Mean_Price: price의 평균, Median_Price: 중앙값, 
#Perc : 계산된 Count를 비율로 변환하는 변수 추가

P1 = Audi %>% 
  mutate(year_G = ifelse(year < 2000, 1990,
                         ifelse(year< 2010, 2000, 2010))) %>% 
  group_by(year_G, transmission) %>% 
  summarise(Count = n(),
            Mean_Price = mean(price),
            Median_Price = median(price)) %>% 
  mutate(Perc = Count / sum(Count)) %>% 
  arrange(year_G, -Mean_Price)
P1


#price에 대해 분위수 90% 이상에 대한 데이터만 추출
#model을 그룹 변수로 지정
#Mean_Price, Mean_Mileage, Mean_Tax 변수 추가
P2 = Audi %>% 
  filter(price > quantile(price, prob = c(0.9))) %>% 
  group_by(model) %>% 
  summarise(Mean_Price = mean(price),
            Mean_Mileage = mean(mileage),
            Mean_Tax = mean(tax)) 
P2


#audi.csv, bmc.csv, cclass.csv 데이터를 하나로 합친 후
#연도(90, 00, 10 년대)와 transmission 변수를 기준으로
#개수, 평균가격, 중위수 가격, 비율을 표시하는 데이터
#1. year_G 변수는 year 변수를 활용해 2000년 이전은 1990년대,
#   2010년 이전은 2010년대, 나머지는 2010년대로 변환
#2. 그룹변수는 year_G, transmission으로 설정
#3. Count는 개수, Mean_Price의 평균....
#4. Perc는 Count를 활용해 비율을 계산한 결과
#5. 데이터는 year_G에 대해 내림차순, Mean_Price에 대해 오름차순 정렬
#6. Brand 변수 생성을 위해 assign을 토해 불러오는 csv 데이터 명세
#7. 마지막으로 하나의 데이터셋에 브랜드 별로 정리된 데이터를 추가함으로써
#하나의 데이트를 생성함.














