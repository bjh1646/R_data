#ggplot2 시각화
#1. 도화지 준비
#2. 축 그리기
#3. 그래프 그리기
#4. 테마 설정
#5. 축, 색조정 등 기타 설정

#환경설정(준비)
library(ggplot2)
Audi = read.csv("audi.csv")

#1. 도화지 준비
ggplot()

#2. 축 그리기
ggplot(Audi, aes(x=year))

#3. 그래프 그리기
ggplot(Audi, aes(x=year)) + 
  geom_bar()

#4. 테마 설정
ggplot(Audi, aes(x=year)) + 
  geom_bar() +
  theme_classic()

#5. 축, 색조정 등 기타 설정
ggplot(Audi, aes(x=year)) + 
  geom_bar() +
  theme_classic() +
  theme(axis.text.x = element_text(size = 7, face = "bold"),
        axis.text.y = element_text(size = 8, face = "bold"),
        axis.title.x = element_text(size = 8, face = "bold"),
        axis.title.y = element_text(size = 7, face = "bold"))

# 축 text 간결하게
ggplot(Audi, aes(x=year)) + 
  geom_bar() +
  theme_classic() +
  theme(text = element_text(size = 7, face = "bold"))

# 그래프의 축 간격 조정
# 이산형일 경우에는 scale_x_discrete(), scale_y_discrete() 사용
ggplot(Audi, aes(x=year)) + 
  geom_bar() +
  theme_classic() +
  theme(axis.text.x = element_text(size = 7, face = "bold"),
        axis.text.y = element_text(size = 8, face = "bold"),
        axis.title.x = element_text(size = 8, face = "bold"),
        axis.title.y = element_text(size = 7, face = "bold")) +
  scale_x_continuous(breaks = seq(1990, 2020, by = 2),
                     expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 4000, by = 500),
                     expand = c(0,0))


#그래프 색 지정
ggplot(Audi, aes(x=year, fill = transmission)) + 
  geom_bar() +
  theme_classic() +
  theme(axis.text.x = element_text(size = 7, face = "bold"),
        axis.text.y = element_text(size = 8, face = "bold"),
        axis.title.x = element_text(size = 8, face = "bold"),
        axis.title.y = element_text(size = 7, face = "bold")) +
  scale_x_continuous(breaks = seq(1990, 2020, by = 2),
                     expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 4000, by = 500),
                     expand = c(0,0))


# 범례의 위치 조정
ggplot(Audi, aes(x=year, fill = transmission)) + 
  geom_bar() +
  theme_classic() +
  theme(axis.text.x = element_text(size = 7, face = "bold"),
        axis.text.y = element_text(size = 8, face = "bold"),
        axis.title.x = element_text(size = 8, face = "bold"),
        axis.title.y = element_text(size = 7, face = "bold"),
        legend.text = element_text(size = 8, face = "bold"),
        legend.title = element_text(size = 7, face = "bold"),
        legend.position = "bottom") +
  scale_x_continuous(breaks = seq(1990, 2020, by = 2),
                     expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 4000, by = 500),
                     expand = c(0,0)) +
  labs(fill = "TRANSMISSION")
