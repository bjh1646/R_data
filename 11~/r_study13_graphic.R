library(ggplot2)

#산점도 그래프
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()

#x축 범위 3-6 지정
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6)

#위와 같이 했을 때 y가 30을 넘지 않음
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6) + ylim(10,30)

#데이터와 축 + 그래픽 종류 + 세부항목으로 구성됨
#ggplot2은 +로 연결 // dplyr은 %>% 로 연결 

library(dplyr)

df_mpg = mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg

#막대그래프
ggplot(data = df_mpg, aes(x=drv, y=mean_hwy)) + geom_col()

#내림차순 정렬
ggplot(data = df_mpg, aes(x=reorder(drv, -mean_hwy), y=mean_hwy)) + geom_col()


#빈도 막대 그래프 : 값수 개수 (빈도)로 길이 표현
ggplot(data = mpg, aes(x=drv)) + geom_bar()

ggplot(data = mpg, aes(x=hwy)) + geom_bar()


#선 그래프 - 시간에 따른 데이터 변환
ggplot(data = economics, aes(x=date, y=unemploy)) + geom_line()


#box 그래프
ggplot(data = mpg, aes(x=drv, y=hwy)) + geom_boxplot()





