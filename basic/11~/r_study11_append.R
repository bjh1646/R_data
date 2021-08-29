#mutate() 기존 데이터에 파생변수를 추가

# 1. 파일 열기 / 2. dplyr 체크(library 호출)
read.csv("csv_exam.csv")
library(dplyr)

exam %>% 
  mutate(total=math + english + science) %>%  #총합 
  head   #앞에서 6개

exam %>% 
  mutate(total=math + english + science, #총합
         mean = (math + english + science)/3) %>% #평균  
  head

exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%  
  head

exam %>% summarise(mean_math = mean(math))


# 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해
#내림차순으로 정렬, 1~5위까지 출력
# 1. 회사별 : group_by()
# 2. suv 추출 : filter()
# 3. 통합연비변수 생성 : mutate()
# 4. 통합연비 평균 산출 : summarise()
# 5. 내림차순 정렬 : arrange()
# 6. 1~5위까지 출력 : head

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(tot = (cty+hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)


# 중간고사 + 기말고사 합치기
test1 = data.frame(id = c (1,2,3,4,5),
                   midterm = c(60, 80, 70, 90, 85))
test1

test2 = data.frame(id = c (1,2,3,4,5),
                   final = c(70, 83, 65, 95, 80))
test2

total = left_join(test1, test2, by="id")
total
















