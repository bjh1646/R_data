install.packages("plotly")
library(plotly)

library(ggplot2)
p = ggplot(data = mpg, aes(x=displ, y=hwy, col=drv)) + 
  geom_point()

ggplotly(p)

p = ggplot(data = diamonds, aes(x=cut, fill=clarity)) + geom_bar(position = 'dodge')

ggplotly(p)


install.packages("dygraphs")
library(dygraphs)

economics = ggplot2::economics
head(economics)

dim(economics)

library(xts)
eco = xts(economics$unemploy, order.by = economics$date)
head(eco)

dygraph(eco)


#저축률
eco_a = xts(economics$psavert, order.by = economics$date)

#실업자 수
eco_b = xts(economics$unemploy/1000, order.by = economics$date)

#저축률과 실업자 수의 관계 비교
eco2 = cbind(eco_a, eco_b) 
colnames(eco2) = c("psavert", "unemploy")
head(eco2)
dygraph(eco2) %>% dyRangeSelector()


#통계학 t 검정
#compact : 경차 -> 두 차의 도시 연비 t 검정
mpg = as.data.frame(ggplot2::mpg)

library(dplyr)
mpg_diff = mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

head(mpg_diff)
table(mpg_diff$class)

t.test(data=mpg_diff, cty ~ class, var.equal = T)


mpg_diff2 = mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))  # r:regular, p:premium

table(mpg_diff2$fl)
t.test(data=mpg_diff2, cty ~ fl, var.equal = T)      #0.05미만


economics = as.data.frame(ggplot2::economics)
cor.test(economics$unemploy, economics$pce) #상관관계

head(mtcars)
car_cor = cor(mtcars) #상관관계
round(car_cor, 2)     #소수점 셋째 자리에서 반올림 

install.packages("corrplot")
library(corrplot)

corrplot(car_cor)
corrplot(car_cor, method = "number")

col=colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))


corrplot(car_cor,
         method = "color",        #색상으로 표현
         col = col(200),          #색상 200개 선정
         type = "lower",          #왼쪽 아래 행렬만 표시
         order = "hclust",        #유사한 상관관계끼리 군집화
         addCoef.col = "black",   #상관계수 색깔
         tl.col = "black",        #변수명 색상
         tl.srt = 45,             #변수명 45도 기울임
         diag = F)                #대각 행렬 제외

















