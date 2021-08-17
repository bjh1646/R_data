library(ggplot2)

Z1 = rnorm(n=500, mean = 0, sd=1)
Z1_2 = Z1^2

#자유도 1을 가지고 카이제곱 분포
ggplot(NULL) + 
  geom_density(aes(x=Z1_2, y=..density..)) +
  xlab("")+ylab("")+
  theme_bw()


#자유도 {1, 3, 5, 10}를 따르는 카이제곱
df_V = c()
Z2_V = c()

for (df in c(1, 3, 5, 10)) {
  
  Z_ADD = 0
  
  for(iteration in 1:df) {
    Z = rnorm(n = 500, mean = 0, sd=1)
    Z2 = Z^2
    Z_ADD = Z_ADD + Z2
  }
  
  Z2_V = c(Z2_V, Z_ADD)
  df_V = c(df_V, rep(df,500))
  
}

Chisq_DF = data.frame(
  df = df_V,
  Z2 = Z2_V
)

ggplot(Chisq_DF) +
  geom_density(aes(x=Z2, y=..density.., fill = as.factor(df)),
               alpha = 0.4) + 
  xlab("") + ylab("") + 
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(fill = "df")


#F분포 : 독립된 두 집단의 분산을 비교하는 것.
#        두 카이제곱 분포의 비로 정의

#자유도가(1,3), (10,1)을 따르는 F분포 2개를 생성 후 시각화
F_Value_13 = (Chisq_DF$Z2[Chisq_DF$df == 1] / 1) / (Chisq_DF$Z2[Chisq_DF$df == 3] / 3)
F_Value_101 = (Chisq_DF$Z2[Chisq_DF$df == 10] / 10) / (Chisq_DF$Z2[Chisq_DF$df == 1] / 1)

F_DF = data.frame(
  df = c(rep("1.3", length(F_Value_13)),
        rep("10.1", length(F_Value_101))),
  F_Value = c(F_Value_13, F_Value_101))

ggplot(F_DF) + 
  geom_density(aes(x=F_Value, y=..density.., fill=df),
               alpha=0.4) +
  xlim(0,20) +
  theme_bw() +
  xlab("") + ylab("") +
  theme(legend.position = "bottom")


#Student's t분포
#정규분포 : 모분산을 알 수 없는 상황에서는 정규분포를 이용해
#평균을 검정할 경우 분석의 신뢰성을 확보할 수가 없다.

#t분포는 모분산을 모르는 상황에서 평균 검정을 위해 고안된 분포임

#표준정규분포 Z에 대해 자유도가 n-1인 카이제곱 분포 V와 그 자유도
#v로 나눈 분포를 t 분포로 정의함.

kv = c()
z = c()
t = c()

for(k in seq(-6,6, by=0.01)) {
  
  n_dist = dnorm(x=k, mean = 0, sd=1)
  t_dist = dt(x=k, df=3)
  kv = c(kv,k)
  z = c(z,n_dist)
  t = c(t,t_dist)
  
}

DF = data.frame(
  k = kv,
  Z = z,
  t = t
)

library(dplyr)
library(reshape)

DF %>% 
  melt(id.vars = c("k")) %>% 
  ggplot() +
  geom_line(aes(x=k, y=value, col=as.factor(variable))) +
  geom_vline(xintercept = 0, linetype = 'dashed') +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(col = "Distribution") +
  xlab("") + ylab("")


#qnorm(), qt()는 정규분포와 t 분포의 분위수를 구함
#p=0.025는 2.5% 에 해당하는 분위수를 구하는 옵션임.
Z_Value = qnorm(p = 0.025, mean = 0, sd=1)
T_Value = qt(p = 0.025, df = 3)

DF$Z_CV = ifelse(DF$k < Z_Value | DF$k > Z_Value * (-1), DF$Z,0)
DF$T_CV = ifelse(DF$k < T_Value | DF$k > T_Value * (-1), DF$t,0)

ggplot(DF) + 
  geom_line(aes(x=k, y=Z), col = "blue") +
  geom_area(aes(x=k, y=Z_CV), fill = 'royalblue', alpha = 0.6) +
  geom_line(aes(x=k, y=t), col = 'red') +
  geom_area(aes(x=k, y=T_CV), fill = 'red', alpha = 0.6) +
  theme_bw() + ylab("") + xlab("")

#==> t분포는 양쪽 꼬리가 두꺼우면 표본 수가 적을 때 신뢰성을 더해줌.
#----------------------------------------------------------------------

#확률분포 함수
#난수생성 : r+분포명 : rnorm()
#확률밀도 : d+분포명 : dnorm()
#누적분포 : p+분포명 : pnorm()
#분위수   : q+분포명 : qnorm()

#정규분포 난수 생성 = rnorm()
RN = rnorm(n =100, mean = 0, sd = 1) #난수생성
hist(RN)

#t분포 난수 생성 - rt()
RT = rt(n = 100, df = 9)
hist(RT)

#카이제곱 분포 난수 생성 - rchisq()
RCH = rchisq(n = 100, df = 9)
hist(RCH)

#F 분포 난수 생성 - rf()
RF = rf(n = 100, df = 2, df2 = 3)
hist(RF)


#확률밀도
dnorm(x = 0.1, mean = 0, sd = 1)

# -> t분포 dt()를 이용해 자유도 9로 설정
dt(x = 0.1, df = 9)

#누적분포
pnorm(q = 0.1, mean = 0, sd = 1)

# -> 평균이 0인 것을 감안해 0으로 설정
#정확히 0.5가 계산됨.
pnorm(q = 0, mean = 0, sd = 1)






