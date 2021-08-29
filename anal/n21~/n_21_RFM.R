#마케팅의 핵심 RFM분석
library(data.table)
library(ggplot2)
library(dplyr)
library(reshape)
library(ggsci)

getwd()

DIR = "C:/Users/byonk/OneDrive/바탕 화면/BJH_data/git_data/R_data/"
DEC_2019 = fread(paste0(DIR, "2019-Dec.csv"))
head(DEC_2019, 3)
str(DEC_2019)

DEC_2019 = as.data.frame(DEC_2019)


#한명의 고객 기록만 뽑아서 확인
Customer_ID = unique(DEC_2019$user_id)
Customer_Example = Customer_ID[50]

Example_DF = DEC_2019 %>% 
  filter(user_id == Customer_Example) %>% 
  mutate(event_time2 = as.POSIXct(event_time)) %>% 
  arrange(event_time2) %>% 
  select(user_id, event_time2, event_type, product_id, category_id) %>% 
  as.data.frame()

knitr::kable(Example_DF)

#무작위로 1000명의 고객을 추출하고 데이터 정리
set.seed(1234)

Customer_Sample = sample(Customer_ID, 1000, replace = FALSE)

Sample_Data = DEC_2019 %>% 
  filter(user_id %in% Customer_Sample) %>% 
  mutate(event_type = factor(event_type,
          levels = c("view", "cart", "remove_from_cart",
                     "purchase"))) %>% 
  mutate(event_time2 = as.POSIXct(event_time)) %>% 
  select(user_id, event_time2, event_type, product_id,
         category_id, brand, price) %>% 
  arrange(user_id, event_time2)

Sample_Data = Sample_Data %>% 
  mutate(Day = format(event_time2, "%a"),
         Day = factor(Day, levels = c("일","월","화","수",
                                      "목","금","토")),
         Time = format(event_time2, "%H"),
         Time = as.numeric(Time),
         Time_G = ifelse(Time<9, "새벽",
                         ifelse(Time<13, "오전",
                         ifelse(Time<19, "오후", "저녁"))),
         Time_G = factor(Time_G, levels = c("새벽","오전","오후",
                                            "저녁")))

knitr::kable(head(Sample_Data, 10))

#데이터 시각화
Sample_Data %>% 
  ggplot() +
  geom_bar(aes(x=Day, fill = event_type)) +
  scale_fill_nejm() +
  xlab("") +
  theme_bw() +
  theme(legend.position = "bottom")

Sample_Data %>%
  group_by(Day, event_type) %>% 
  summarise(Count = n()) %>% 
  mutate(Perc = Count/sum(Count)*100) %>% 
  ggplot() +
  geom_bar(aes(x=Day, y=Perc, fill = event_type), stat = 'identity') +
  geom_text(aes(x=Day, y=Perc, label = round(Perc,2), fill = event_type),
            position = position_stack(0.5), col = "white", size = 5) +
  scale_fill_nejm() +
  xlab("") +
  theme_bw() +
  theme(legend.position = "bottom")


#시간대별 데이터 분석
Sample_Data %>% 
  ggplot() +
  geom_bar(aes(x=Time, fill=Time_G)) +
  scale_fill_nejm() +
  xlab("") +
  theme_bw() +
  theme(legend.position = "bottom")

#일별 데이터 분석
#구매난 추출해 매출액 시각화
Sample_Data %>% 
  filter(event_type == "purchase") %>% 
  mutate(Date = as.Date(event_time2)) %>% 
  group_by(Date) %>% 
  summarise(Count = n(),
            Price = sum(price)) %>% 
  ggplot() + 
  geom_point(aes(x=Date, y=Count)) +
  geom_line(aes(x=Date, y=Count)) +
  theme_bw() 


Sample_Data %>% 
  filter(event_type == "purchase") %>% 
  mutate(Date = as.Date(event_time2)) %>% 
  group_by(Date) %>% 
  summarise(Count = n(),
            Price = sum(price)) %>% 
  ggplot() + 
  geom_point(aes(x=Date, y=Price)) +
  geom_line(aes(x=Date, y=Price)) +
  theme_bw()







library(data.table)

DIR = "C:/Users/byonk/OneDrive/바탕 화면/BJH_data/git_data/R_data/bigdata/"
FILES = list.files(DIR)

for(k in 1:length(FILES)) {
  assign(gsub(".csv","",FILES[k]),
         fread(paste0(DIR, FILES[k])))
}

Total_DF = rbind(`2019-Oct`,`2019-Nov`,`2019-Dec`,`2020-Jan`,`2020-Feb`)

set.seed(1234)

Customer_ID2 = unique(Total_DF$user_id)
Customer_Sample2 = sample(Customer_ID2, 50000,replace = FALSE)
