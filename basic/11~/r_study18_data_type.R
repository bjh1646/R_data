exam = read.csv("csv_exam.csv")
exam[]  #조건없이 전체 출력
exam[1,]  #1행 추출
exam[2,]  #2행 추출
exam[exam$class == 1, ]  #class가 1반
exam[exam$math >=80,]  #수학80점이상

#1반 이면서 수학점수가 50점 이상
exam[exam$class == 1 & exam$math >=50, ]

#영어 점수가 90점 미만 이면서 과학점수가 50점 미만
exam[exam$english <90 & exam$science <50,]

#-------------------------------------------------

#열에 대한 조건
exam[,1] #첫번째 열
exam[,2] #두번째 열  
 
exam[, "class"]  #class 변수 추출 
exam[,"math"] #math 변수 추출

exam[,c("class", "math", "english")]


#행열 같이
exam[1,3]
exam[5, "english"]
exam[exam$math >=50, "english"]
exam[exam$math >=50, c("english", "science")]



#dplyr과 내장함수
#내장함수
exam$tot = (exam$math + exam$english + exam$science)/3
aggregate(data=exam[exam$math >= 50 & exam$english >= 80,], tot~class, mean)

#dplyr코드
exam %>% 
  filter(math >= 50 & english >= 80) %>% 
  mutate(tot = (math + english + science)/3) %>% 
  group_by(class) %>% 
  summarise(mean = mean(tot))


var1 = c(1,2,3,1,2)
var2 = factor(c(1,2,3,1,2))
var1
var2


#연산에서
var1+2

var2+2 #연산이 안됨

#class()를 이용하면 변수의 타입확인 가능
class(var1)
class(var2)


#factor를 연산하고자 하면 numeric으로 변경
var3 = as.numeric(var2)
var3+2



#데이터 구조

#벡터
a = 1
a
b = "Hello"
b

#데이터 프레임
x1 = data.frame(var1=c(1,2,3),
                var2=c("a","b","c"))
x1

#매트릭스
x2 = matrix(c(1:12), ncol = 2)
x2

#어레이
x3 = array(1:20, dim = c(2,5,2))
x3

#리스트
x4 = list(f1 = a,    #벡터
          f2 = x1,   #데이터 프레임
          f3 = x2,   #매트릭스
          f4 = x3)   #어레이
x4


#example : boxplot() 출력결과 리스트 형태
mpg = ggplot2::mpg
x = boxplot(mpg$cty)
x





