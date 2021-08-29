getwd()  # 경로확인후 디렉토리 지정

DIR = "C:/Users/byonk/OneDrive/바탕 화면/BJH_data/git_data/R_data/bigdata"

FILES = list.files(DIR)


install.packages("data.talble")
library(data.table)

for(k in 1:length(FILES)){
  
  assign(gsub(".csv","",FILES[k]),
         fread(paste0(DIR, FILES[k])))
  
}

Total_DF = rbind(`2019-Oct`,`2019-Nov`,`2019-Dec`,
                 `2020-Jan`,`2020-Feb`)

Customer_ID2 = unique(Total_DF$user_id)

set.seed(1234)
Customer_Sample2 = sample(Customer_ID2, 50000, replace = FALSE)



Sample_Data2 = Total_DF %>%
  filter(user_id %in% Customer_Sample2) %>%
  mutate(event_type = factor(event_type, 
                             levels = c("view","cart","remove_from_cart","purchase"))) %>%
  mutate(event_time2 = as.POSIXct(event_time)) %>%
  arrange(event_time2) %>%
  select(user_id,event_time2,event_type,product_id,category_id,brand, price) %>%
  arrange(user_id, event_time2)

Sample_Data2 = Sample_Data2 %>%
  mutate(Day = format(event_time2, "%a"),
         Day = factor(Day, levels = c("일","월","화","수",
                                      "목","금","토")),
         Time = format(event_time2, "%H"),
         Time = as.numeric(Time),
         Time_G = ifelse(Time < 9, "새벽",
                         ifelse(Time < 13, "오전",
                                ifelse(Time < 19, "오후","저녁"))),
         Time_G = factor(Time_G, levels = c("새벽","오전","오후","저녁")),
         Month = format(event_time2,"%m"),
         Month = as.numeric(Month),
         YM = paste0(format(event_time2,"%y"),"-",format(event_time2,"%m")))


Monthly = Sample_Data2 %>%
  filter(event_type == "purchase") %>%
  group_by(YM) %>%
  summarise(Price = sum(price),
            Count = n())

Monthly

Max_Count = max(Monthly$Count) * 5 

Sample_Data2 %>%
  filter(event_type == "purchase") %>%
  group_by(YM) %>%
  summarise(Price = sum(price),
            Count = n()) %>%
  ggplot() +
  geom_bar(aes(x = YM, y = Price), stat = 'identity', alpha = 0.5) +
  geom_line(aes(x = YM, y = Count * 5), group = 1, col = "red", size = 2) +
  geom_label(aes(x = YM, y = Price, label = Price)) +
  scale_y_continuous(sec.axis = sec_axis(~.*Max_Count, name="Sailing Count")) +
  theme_bw()



















