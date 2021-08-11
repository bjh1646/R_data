library(ggplot2)
library(dplyr)
install.packages("reshape")
library(reshape)

Audi = read.csv("audi.csv")

# 확률
summary(as.factor(Audi$transmission))/nrow(Audi)

# Automatic 확률
#summary((Audi$transmission == "Automatic")/nrow(Audi))

# xtabs()를 활용한 교차표 만들기
Table = xtabs(~Audi$fuelType + Audi$transmission)
Table

Table[1,1]/colSums(Table)["Automatic"]


# 이항분포
Audi_NonHybrid = Audi %>% 
  filter(fuelType != "Hybrid")

ggplot(Audi_NonHybrid) +
  geom_bar(aes(x=fuelType, y=(..count..)/sum(..count..),
               fill = fuelType)) +
  theme_bw()+
  ylab("Rerc")


# 다항분포
ggplot(Audi) +
  geom_bar(aes(x=fuelType, y=(..count..)/sum(..count..),
               fill = fuelType)) +
  theme_bw()+
  ylab("Rerc")

# 정규분포
library(dplyr)

k1 = c()
p1 = c()

for(k in seq(-15, 15, by=0.01)) {
  p = dnorm(x = k, mean = 0, sd = 3)
  k1 = c(k1,k)
  p1 = c(p1,p)
}


k2 = c()
p2 = c()

for(k in seq(-15, 15, by=0.01)) {
  p = dnorm(x = k, mean = 0, sd = 5)
  k2 = c(k2,k)
  p2 = c(p2,p)
}


DF = data.frame(
  k = k1,
  p1 = p1,
  p2 = p2
)

DF %>% 
  melt(id.vars = c("k")) %>% 
  ggplot() +
  geom_line(aes(x=k, y=value, col=as.factor(variable))) + 
  geom_vline(xintercept = 0, linetype = "dashed") +
  theme_bw() +
  theme(legend.position = 'none') + 
  xlab("") + ylab("") +
  scale_y_continuous(expand = c(0,0))


# 카이제곱분포 : 분산의 특징을 나타내는 확률분포포
Z1 = rnorm(n = 500, mean = 0, sd = 1)
Z1_2 = Z1^2

ggplot(NULL) + 
  geom_density(aes(x=Z1_2, y=..density..)) +
  xlab("") + ylab("") +
  theme_bw()







